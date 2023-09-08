// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:aldigitti/ViewModels/AddBankAccountViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class AddBankAccountPage extends StatefulWidget {
  const AddBankAccountPage({super.key});

  @override
  State<AddBankAccountPage> createState() => _AddBankAccountPageState();
}

class _AddBankAccountPageState extends State<AddBankAccountPage> {
  TextEditingController accountOwnerNameController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  AddBankViewModel viewModel = AddBankViewModel();

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
                horizontal: 30,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Banka Hesabını Ekle",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrimaryTextField(
                    controller: accountOwnerNameController,
                    icon: Icons.person,
                    placeholderText: "Hesap Sahibinin Adı Soyadı",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PrimaryTextField(
                    controller: ibanController,
                    icon: Icons.credit_card,
                    placeholderText: "IBAN",
                    isIban: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PrimaryTextField(
                    controller: bankNameController,
                    icon: Icons.credit_card,
                    placeholderText: "Banka Adı",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ödeme alabilmeniz için hesap adınızın banka hesabı sahibi adı ile aynı olması gerekmektedir.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PrimaryNextButton(
                    buttonText: "Banka Hesabını Ekle",
                    onPressed: () async {
                      if (accountOwnerNameController.text != "" &&
                          ibanController.text != "" &&
                          bankNameController.text != "" &&
                          ibanController.text.length == 26) {
                        bool isSuccess = await viewModel.addBankAccount(
                          accountOwnerName: accountOwnerNameController.text,
                          iban: ibanController.text,
                          bankName: bankNameController.text,
                        );

                        if (isSuccess) {
                          Navigator.pop(context, true);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Hata"),
                                content: Text("Bir Hata Oluştu"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Tamam'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Hata"),
                              content:
                                  Text("Lütfen Tüm Alanları Eksiksiz Doldurun"),
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
          ))
        ],
      ),
    );
  }
}
