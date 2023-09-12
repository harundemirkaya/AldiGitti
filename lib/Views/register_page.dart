// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, use_build_context_synchronously

import 'package:aldigitti/ViewModels/RegisterViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryLoginButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryScreenWrapper.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:aldigitti/Views/bottom_navbar.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _telephoneNumber = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = RegisterViewModel(context: context);
    return ScreenWrapper(
      child: Scaffold(
        body: Column(
          children: [
            PrimaryNavigationBar(
              backButton: true,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
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
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryTextField(
                              controller: _nameController,
                              icon: Icons.person_outline,
                              placeholderText: "İsim",
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: PrimaryTextField(
                              controller: _surnameController,
                              icon: Icons.person_outline,
                              placeholderText: "Soyisim",
                            ),
                          ),
                        ],
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
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryTextField(
                              controller: _birthDateController,
                              icon: Icons.calendar_month,
                              placeholderText: "Doğum Tarihi",
                              isDateField: true,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: PrimaryTextField(
                              controller: _genderController,
                              icon: Icons.female,
                              placeholderText: "Cinsiyet",
                              isGenderSelect: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryTextField(
                        controller: _telephoneNumber,
                        icon: Icons.call,
                        placeholderText: "Telefon Numarası",
                        isTelephoneNumber: true,
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
                          buttonText: "Register",
                          buttonIcon: Icons.arrow_forward,
                          onPressed: () async {
                            if (_nameController.text != "" &&
                                _surnameController.text != "" &&
                                _mailController.text != "" &&
                                _passwordController.text != "" &&
                                _passwordAgainController.text != "" &&
                                _birthDateController.text != "" &&
                                _genderController.text != "" &&
                                _passwordAgainController.text ==
                                    _passwordController.text) {
                              bool isRegistered = await viewModel.register(
                                _mailController.text,
                                _passwordController.text,
                                _nameController.text,
                                _surnameController.text,
                                _birthDateController.text,
                                _genderController.text,
                                _telephoneNumber.text,
                              );
                              if (isRegistered) {
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
