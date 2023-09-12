// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Models/VehicleModel.dart';
import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/MyVehiclesViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryVehicleRow.dart';
import 'package:aldigitti/Views/new_vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyVehiclesPage extends StatefulWidget {
  const MyVehiclesPage({super.key});

  @override
  State<MyVehiclesPage> createState() => _MyVehiclesPageState();
}

class _MyVehiclesPageState extends State<MyVehiclesPage> {
  MyVehiclesViewModel viewModel = MyVehiclesViewModel();
  List<Vehicle>? userVehicles = [];

  Future<void> fetchVehicles() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);

    List<Vehicle>? vehicles = await viewModel.getUserVehicles();

    if (!mounted) return;

    setState(() {
      userVehicles = vehicles;
    });

    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).hideLoading();
    fetchVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: userVehicles == null || userVehicles!.isEmpty
            ? Column(
                children: [
                  Spacer(),
                  Image.asset(
                    "lib/assets/images/my-car-icon.png",
                    width: 190,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sisteme Kayıtlı Bir Aracınız Bulunmamaktadır",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrimaryNextButton(
                    buttonText: "Araç Ekle",
                    onPressed: () async {
                      bool isSuccess = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewVehiclePage(),
                        ),
                      );

                      if (isSuccess) {
                        setState(
                          () {
                            fetchVehicles();
                          },
                        );
                      }
                    },
                  ),
                  Spacer(),
                ],
              )
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Araçlarım",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              bool isSuccess = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewVehiclePage(),
                                ),
                              );

                              if (isSuccess) {
                                setState(
                                  () {
                                    fetchVehicles();
                                  },
                                );
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text(
                                  "Araç Ekle",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: fetchVehicles,
                          child: ListView.builder(
                            itemCount: userVehicles!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: PrimaryVehicleRow(
                                    brand: userVehicles![index].brand ?? "",
                                    model: userVehicles![index].model ?? "",
                                    year: userVehicles![index].year ?? 0,
                                    licensePlate:
                                        userVehicles![index].plate ?? "",
                                    status: userVehicles![index].status ?? "",
                                    id: userVehicles![index].id ?? "",
                                    onDelete: fetchVehicles,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
