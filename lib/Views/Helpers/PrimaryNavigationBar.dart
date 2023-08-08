// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:aldigitti/Views/Helpers/PrimaryFilterBottomSheet.dart';
import 'package:flutter/material.dart';

class PrimaryNavigationBar extends StatelessWidget {
  final bool onlyBackButton;
  const PrimaryNavigationBar({super.key, required this.onlyBackButton});

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
            GestureDetector(
              onTap: () {
                if (onlyBackButton) {
                  Navigator.pop(context);
                } else {
                  // TO DO
                }
              },
              child: Icon(onlyBackButton ? Icons.arrow_back : Icons.menu,
                  color: Colors.white),
            ),
            Spacer(),
            !onlyBackButton
                ? GestureDetector(
                    onTap: () {
                      // TO DO
                    },
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return PrimaryFilterBottomSheet();
                        },
                      );
                    },
                    child: Text(
                      "Filtrele",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
