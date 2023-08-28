// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/ReservationsInvitationsViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationInvitationsPage extends StatefulWidget {
  final List<dynamic> reservationInvitations;
  final String journeyID;
  ReservationInvitationsPage({
    super.key,
    required this.reservationInvitations,
    required this.journeyID,
  });

  @override
  State<ReservationInvitationsPage> createState() =>
      _ReservationInvitationsPageState();
}

class _ReservationInvitationsPageState
    extends State<ReservationInvitationsPage> {
  ReservationsInvitationsViewModel viewModel =
      ReservationsInvitationsViewModel();
  Map<bool, List> userNames = {false: []};

  Future<void> fetchReservationInvitesUserNames() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);

    Map<bool, List> users =
        await viewModel.fetchNamesFromUIDs(widget.reservationInvitations);
    setState(() {
      userNames = users;
    });

    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchReservationInvitesUserNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(
            backButton: true,
          ),
          (userNames.keys.first)
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    itemCount: widget.reservationInvitations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/63802051?v=4",
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    userNames.values.first[index] as String,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(10, 10),
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.all(0),
                                  ),
                                  onPressed: () async {
                                    await viewModel.addReservationToJourney(
                                        widget.journeyID,
                                        widget.reservationInvitations[index]);
                                    await viewModel
                                        .removeReservationUserIDFromUserJourneys(
                                            widget.journeyID,
                                            widget
                                                .reservationInvitations[index]);
                                    setState(() {
                                      widget.reservationInvitations
                                          .removeAt(index);
                                      if (widget
                                          .reservationInvitations.isEmpty) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: EdgeInsets.all(0)),
                                  onPressed: () async {
                                    await viewModel
                                        .removeReservationUserIDFromUserJourneys(
                                            widget.journeyID,
                                            widget
                                                .reservationInvitations[index]);
                                    setState(
                                      () {
                                        widget.reservationInvitations
                                            .removeAt(index);
                                        if (widget
                                            .reservationInvitations.isEmpty) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
