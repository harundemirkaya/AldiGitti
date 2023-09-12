// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/Views/Helpers/PrimaryJourney.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/journey_detail.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class JourneysPage extends StatefulWidget {
  final List<Journey> journeys;
  const JourneysPage({super.key, required this.journeys});

  @override
  State<JourneysPage> createState() => _JourneysPageState();
}

class _JourneysPageState extends State<JourneysPage> {
  List<Journey> sortedJourneys = [];

  @override
  void initState() {
    super.initState();
    sortedJourneys = List.from(widget.journeys);
  }

  void sortJourneys(int sortType) {
    sortedJourneys = List.from(widget.journeys);
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    setState(
      () {
        if (sortType == 1) {
          sortedJourneys
              .sort((a, b) => a.departureTime.compareTo(b.departureTime));
        } else if (sortType == 2) {
          sortedJourneys.sort((a, b) => a.price.compareTo(b.price));
        } else if (sortType == 3) {
          List<double> distances = [];

          for (var journey in sortedJourneys) {
            double distance = Geolocator.distanceBetween(
                  dataProvider.customerFromLat,
                  dataProvider.customerFromLong,
                  journey.fromLatitude,
                  journey.fromLongitude,
                ) /
                1000;
            distances.add(distance);
          }

          setState(() {
            sortedJourneys.sort((a, b) {
              var distanceA = Geolocator.distanceBetween(
                    dataProvider.customerFromLat,
                    dataProvider.customerFromLong,
                    a.fromLatitude,
                    a.fromLongitude,
                  ) /
                  1000;

              var distanceB = Geolocator.distanceBetween(
                    dataProvider.customerFromLat,
                    dataProvider.customerFromLong,
                    b.fromLatitude,
                    b.fromLongitude,
                  ) /
                  1000;

              return distanceA.compareTo(distanceB);
            });
          });
        } else if (sortType == 4) {
          setState(() {
            sortedJourneys.sort((a, b) {
              var distanceA = Geolocator.distanceBetween(
                    dataProvider.customerToLat,
                    dataProvider.customerToLong,
                    a.toLatitude,
                    a.toLongitude,
                  ) /
                  1000;

              var distanceB = Geolocator.distanceBetween(
                    dataProvider.customerToLat,
                    dataProvider.customerToLong,
                    b.toLatitude,
                    b.toLongitude,
                  ) /
                  1000;

              return distanceA.compareTo(distanceB);
            });
          });
        } else if (sortType == 5) {
          sortedJourneys = sortedJourneys.where((journey) {
            return isTimeInRange(journey.departureTime,
                start: "12:00", end: "18:00");
          }).toList();
        } else if (sortType == 6) {
          sortedJourneys = sortedJourneys.where((journey) {
            return isTimeInRange(journey.departureTime,
                start: "18:00", end: "11:59");
          }).toList();
        }
      },
    );
  }

  bool isTimeInRange(String timeStr,
      {required String start, required String end}) {
    var timeParts = timeStr.split(':');
    var hour = int.parse(timeParts[0]);
    var minute = int.parse(timeParts[1]);

    var now = DateTime.now();
    var time = DateTime(now.year, now.month, now.day, hour, minute);

    var startParts = start.split(':');
    var startHour = int.parse(startParts[0]);
    var startMinute = int.parse(startParts[1]);
    var startTime =
        DateTime(now.year, now.month, now.day, startHour, startMinute);

    var endParts = end.split(':');
    var endHour = int.parse(endParts[0]);
    var endMinute = int.parse(endParts[1]);
    var endTime = DateTime(
      now.year,
      now.month,
      now.day + (endHour < startHour ? 1 : 0),
      endHour,
      endMinute,
    );

    return time.isAfter(startTime) && time.isBefore(endTime);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(
            backButton: true,
            filterButton: true,
            onSortSelected: sortJourneys,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.05,
              ),
              child: ListView.builder(
                itemCount: sortedJourneys.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JourneyDetail(
                              journey: sortedJourneys[index],
                            ),
                          ),
                        );
                      },
                      child: PrimaryJourney(journey: sortedJourneys[index]),
                    ),
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
