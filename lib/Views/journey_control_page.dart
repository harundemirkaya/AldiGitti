// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/Providers/UserProvider.dart';
import 'package:aldigitti/ViewModels/PublishViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class JourneyControlPage extends StatefulWidget {
  const JourneyControlPage({super.key});

  @override
  State<JourneyControlPage> createState() => _JourneyControlPageState();
}

class _JourneyControlPageState extends State<JourneyControlPage> {
  PublishViewModel viewModel = PublishViewModel();
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          PrimaryNavigationBar(onlyBackButton: true),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nereden",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dataProvider.driverFromName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Nereye",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dataProvider.driverToName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tarih",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dataProvider.driverDate,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kabul Edilen Kargo Tipleri",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dataProvider.driverCargoType.join(', '),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kabul Edilen Maksimum Desi",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dataProvider.driverDesi.toString() + " Desi",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Fiyat",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dataProvider.driverPrice.toString() + " ₺",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryNextButton(
                  buttonText: "Yayınla",
                  onPressed: () async {
                    bool isPublish = await viewModel.addJourney(
                      fromLatitude: dataProvider.driverFromLat,
                      fromLongitude: dataProvider.driverFromLong,
                      toLatitude: dataProvider.driverToLat,
                      toLongitude: dataProvider.driverToLong,
                      date: dataProvider.driverDate,
                      cargoType: dataProvider.driverCargoType,
                      maxDesi: dataProvider.driverDesi,
                      driverID: userProvider.user!.uid,
                    );
                    if (isPublish) {
                      Navigator.pop(context);
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