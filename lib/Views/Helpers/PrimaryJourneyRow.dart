// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_is_not_empty

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryJourneyRow extends StatefulWidget {
  final bool isReservation;
  final String date;
  final String fromName;
  final String toName;
  final String status;
  final List<dynamic> reservations;

  const PrimaryJourneyRow({
    super.key,
    required this.date,
    required this.fromName,
    required this.toName,
    required this.isReservation,
    required this.status,
    required this.reservations,
  });

  @override
  State<PrimaryJourneyRow> createState() => _PrimaryJourneyRowState();
}

class _PrimaryJourneyRowState extends State<PrimaryJourneyRow> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isReservation
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timelapse_outlined,
                                size: 20,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.status,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider()
                        ],
                      )
                    : SizedBox(
                        child: (!widget.reservations.isEmpty)
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.notifications,
                                        size: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Yeni Rezervasyon İsteği",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                ],
                              )
                            : SizedBox(),
                      ),
                Text(
                  widget.date,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: screenSize.width * 0.9,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "lib/assets/images/location-line.svg",
                            height: 50,
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.fromName,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            Text(
                              widget.toName,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
