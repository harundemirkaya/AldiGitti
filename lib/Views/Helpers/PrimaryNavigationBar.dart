// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:aldigitti/Views/Helpers/PrimaryFilterBottomSheet.dart';
import 'package:flutter/material.dart';

class PrimaryNavigationBar extends StatelessWidget {
  final bool backButton;
  final bool filterButton;
  final String userName;
  const PrimaryNavigationBar(
      {super.key,
      this.backButton = false,
      this.filterButton = false,
      this.userName = ""});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var containerHeight = (screenHeight / 812) * 102;
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: Color.fromRGBO(61, 86, 240, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular((userName != "") ? 0 : 40),
          bottomRight: Radius.circular((userName != "") ? 0 : 40),
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
                if (backButton) {
                  Navigator.pop(context);
                } else {
                  // TO DO
                }
              },
              child: Icon(backButton ? Icons.arrow_back : Icons.menu,
                  color: Colors.white),
            ),
            (userName != "")
                ? Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                : SizedBox(),
            Spacer(),
            filterButton
                ? GestureDetector(
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
                  )
                : !backButton
                    ? GestureDetector(
                        onTap: () {
                          // TO DO
                        },
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      )
                    : Text(""),
          ],
        ),
      ),
    );
  }
}
