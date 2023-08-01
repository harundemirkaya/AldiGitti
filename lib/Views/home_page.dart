// ignore_for_file: prefer_const_constructors

import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(28, 70, 28, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("lib/assets/images/logo.png"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Giriş Yap",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _mailController,
              icon: Icons.mail_outline,
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _passwordController,
              icon: Icons.lock_outline,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: _rememberMe,
                    activeTrackColor: Theme.of(context).primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        _rememberMe = value; // Durum değişkenini güncelle
                      });
                    },
                  ),
                ),
                Text(
                  "Beni Hatırla",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  "Şifremi Unuttum",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: PrimaryNextButton(
                buttonText: "Giriş Yap",
                buttonIcon: Icons.arrow_right_alt,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "OR",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
