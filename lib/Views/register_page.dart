// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aldigitti/Views/Helpers/PrimaryLoginButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 10,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(28, 0, 28, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kayıt Ol",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _nameController,
              icon: Icons.person_outline,
              placeholderText: "İsim Soyisim",
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _mailController,
              icon: Icons.mail_outline,
              placeholderText: "E-Mail",
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _passwordController,
              icon: Icons.lock_outline,
              placeholderText: "Parola",
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _passwordAgainController,
              icon: Icons.lock_outline,
              placeholderText: "Parola (Tekrar)",
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: PrimaryNextButton(
                buttonText: "Kayıt Ol",
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
            SizedBox(
              height: 5,
            ),
            PrimaryLoginButton(
              iconData: "lib/assets/images/google-icon.svg",
              buttonText: "Google ile Giriş Yap",
              onPressed: () {},
            ),
            SizedBox(
              height: 15,
            ),
            PrimaryLoginButton(
              iconData: "lib/assets/images/facebook-icon.svg",
              buttonText: "Facebook ile Giriş Yap",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
