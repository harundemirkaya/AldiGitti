// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/Views/Helpers/PrimaryProfileEditRow.dart';
import 'package:aldigitti/Views/available_balance_page.dart';
import 'package:aldigitti/Views/change_password_page.dart';
import 'package:aldigitti/Views/payment_methods_page.dart';
import 'package:aldigitti/Views/personal_information_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 30,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Harun DEMİRKAYA",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Yeni Başlayan")
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/63802051?v=4",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ProfileEditRow(
                  title: "Kişisel Bilgiler",
                  icon: Icons.keyboard_arrow_right,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInformationPage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                ProfileEditRow(
                  title: "Şifre",
                  icon: Icons.keyboard_arrow_right,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordPage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                ProfileEditRow(
                  title: "Kullanılabilir Bakiye",
                  icon: Icons.keyboard_arrow_right,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AvailableBalancePage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ProfileEditRow(
                  title: "Ödeme Yöntemleri",
                  icon: Icons.keyboard_arrow_right,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentMethodsPage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                ProfileEditRow(
                  title: "Uygulamaya Puan Ver",
                  icon: Icons.keyboard_arrow_right,
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                ProfileEditRow(
                  title: "Yardım",
                  icon: Icons.keyboard_arrow_right,
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                ProfileEditRow(
                  title: "Kullanım Koşulları",
                  icon: Icons.keyboard_arrow_right,
                  onTap: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Text(
                    "Çıkış Yap",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
