// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:aldigitti/ViewModels/JourneyDetailViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:aldigitti/Views/success_reservation_page.dart';
import 'package:flutter/material.dart';

// ... [diğer import'larınız]

class ReservationDetailsPage extends StatefulWidget {
  final String journeyID;
  const ReservationDetailsPage({super.key, required this.journeyID});

  @override
  State<ReservationDetailsPage> createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  TextEditingController fromAddressController = TextEditingController();
  TextEditingController fromBuildingNoController = TextEditingController();
  TextEditingController fromFloorController = TextEditingController();
  TextEditingController fromApartmentNoController = TextEditingController();
  TextEditingController fromPhoneController = TextEditingController();

  TextEditingController toAddressController = TextEditingController();
  TextEditingController toBuildingNoController = TextEditingController();
  TextEditingController toFloorController = TextEditingController();
  TextEditingController toApartmentNoController = TextEditingController();
  TextEditingController toPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    JourneyDetailViewModel viewModel = JourneyDetailViewModel();
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            PrimaryNavigationBar(
              backButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kargo Nereden Alınacak",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      PrimaryTextField(
                        controller: fromAddressController,
                        icon: Icons.location_pin,
                        placeholderText: "Açık Adres",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: fromBuildingNoController,
                        icon: Icons.apartment,
                        placeholderText: "Bina Numarası",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: fromFloorController,
                        icon: Icons.home_max,
                        placeholderText: "Kat",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: fromApartmentNoController,
                        icon: Icons.home,
                        placeholderText: "Daire Numarası",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: fromPhoneController,
                        icon: Icons.call,
                        placeholderText: "Telefon Numarası",
                        isTelephoneNumber: true,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Kargo Nereye Teslim Edilecek",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      PrimaryTextField(
                        controller: toAddressController,
                        icon: Icons.location_pin,
                        placeholderText: "Açık Adres",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: toBuildingNoController,
                        icon: Icons.apartment,
                        placeholderText: "Bina Numarası",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: toFloorController,
                        icon: Icons.home_max,
                        placeholderText: "Kat",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: toApartmentNoController,
                        icon: Icons.home,
                        placeholderText: "Daire Numarası",
                      ),
                      SizedBox(height: 10),
                      PrimaryTextField(
                        controller: toPhoneController,
                        icon: Icons.call,
                        placeholderText: "Telefon Numarası",
                        isTelephoneNumber: true,
                      ),
                      Text(
                        "Kargonuz teslim edilirken teslim alıcı kişinin telefon numarasına kod gönderilecektir.",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryNextButton(
                        buttonText: "Rezervasyon İsteği Gönder",
                        isDoubleInfinity: true,
                        onPressed: () async {
                          if (fromAddressController.text.isNotEmpty &&
                              fromBuildingNoController.text.isNotEmpty &&
                              fromFloorController.text.isNotEmpty &&
                              fromApartmentNoController.text.isNotEmpty &&
                              fromPhoneController.text.isNotEmpty &&
                              toAddressController.text.isNotEmpty &&
                              toBuildingNoController.text.isNotEmpty &&
                              toFloorController.text.isNotEmpty &&
                              toApartmentNoController.text.isNotEmpty &&
                              toPhoneController.text.isNotEmpty) {
                            List<dynamic> isReservationSuccess =
                                await viewModel.addReservation(
                              widget.journeyID,
                              fromAddressController.text,
                              fromBuildingNoController.text,
                              fromFloorController.text,
                              fromApartmentNoController.text,
                              fromPhoneController.text,
                              toAddressController.text,
                              toBuildingNoController.text,
                              toFloorController.text,
                              toApartmentNoController.text,
                              toPhoneController.text,
                            );

                            if (isReservationSuccess[0]) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SuccessReservationPage(
                                    title: "Rezervasyon Başarılı",
                                    description:
                                        "Sürücü rezervasyonunu en kısa sürede değerlendirecek.",
                                    buttonText: "Rezervasyonlarımı Gör",
                                  ),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Hata"),
                                    content: Text(isReservationSuccess[1]),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Tamam'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Hata"),
                                  content:
                                      Text("Lütfen tüm alanları doldurun."),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Tamam'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
