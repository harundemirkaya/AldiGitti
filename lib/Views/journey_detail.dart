// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/ViewModels/JourneyDetailViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/message_chat_page.dart';
import 'package:aldigitti/Views/success_reservation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class JourneyDetail extends StatefulWidget {
  final Journey journey;
  const JourneyDetail({
    super.key,
    required this.journey,
  });

  @override
  State<JourneyDetail> createState() => _JourneyDetailState();
}

class _JourneyDetailState extends State<JourneyDetail> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    JourneyDetailViewModel viewModel = JourneyDetailViewModel();
    double distanceFrom = Geolocator.distanceBetween(
            dataProvider.customerFromLat,
            dataProvider.customerFromLong,
            widget.journey.fromLatitude,
            widget.journey.fromLongitude) /
        1000;
    double distanceTo = Geolocator.distanceBetween(
            dataProvider.customerToLat,
            dataProvider.customerToLong,
            widget.journey.toLatitude,
            widget.journey.toLongitude) /
        1000;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          PrimaryNavigationBar(backButton: true),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.journey.date,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              Text(
                                widget.journey.departureTime,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                widget.journey.arrivalTime,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              "lib/assets/images/col-line-journey.svg",
                              height: 150,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 150,
                          width: screenSize.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.journey.fromName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Kalkış Noktasına ${distanceFrom.toStringAsFixed(2)} km uzaklıkta",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Spacer(),
                              Text(
                                widget.journey.toName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Varış Noktasına ${distanceTo.toStringAsFixed(2)} km uzaklıkta",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Kabul Edilebilir Kargo Türleri",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.journey.cargoType.join(", "),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Kabul Edilebilir Maksimum Desi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.journey.maxDesi.toString()} Desi",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Kargo Ücreti",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.journey.price} ₺",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sürücü",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.journey.driverName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/63802051?v=4",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    PrimaryNextButton(
                      isDoubleInfinity: true,
                      buttonText: "Sürücü ile İrtibata Geç",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageChatPage(
                              uid: widget.journey.driverID,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryNextButton(
                      isDoubleInfinity: true,
                      buttonText: "Rezervasyon İsteği Gönder",
                      onPressed: () async {
                        bool isReservationSuccess = await viewModel
                            .addReservation(widget.journey.journeyId);
                        if (isReservationSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessReservationPage(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
