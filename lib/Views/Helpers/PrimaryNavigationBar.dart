// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PrimaryNavigationBar extends StatelessWidget {
  const PrimaryNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var containerHeight = (screenHeight / 812) * 102;
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: Color.fromRGBO(61, 86, 240, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: (MediaQuery.of(context).size.height / 812) * 53,
          left: (MediaQuery.of(context).size.width / 375) * 33,
          right: (MediaQuery.of(context).size.width / 375) * 33,
        ),
        child: Row(
          children: [
            Icon(Icons.menu, color: Colors.white),
            Spacer(),
            Icon(Icons.notifications, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
