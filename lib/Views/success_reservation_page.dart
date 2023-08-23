// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SuccessReservationPage extends StatefulWidget {
  const SuccessReservationPage({super.key});

  @override
  State<SuccessReservationPage> createState() => _SuccessReservationPageState();
}

class _SuccessReservationPageState extends State<SuccessReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Elemanları merkeze hizala
            children: [
              Icon(Icons.check_circle,
                  size: 100.0, color: Colors.green), // Tik ikonu
              SizedBox(height: 20.0), // Boşluk
              Text(
                'Rezervasyon Başarılı',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ), // Başarılı mesajı
              SizedBox(height: 20.0), // Boşluk
              ElevatedButton(
                onPressed: () {
                  // TODO: Rezervasyonlarımı gör butonuna tıklanınca ne yapılacağını buraya yazın.
                },
                child: Text('Rezervasyonlarımı Gör'),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                ),
              ), // Rezervasyonlarımı gör butonu
            ],
          ),
        ),
      ),
    );
  }
}
