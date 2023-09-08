// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:aldigitti/ViewModels/ChangePasswordViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordAgainController =
      TextEditingController();

  ChangePasswordViewModel viewModel = ChangePasswordViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryNavigationBar(
            backButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Şifreni Değiştir",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryTextField(
                      controller: _oldPasswordController,
                      icon: Icons.lock_outline,
                      placeholderText: "Mevcut Şifre",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      controller: _newPasswordController,
                      icon: Icons.lock_outline,
                      placeholderText: "Yeni Şifre",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PrimaryTextField(
                      controller: _newPasswordAgainController,
                      icon: Icons.lock_outline,
                      placeholderText: "Yeni Şifre Tekrar",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryNextButton(
                      buttonText: "Şifreyi Güncelle",
                      onPressed: () async {
                        Map<bool, String> isSuccess =
                            await viewModel.changePassword(
                                _oldPasswordController.text,
                                _newPasswordController.text,
                                _newPasswordAgainController.text);
                        if (isSuccess.keys.first) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Başarılı"),
                                content: Text(isSuccess.values.first),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Tamam'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Hata"),
                                content: Text(isSuccess.values.first),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Tamam'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      isDoubleInfinity: true,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
