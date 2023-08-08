// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryJourney extends StatefulWidget {
  const PrimaryJourney({super.key});

  @override
  State<PrimaryJourney> createState() => _PrimaryJourneyState();
}

class _PrimaryJourneyState extends State<PrimaryJourney> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text("Hamza AKGÜL"),
            ),
            Row(
              children: [
                SizedBox(
                  width: screenSize.width * 0.2,
                  child: Column(
                    children: [
                      Text(
                        "İstanbul",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "09:45",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: screenSize.width * 0.4,
                  child: Column(
                    children: [
                      Text(
                        "3.5 SAAT",
                        overflow: TextOverflow.ellipsis,
                      ),
                      SvgPicture.asset("lib/assets/images/journey-line.svg"),
                      Text(
                        "1 STOP",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: screenSize.width * 0.2,
                  child: Column(
                    children: [
                      Text(
                        "Balıkesir",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "13:15",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: screenSize.width * 0.8,
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "Max 5 Desi - Belge, Paket",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "1220₺",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(86, 105, 255, 1),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
