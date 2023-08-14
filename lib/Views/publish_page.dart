// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Views/Helpers/PrimaryCargoType.dart';
import 'package:aldigitti/Views/Helpers/PrimaryDesi.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFrom.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFromDate.dart';
import 'package:flutter/material.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(onlyBackButton: false),
          Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: screenSize.width * 0.05,
              right: screenSize.width * 0.05,
            ),
            child: Column(
              children: [
                PrimaryToFrom(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    PrimaryToFromDate(),
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
                    placeholderText: "Fiyat"),
                SizedBox(
                  height: 20,
                ),
                PrimaryNextButton(
                  buttonText: "Yayınla",
                  onPressed: () {},
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