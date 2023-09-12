// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/ViewModels/AvailableBalanceViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableBalancePage extends StatefulWidget {
  const AvailableBalancePage({super.key});

  @override
  State<AvailableBalancePage> createState() => _AvailableBalancePageState();
}

class _AvailableBalancePageState extends State<AvailableBalancePage> {
  Map<String, dynamic> userBalance = {};
  AvailableBalanceViewModel viewModel = AvailableBalanceViewModel();

  Future<void> checkBalance() async {
    if (!mounted) return;
    Provider.of<AppProvider>(context, listen: false).showLoading(context);

    Map<String, dynamic> status = await viewModel.fetchUserBalance();
    setState(() {
      userBalance = status;
    });

    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  @override
  void initState() {
    super.initState();
    checkBalance();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryNavigationBar(
            backButton: true,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: checkBalance,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "${userBalance['balance'] ?? 0}₺",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Kullanılabilir Bakiye",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Geçmiş İşlemler",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SingleChildScrollView(
                            child: DataTable(
                              columnSpacing: 0,
                              columns: [
                                DataColumn(
                                  label: SizedBox(
                                    width: (screenSize.width - 100) / 2,
                                    child: Text('İşlem Tarihi',
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: (screenSize.width - 100) / 2,
                                    child: Text('İşlem Ücreti',
                                        textAlign: TextAlign.end),
                                  ),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                (userBalance['actions']?.length ?? 0),
                                (index) => DataRow(
                                  cells: [
                                    DataCell(
                                      SizedBox(
                                        width: (screenSize.width - 100) / 2,
                                        child: Text(
                                          userBalance['actions'][index]
                                              .keys
                                              .first,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      SizedBox(
                                        width: (screenSize.width - 100) / 2,
                                        child: Text(
                                          "${userBalance['actions'][index].values.first.toString()}₺",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          (userBalance['actions'] == null ||
                                  userBalance['actions']?.length == 0)
                              ? Center(
                                  child: Text(
                                    "İşlem Geçmişiniz Bulunmamaktadır",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryNextButton(
              isDoubleInfinity: true,
              buttonText: "Para Çekme İsteği Oluştur",
              bgColor: Colors.green,
              onPressed: () async {
                if (userBalance['balance'] == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Bakiyeniz 0₺ olduğu için para çekme isteği oluşturamazsınız.",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                } else {
                  bool hasBankAccount = await viewModel.hasBankAccount();
                  if (hasBankAccount) {
                    // TO DO
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Önce Hesabınıza Bir Ödeme Yöntemi Bağlamalısınız. Bunu Profil Sayfasındaki Ödeme Yöntemleri Kısmından Yapabilirsiniz.",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
