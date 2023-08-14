// ignore_for_file: prefer_const_constructors

import 'package:aldigitti/Provider/DataProvider.dart';
import 'package:aldigitti/Views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'Aldı Gitii',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(86, 105, 255, 1),
        ),
      ),
    );
  }
}
