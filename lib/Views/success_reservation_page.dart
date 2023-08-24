// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/bottom_navbar.dart';
import 'package:aldigitti/Views/my_journeys_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessReservationPage extends StatefulWidget {
  const SuccessReservationPage({super.key});

  @override
  State<SuccessReservationPage> createState() => _SuccessReservationPageState();
}

class _SuccessReservationPageState extends State<SuccessReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Column(
          children: [
            PrimaryNavigationBar(
              backButton: true,
              bgColor: Colors.greenAccent,
              backButtonColor: Colors.black,
            ),
            Spacer(),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, size: 100.0, color: Colors.black),
                    SizedBox(height: 20.0),
                    Text(
                      'Rezervasyon Başarılı',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Sürücü rezervasyonunu en kısa sürede değerlendirecek.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        final appProvider =
                            Provider.of<AppProvider>(context, listen: false);
                        appProvider.setBottomNavBarIndex(1);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()),
                          (route) => route.settings.name == '/bottomNavBar',
                        );
                      },
                      child: Text(
                        'Rezervasyonlarımı Gör',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer()
          ],
        ));
  }
}
