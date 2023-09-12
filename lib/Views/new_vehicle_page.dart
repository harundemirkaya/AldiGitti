// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:aldigitti/Models/VehicleModel.dart';
import 'package:aldigitti/ViewModels/NewVehicleViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryScreenWrapper.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewVehiclePage extends StatefulWidget {
  const NewVehiclePage({super.key});

  @override
  State<NewVehiclePage> createState() => _NewVehiclePageState();
}

class _NewVehiclePageState extends State<NewVehiclePage> {
  TextEditingController vehicleBrandController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehiclePlateController = TextEditingController();
  TextEditingController vehicleYearController = TextEditingController();
  TextEditingController vehiclePolicyController = TextEditingController();
  TextEditingController vehicleDriveLicenceController = TextEditingController();
  TextEditingController vehiclePermitLicenceController =
      TextEditingController();

  NewVehicleViewModel viewModel = NewVehicleViewModel();
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryNavigationBar(
              backButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yeni Araç Ekle",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryTextField(
                        controller: vehicleBrandController,
                        icon: Icons.drive_eta,
                        placeholderText: "Araç Markası",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryTextField(
                        controller: vehicleModelController,
                        icon: Icons.car_crash,
                        placeholderText: "Araç Modeli",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryTextField(
                        controller: vehiclePlateController,
                        icon: Icons.numbers,
                        placeholderText: "Araç Plakası",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryTextField(
                        controller: vehicleYearController,
                        icon: Icons.calendar_month,
                        placeholderText: "Araç Yılı",
                        isNumber: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryTextField(
                        controller: vehiclePolicyController,
                        icon: Icons.save,
                        placeholderText: "Araç Sigorta Poliçesi",
                        isDocument: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryTextField(
                        controller: vehicleDriveLicenceController,
                        icon: Icons.save,
                        placeholderText: "Ehliyet",
                        isDocument: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryTextField(
                        controller: vehiclePermitLicenceController,
                        icon: Icons.save,
                        placeholderText: "Ruhsat",
                        isDocument: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryNextButton(
                        buttonText: "Araç Ekle",
                        onPressed: () async {
                          if (vehicleBrandController.text.isNotEmpty &&
                              vehicleModelController.text.isNotEmpty &&
                              vehiclePlateController.text.isNotEmpty &&
                              vehicleYearController.text.isNotEmpty &&
                              vehiclePolicyController.text.isNotEmpty &&
                              vehicleDriveLicenceController.text.isNotEmpty &&
                              vehiclePermitLicenceController.text.isNotEmpty) {
                            Map<bool, String> isSuccess =
                                await viewModel.addVehicle(
                              Vehicle(
                                id: Uuid().v4(),
                                brand: vehicleBrandController.text,
                                model: vehicleModelController.text,
                                plate: vehiclePlateController.text,
                                year: int.parse(
                                  vehicleYearController.text,
                                ),
                                policyUrl: vehiclePolicyController.text,
                                driveLicenceUrl:
                                    vehicleDriveLicenceController.text,
                                permitUrl: vehiclePermitLicenceController.text,
                                status: "Onay Bekliyor",
                              ),
                            );

                            if (isSuccess.keys.first) {
                              Navigator.pop(context, true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(isSuccess.values.first),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Lütfen Tüm Alanları Doldurunuz"),
                              ),
                            );
                          }
                        },
                        isDoubleInfinity: true,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
