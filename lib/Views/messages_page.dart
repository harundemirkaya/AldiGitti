// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aldigitti/Views/Helpers/PrimaryMessageRow.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNavigationBar.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryNavigationBar(
            backButton: false,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return PrimaryMessageRow();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
