// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/PaymentMethodsViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/add_bank_account_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  bool _isBankAccount = false;
  Map<String, dynamic>? bankAccount;
  PaymentMethodsViewModel viewModel = PaymentMethodsViewModel();

  Future<void> checkBankAccount() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);

    bool status = await viewModel.checkBankAccount();
    setState(() {
      _isBankAccount = status;
      if (status) {
        checkBankAccountDetails();
      }
    });

    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  Future<void> checkBankAccountDetails() async {
    Map<String, dynamic>? bankAccountDetails =
        await viewModel.getBankAccountDetails();
    setState(() {
      bankAccount = bankAccountDetails;
    });
  }

  @override
  void initState() {
    super.initState();
    checkBankAccount();
  }

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
                    "Ödeme Yöntemleri",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  (!_isBankAccount)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Henüz Ödeme Yöntemi Eklemediniz",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Ödeme yöntemi ekleyerek ödemelerinizi hızlıca tamamlayabilirsiniz.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: PrimaryNextButton(
                                buttonText: "Ödeme Yöntemi Ekle",
                                isDoubleInfinity: true,
                                onPressed: () async {
                                  bool? isSuccess = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddBankAccountPage(),
                                    ),
                                  );

                                  if (isSuccess == true) {
                                    checkBankAccount();
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kayıtlı Banka Hesabınız",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Banka Adı: ${bankAccount?['bankName'] ?? ""}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "IBAN: ${bankAccount?['iban'] ?? ""}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Hesap Sahibi: ${bankAccount?['accountOwnerName'] ?? ""}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            PrimaryNextButton(
                              buttonText: "Mevcut Banka Hesabını Kaldır",
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      "Tanımlı Banka Hesabınızı Silmek İstediğinize Emin misiniz?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Hayır"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          bool isSuccess = await viewModel
                                              .removeBankAccount();
                                          if (isSuccess) {
                                            setState(() {
                                              checkBankAccount();
                                            });
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Hata"),
                                                  content:
                                                      Text("Bir Hata Oluştu"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Tamam'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: Text("Evet"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              bgColor: Colors.red,
                              isDoubleInfinity: true,
                            )
                          ],
                        ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
