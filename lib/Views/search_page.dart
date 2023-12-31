// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, curly_braces_in_flow_control_structures, avoid_print, use_build_context_synchronously

import 'package:aldigitti/Models/JourneyModel.dart';
import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/ViewModels/SearchViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryCargoType.dart';
import 'package:aldigitti/Views/Helpers/PrimaryDesi.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFrom.dart';
import 'package:aldigitti/Views/Helpers/PrimaryToFromDate.dart';
import 'package:aldigitti/Views/journeys_page.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  List<Widget> _pages = [
    Image.asset("lib/assets/images/slider-1.png"),
    Image.asset("lib/assets/images/slider-1.png"),
    Image.asset("lib/assets/images/slider-1.png"),
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).hideLoading();

    _timer = Timer.periodic(
      Duration(seconds: 5),
      (Timer timer) {
        if (_controller.page?.round() == _pages.length - 1)
          _controller.jumpToPage(0);
        else
          _controller.nextPage(
              duration: Duration(seconds: 1), curve: Curves.linear);
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    SearchViewModel viewModel = SearchViewModel();
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PrimaryNavigationBar(
                backButton: false,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width * 0.05,
                  right: screenSize.width * 0.05,
                ),
                child: Column(
                  children: [
                    PrimaryToFrom(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        PrimaryToFromDate(),
                        Spacer(),
                        PrimaryCargoType(),
                        Spacer(),
                        PrimaryDesi(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryNextButton(
                      buttonText: "Ara",
                      onPressed: () async {
                        List<Journey> nearbyJourneys =
                            await viewModel.fetchNearbyJourneys(
                                dataProvider.customerFromLat,
                                dataProvider.customerFromLong,
                                dataProvider.customerToLat,
                                dataProvider.customerToLong,
                                dataProvider.customerDate,
                                dataProvider.customerCargoType,
                                dataProvider.customerDesi);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JourneysPage(
                              journeys: nearbyJourneys,
                            ),
                          ),
                        );
                      },
                      isDoubleInfinity: true,
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 150,
              child: PageView(
                controller: _controller,
                children: _pages,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
