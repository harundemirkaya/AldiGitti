// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/ViewModels/PublishViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/success_reservation_page.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          PrimaryNavigationBar(backButton: true),
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
                  "Kalkış Saati - Varış Saati",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${dataProvider.driverDepartureTime} - ${dataProvider.driverArrivalTime}",
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
                      fromName: dataProvider.driverFromName,
                      toLatitude: dataProvider.driverToLat,
                      toLongitude: dataProvider.driverToLong,
                      toName: dataProvider.driverToName,
                      date: dataProvider.driverDate,
                      cargoType: dataProvider.driverCargoType,
                      maxDesi: dataProvider.driverDesi,
                      price: dataProvider.driverPrice,
                      departureTime: dataProvider.driverDepartureTime,
                      arrivalTime: dataProvider.driverArrivalTime,
                    );
                    if (isPublish) {
                      dataProvider.driverReset();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessReservationPage(
                            title: "Yolculuk Başarıyla Yayınlandı",
                            description:
                                "Rezervasyon İsteklerinizi Kontrol Ediniz",
                            buttonText: "Yolculuklarımı Gör",
                          ),
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
