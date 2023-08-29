// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/JourneyPlanViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryJourneyRow.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/journey_detail.dart';
import 'package:aldigitti/Views/reservation_invitations_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JourneyPlanPage extends StatefulWidget {
  final Map<String, dynamic> journey;
  final bool isReservation;

  JourneyPlanPage({
    Key? key,
    required this.journey,
    required this.isReservation,
  }) : super(key: key);

  @override
  State<JourneyPlanPage> createState() => _JourneyPlanPageState();
}

class _JourneyPlanPageState extends State<JourneyPlanPage> {
  final JourneyPlanViewModel viewModel = JourneyPlanViewModel();
  Map<String, String> reservationUserNames = {};

  Future<void> fetchReservationUserNames() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);

    Map<String, String> userNames = await viewModel.getReservationNamesWithUIDs(
        widget.isReservation
            ? widget.journey['journeyID']
            : widget.journey['journeyId']);
    setState(() {
      reservationUserNames = userNames;
    });

    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchReservationUserNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryNavigationBar(
            backButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yolculuk Planı",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (widget.journey['reservationInvitations'] != null &&
                        widget
                            .journey['reservationInvitations'].isNotEmpty) ...[
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationInvitationsPage(
                                reservationInvitations:
                                    widget.journey['reservationInvitations'],
                                journeyID: widget.journey['journeyId'],
                              ),
                            ),
                          );
                          setState(() {
                            fetchReservationUserNames();
                          });
                        },
                        child: SizedBox(
                          height: screenSize.height * 0.1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Theme.of(context).primaryColor,
                                size: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    "Rezervasyon İstekleriniz Mevcut",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Rezervasyon İsteklerinizi Görüntüleyin",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                    PrimaryJourneyRow(
                      isReservation: false,
                      date: widget.journey['date'],
                      fromName: widget.journey['fromName'],
                      toName: widget.journey['toName'],
                      status: '',
                      reservationInvitations: [],
                      reservations: [],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Rezervasyonlar",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (reservationUserNames.isNotEmpty)
                      ...reservationUserNames.entries.map((entry) {
                        String userID = entry.key;
                        String userName = entry.value;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/63802051?v=4",
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text(userName)),
                                (!widget.isReservation)
                                    ? Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // TO DO
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Icon(
                                                Icons.message,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Rezervasyon İptali"),
                                                    content: Text(
                                                        "Rezervasyon İptal Edilecektir. Onaylıyor musunuz?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('Evet'),
                                                        onPressed: () async {
                                                          await viewModel
                                                              .removeUserFromJourneyReservations(
                                                                  widget.journey[
                                                                      'journeyId'],
                                                                  userID);
                                                          setState(() {
                                                            reservationUserNames
                                                                .remove(userID);
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }).toList()
                    else
                      Text("Rezervasyon bulunmamaktadır."),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: PrimaryNextButton(
                buttonText: "Yolculuğu Görüntüle",
                onPressed: () async {
                  Journey? selectedJourney = await viewModel.fetchJourneyById(
                      (widget.isReservation)
                          ? widget.journey['journeyID']
                          : widget.journey['journeyId']);
                  if (selectedJourney != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JourneyDetail(
                          journey: selectedJourney,
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Hata"),
                          content: Text("Yolculuk Bulunamadı"),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Tamam'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: PrimaryNextButton(
                buttonText: (widget.isReservation)
                    ? "Rezervasyonu İptal Et"
                    : "Yolculuğu Sil",
                bgColor: Colors.red,
                onPressed: () async {
                  if (widget.isReservation) {
                    bool isDeleted = await viewModel
                        .deleteReservation(widget.journey['journeyID']);
                    if (isDeleted) {
                      Navigator.pop(context, true);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Hata"),
                            content: Text("Yolculuk zaten iptal edilmiş."),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Tamam'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    Map<bool, String> isDeleted = await viewModel
                        .deleteJourney(widget.journey['journeyId']);
                    if (isDeleted.keys.first) {
                      Navigator.pop(context, true);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Hata"),
                            content: Text(isDeleted.values.last),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Tamam'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
