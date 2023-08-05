// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aldigitti/Views/Helpers/PrimaryCargoType.dart';
import 'package:aldigitti/Views/Helpers/PrimaryDesi.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFrom.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFromDate.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PrimaryNavigationBar(),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(
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
                        PrimaryCargoType(),
                        Spacer(),
                        PrimaryDesi(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryNextButton(
                      buttonText: "Ara",
                      onPressed: () {},
                      isDoubleInfinity: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
