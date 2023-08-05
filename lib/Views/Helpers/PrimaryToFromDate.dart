// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrimaryToFromDate extends StatefulWidget {
  const PrimaryToFromDate({super.key});

  @override
  State<PrimaryToFromDate> createState() => _PrimaryToFromDateState();
}

class _PrimaryToFromDateState extends State<PrimaryToFromDate> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    return Container(
      height: screenSize.height * 80 / 812,
      width: screenSize.width * 0.3,
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
              "Tarih",
              style: TextStyle(
                  fontSize: 16, color: Color.fromRGBO(144, 144, 144, 1)),
            ),
            Text(
              formattedDate,
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
