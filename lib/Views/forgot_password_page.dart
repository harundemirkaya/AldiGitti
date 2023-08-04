// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _mailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 10,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(28, 40, 28, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Parola Yenileme",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 60,
              ),
              child: Text(
                "Parola sıfırlama isteğinde bulunmak için lütfen e-posta adresinizi girin",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            PrimaryTextField(
              controller: _mailController,
              icon: Icons.mail_outline,
              placeholderText: "E-Mail",
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: PrimaryNextButton(
                buttonText: "Yenile",
                buttonIcon: Icons.arrow_right_alt,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
