// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison

import 'package:aldigitti/ViewModels/LoginViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryLoginButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:aldigitti/Views/bottom_navbar.dart';
import 'package:aldigitti/Views/forgot_password_page.dart';
import 'package:aldigitti/Views/register_page.dart';
import 'package:flutter/gestures.dart';
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
    LoginViewModel viewModel = LoginViewModel(context: context);
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
              placeholderText: "E-Mail Adresiniz",
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _passwordController,
              icon: Icons.lock_outline,
              placeholderText: "Şifreniz",
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Şifremi Unuttum",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
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
                onPressed: () async {
                  if (_mailController.text != "" &&
                      _passwordController.text != "") {
                    bool isLogin = await viewModel.login(
                        _mailController.text, _passwordController.text);
                    if (isLogin) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      );
                    }
                  }
                },
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
            SizedBox(
              height: 30,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Hesabınız yok mu? ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Hemen Kayıt Olun!',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
