// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:aldigitti/Views/calendar_page.dart';
import 'package:aldigitti/Views/live_map.dart';
import 'package:aldigitti/Views/profile_page.dart';
import 'package:aldigitti/Views/publish_page.dart';
import 'package:aldigitti/Views/search_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    SearchPage(),
    CalendarPage(),
    PublishPage(),
    LiveMapPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Takvim',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, -10.0), // Y ekseninde -10.0 birim yukarı taşıma
              child: Container(
                padding: EdgeInsets.all(
                    5.0), // İkon ile konteyner arasında biraz boşluk ekler
                decoration: BoxDecoration(
                  color: Colors.blue, // Arka plan rengi mavi
                  shape: BoxShape.circle, // Yuvarlak bir şekil verir
                  boxShadow: [
                    // Gölge ekler
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // X ve Y ekseninde gölge konumu
                    ),
                  ],
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white, // İkonun rengi beyaz
                  size: 30.0, // İkonun boyutu
                ),
              ),
            ),
            label: 'Yayınla',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Canlı Takip',
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
