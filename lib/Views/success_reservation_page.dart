// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessReservationPage extends StatefulWidget {
  final bool isSuccessQR;
  const SuccessReservationPage({
    super.key,
    this.isSuccessQR = false,
  });

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
              homeButton: widget.isSuccessQR ? false : true,
              backButton: widget.isSuccessQR ? true : false,
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
                      widget.isSuccessQR
                          ? "Kargo Teslim Alındı"
                          : 'Rezervasyon Başarılı',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.isSuccessQR
                          ? "Tüm rezervasyonlarınızın kargo teslimini gerçekleştirmenizin ardından yola çıkabilirsiniz!"
                          : 'Sürücü rezervasyonunu en kısa sürede değerlendirecek.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    widget.isSuccessQR
                        ? SizedBox()
                        : ElevatedButton(
                            onPressed: () {
                              final appProvider = Provider.of<AppProvider>(
                                  context,
                                  listen: false);
                              appProvider.setBottomNavBarIndex(1);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBar(),
                                ),
                                (route) =>
                                    route.settings.name == '/bottomNavBar',
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
