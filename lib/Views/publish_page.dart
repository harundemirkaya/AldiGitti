// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/ViewModels/PublishViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryCargoType.dart';
import 'package:aldigitti/Views/Helpers/PrimaryDesi.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimarySetClock.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFrom.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFromDate.dart';
import 'package:aldigitti/Views/journey_control_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  TextEditingController priceController = TextEditingController();

  bool vehicleStatus = false;

  PublishViewModel viewModel = PublishViewModel();

  Future<void> checkVehicles() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);

    bool status = await viewModel.checkForApprovedVehicle();
    setState(() {
      vehicleStatus = status;
    });

    Provider.of<AppProvider>(context, listen: false).hideLoading();

    if (!vehicleStatus) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Uyarı'),
            content: Text(
                'Yolculuk İlanı Yayınlayabilmek İçin Bir Araç Tanımlamalısınız. Aracınızın Onaylanması Ardından İlan Yayınlayabilirsiniz.'),
            actions: [
              TextButton(
                onPressed: () {
                  final appProvider =
                      Provider.of<AppProvider>(context, listen: false);
                  appProvider.setBottomNavBarIndex(3);
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).hideLoading();
    checkVehicles();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(backButton: false),
          Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: screenSize.width * 0.05,
              right: screenSize.width * 0.05,
            ),
            child: Column(
              children: [
                PrimaryToFrom(
                  isPublisher: true,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    PrimaryToFromDate(
                      isPublisher: true,
                    ),
                    Spacer(),
                    PrimaryCargoType(
                      isPublisher: true,
                    ),
                    Spacer(),
                    PrimaryDesi(
                      isPublisher: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                PrimaryTextField(
                  controller: priceController,
                  icon: Icons.payments,
                  placeholderText: "Fiyat",
                  onChanged: (String value) {
                    setState(() {
                      if (value != "") {
                        dataProvider.setDriverPrice(double.parse(value));
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                PrimarySetClock(),
                SizedBox(
                  height: 20,
                ),
                PrimaryNextButton(
                  buttonText: "Yayınla",
                  onPressed: () {
                    if (dataProvider.driverToName != "Nereye" &&
                        dataProvider.driverFromName != "Nereden" &&
                        dataProvider.driverCargoType.isNotEmpty &&
                        dataProvider.driverDesi != 0 &&
                        dataProvider.driverPrice != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JourneyControlPage(),
                        ),
                      );
                    }
                  },
                  isDoubleInfinity: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
