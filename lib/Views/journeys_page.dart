// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryJourney.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/journey_detail.dart';
import 'package:flutter/material.dart';

class JourneysPage extends StatefulWidget {
  final List<Journey> journeys;
  const JourneysPage({super.key, required this.journeys});

  @override
  State<JourneysPage> createState() => _JourneysPageState();
}

class _JourneysPageState extends State<JourneysPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(backButton: true, filterButton: true),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.05,
              ),
              child: ListView.builder(
                itemCount: widget.journeys.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JourneyDetail(
                                journey: widget.journeys[index],
                              ),
                            ),
                          );
                        },
                        child: PrimaryJourney(journey: widget.journeys[index]),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
