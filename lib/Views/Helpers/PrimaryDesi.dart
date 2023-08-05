// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class PrimaryDesi extends StatefulWidget {
  const PrimaryDesi({super.key});

  @override
  State<PrimaryDesi> createState() => _PrimaryDesiState();
}

class _PrimaryDesiState extends State<PrimaryDesi> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 80 / 812,
      width: screenSize.width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(246, 246, 246, 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Text(
              "Desi",
              style: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(144, 144, 144, 1)),
            ),
            Text(
              "2",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
