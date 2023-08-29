// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryJourney extends StatefulWidget {
  final Journey journey;
  const PrimaryJourney({super.key, required this.journey});

  @override
  State<PrimaryJourney> createState() => _PrimaryJourneyState();
}

class _PrimaryJourneyState extends State<PrimaryJourney> {
  Duration calculateDuration(String departure, String arrival) {
    DateTime departureTime = DateTime.parse("2023-08-21 $departure");
    DateTime arrivalTime = DateTime.parse("2023-08-21 $arrival");
    return departureTime.difference(arrivalTime);
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = calculateDuration(
        widget.journey.departureTime, widget.journey.arrivalTime);
    String durationStr =
        "${duration.inHours} Saat ${duration.inMinutes.remainder(60)} Dakika";

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
              child: Text(widget.journey.driverName),
            ),
            Row(
              children: [
                SizedBox(
                  width: screenSize.width * 0.2,
                  child: Column(
                    children: [
                      Text(
                        widget.journey.fromName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.journey.departureTime,
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
                      SizedBox(
                        height: 15,
                      ),
                      SvgPicture.asset("lib/assets/images/journey-line.svg"),
                      Text(
                        durationStr,
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
                        widget.journey.toName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.journey.arrivalTime,
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
                      "Max ${widget.journey.maxDesi} Desi, ${widget.journey.cargoType.join(', ')}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${widget.journey.price.toString()} ₺",
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
