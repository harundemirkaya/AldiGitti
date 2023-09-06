// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously, unused_local_variable

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/ReceiveCargoViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/qr_receive_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';

class ReceiveCargoPage extends StatefulWidget {
  final String journeyID;
  final String userID;

  ReceiveCargoPage({
    super.key,
    required this.journeyID,
    required this.userID,
  });

  @override
  State<ReceiveCargoPage> createState() => _ReceiveCargoPageState();
}

class _ReceiveCargoPageState extends State<ReceiveCargoPage> {
  ReceiveCargoViewModel viewModel = ReceiveCargoViewModel();
  Map<String, dynamic>? reservationDetails;

  Future<void> fetchReservationDetails() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);
    Map<String, dynamic>? reservationDetails = await viewModel
        .fetchReservationDetails(widget.userID, widget.journeyID);

    setState(() {
      this.reservationDetails = reservationDetails;
    });
    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  @override
  void initState() {
    super.initState();
    fetchReservationDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryNavigationBar(
              backButton: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Kargo Nereden Alınacak",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Açık Adres: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['fromAddress'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Bina No: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['fromBuildingNo'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Kat: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['fromFloor'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Daire: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['fromApartmentNo'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Kargo Nereye Teslim Edilecek",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Açık Adres: ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['toAddress'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Bina No: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['toBuildingNo'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Kat: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['toFloor'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Daire: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reservationDetails?['toApartmentNo'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryNextButton(
              isDoubleInfinity: true,
              buttonText: "Rezervasyon Sahibi ile İletişime Geç",
              onPressed: () async {
                String number = reservationDetails?['fromPhone'];
                bool? res = await FlutterPhoneDirectCaller.callNumber(number);
              },
            ),
            SizedBox(
              height: 10,
            ),
            PrimaryNextButton(
              isDoubleInfinity: true,
              bgColor: Colors.green,
              buttonText: "Kargoyu Al",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRReceivePage(
                      journeyID: widget.journeyID,
                      reservationUserID: widget.userID,
                      confirmReservationKey:
                          reservationDetails?['reservationKey'],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
