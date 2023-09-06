// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/ViewModels/DeliverCargoViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DeliverCargoPage extends StatefulWidget {
  final String journeyID;
  final String reservationKey;
  final String paymentStatus;

  const DeliverCargoPage({
    super.key,
    required this.reservationKey,
    required this.paymentStatus,
    required this.journeyID,
  });

  @override
  _DeliverCargoPageState createState() => _DeliverCargoPageState();
}

class _DeliverCargoPageState extends State<DeliverCargoPage> {
  DeliverCargoViewModel viewModel = DeliverCargoViewModel();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.listenToReservationStatus(widget.journeyID, context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(
            backButton: true,
          ),
          SizedBox(
            height: screenSize.height / 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (widget.paymentStatus == "Ödemesi Alındı")
                      ? QrImageView(
                          data: widget.reservationKey,
                          version: QrVersions.auto,
                          size: 200.0,
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 30,
                          ),
                          child: Column(
                            children: [
                              PrimaryTextField(
                                controller: cardNameController,
                                icon: Icons.person,
                                placeholderText: "Kart Üzerindeki İsim",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              PrimaryTextField(
                                controller: cardNumberController,
                                icon: Icons.credit_card,
                                placeholderText: "Kart Numarası",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryTextField(
                                      controller: expiryDateController,
                                      icon: Icons.date_range,
                                      placeholderText: "(AA/YY)",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: PrimaryTextField(
                                      controller: cvvController,
                                      icon: Icons.lock_outline,
                                      placeholderText: "CVV",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              PrimaryNextButton(
                                buttonText: "Ödeme Yap",
                                onPressed: () {},
                                isDoubleInfinity: true,
                              )
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
