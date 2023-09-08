// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/Views/my_journeys_page.dart';
import 'package:aldigitti/Views/my_vehicles_page.dart';
import 'package:aldigitti/Views/profile_page.dart';
import 'package:aldigitti/Views/publish_page.dart';
import 'package:aldigitti/Views/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _children = [
    SearchPage(),
    MyJourneysPage(),
    PublishPage(),
    MyVehiclesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      body: _children[appProvider.bottomNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          appProvider.setBottomNavBarIndex(index);
        },
        currentIndex: appProvider.bottomNavBarIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.join_inner),
            label: 'Yolculuklarım', // TO DO
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, -10.0),
              child: Container(
                padding: EdgeInsets.all(
                  5.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
            label: 'Yayınla',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta),
            label: 'Araçlarım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
