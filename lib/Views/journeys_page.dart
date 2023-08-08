// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Views/Helpers/PrimaryJourney.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:flutter/material.dart';

class JourneysPage extends StatefulWidget {
  const JourneysPage({super.key});

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
          PrimaryNavigationBar(onlyBackButton: true),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.05,
              ),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: PrimaryJourney(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
