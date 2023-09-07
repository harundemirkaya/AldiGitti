// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:flutter/material.dart';

class DeliverOTPPage extends StatefulWidget {
  const DeliverOTPPage({Key? key}) : super(key: key);

  @override
  State<DeliverOTPPage> createState() => _DeliverOTPPageState();
}

class _DeliverOTPPageState extends State<DeliverOTPPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Doğrulama'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kargoyu Teslim Edebilmek İçin Teslim Alıcıdan Aldığınız 6 Haneli Kodu Giriniz",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '6 Haneli Kod',
                hintText: '123456',
              ),
            ),
            SizedBox(height: 20),
            PrimaryNextButton(
              buttonText: "Onayla",
              isDoubleInfinity: true,
              onPressed: () {
                String otp = _otpController.text;
                if (otp.length == 6) {
                  // TO DO
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lütfen 6 haneli bir kod giriniz')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
