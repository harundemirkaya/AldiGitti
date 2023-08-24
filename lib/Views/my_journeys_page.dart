// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/MyJourneysViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryJourneyRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                    : ListView.builder(
                        itemCount: userReservations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PrimaryJourneyRow(
                            isReservation: true,
                            date: userReservations[index]['date'],
                            fromName: userReservations[index]['fromName'],
                            toName: userReservations[index]['toName'],
                            status: userReservations[index]['status'],
                          );
                        },
                      ),
                (userJourneys.isEmpty && !isLoading)
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
                    : ListView.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return PrimaryJourneyRow(
                            isReservation: false,
                            date: 'Bugün, 16:20',
                            fromName: "Küçükçekmece",
                            toName: "Balıkesir",
                            status: "Yeni Rezervasyon İsteği",
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
