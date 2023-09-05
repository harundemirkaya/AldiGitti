// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aldigitti/Providers/AppProvider.dart';
import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/Providers/UserProvider.dart';
import 'package:aldigitti/Views/bottom_navbar.dart';
import 'package:aldigitti/Views/home_page.dart';
import 'package:aldigitti/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        title: 'Aldı Gitii',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('tr', 'TR'), // Türkçe
        ],
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                return HomePage();
              } else {
                return BottomNavBar();
              }
            }
            return CircularProgressIndicator();
          },
        ),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(61, 86, 240, 1),
        ),
      ),
    );
  }
}
