// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/MyJourneysViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryJourneyRow.dart';
import 'package:aldigitti/Views/journey_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyJourneysPage extends StatefulWidget {
  const MyJourneysPage({super.key});

  @override
  State<MyJourneysPage> createState() => _MyJourneysPageState();
}

class _MyJourneysPageState extends State<MyJourneysPage> {
  MyJourneysViewModel viewModel = MyJourneysViewModel();
  List<Map<String, dynamic>> userJourneys = [];
  List<Map<String, dynamic>> userReservations = [];

  Future<void> fetchJourneysAndReservations() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);

    List<Map<String, dynamic>> journeys = await viewModel.fetchUserJourneys();
    List<Map<String, dynamic>> reservations =
        await viewModel.fetchUserReservations();

    if (!mounted) return;

    setState(() {
      userJourneys = journeys;
      userReservations = reservations;
    });

    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).hideLoading();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchJourneysAndReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AppProvider>(context, listen: true).loading;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 30,
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Rezervasyonlarım'),
              Tab(text: 'Yolculuklarım'),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 20.0,
            ),
            child: TabBarView(
              children: [
                (userReservations.isEmpty && !isLoading)
                    ? Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            "lib/assets/images/cargo-icon.png",
                            width: 190,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Henüz Bir Rezervasyonunuz Yok",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      )
                    : RefreshIndicator(
                        onRefresh: fetchJourneysAndReservations,
                        child: ListView.builder(
                          itemCount: userReservations.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                bool? shouldRefresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JourneyPlanPage(
                                      journey: userReservations[index],
                                      isReservation: true,
                                    ),
                                  ),
                                );
                                if (shouldRefresh == true) {
                                  setState(() {
                                    fetchJourneysAndReservations();
                                  });
                                }
                              },
                              child: PrimaryJourneyRow(
                                isReservation: true,
                                date: userReservations[index]['date'],
                                fromName: userReservations[index]['fromName'],
                                toName: userReservations[index]['toName'],
                                status: userReservations[index]['status'],
                                reservationInvitations: [],
                                reservations: [],
                              ),
                            );
                          },
                        ),
                      ),
                (userJourneys.isEmpty && !isLoading)
                    ? Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            "lib/assets/images/car-icon.png",
                            width: 190,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Henüz Bir Yolculuğunuz Yok",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                        ],
                      )
                    : RefreshIndicator(
                        onRefresh: fetchJourneysAndReservations,
                        child: ListView.builder(
                          itemCount: userJourneys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                bool? shouldRefresh = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JourneyPlanPage(
                                      journey: userJourneys[index],
                                      isReservation: false,
                                    ),
                                  ),
                                );
                                if (shouldRefresh == true) {
                                  setState(() {
                                    fetchJourneysAndReservations();
                                  });
                                }
                              },
                              child: PrimaryJourneyRow(
                                isReservation: false,
                                date: userJourneys[index]['date'],
                                fromName: userJourneys[index]['fromName'],
                                toName: userJourneys[index]['toName'],
                                status: userJourneys[index]['status'] ?? "",
                                reservationInvitations: userJourneys[index]
                                        ['reservationInvitations'] ??
                                    [],
                                reservations:
                                    userJourneys[index]['reservations'] ?? [],
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
