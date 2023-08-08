// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:aldigitti/Views/Helpers/PrimaryLocationSelection.dart';
import 'package:flutter/material.dart';

class PrimaryToFrom extends StatefulWidget {
  const PrimaryToFrom({super.key});

  @override
  State<PrimaryToFrom> createState() => _PrimaryToFromState();
}

class _PrimaryToFromState extends State<PrimaryToFrom> {
  var toText = "Nereye";
  var fromText = "Nereden";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(246, 246, 246, 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrimaryLocationSelection(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Nereden",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(144, 144, 144, 1)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            fromText,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrimaryLocationSelection(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Nereye",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(144, 144, 144, 1)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            toText,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    if (toText != "Nereye" && fromText != "Nereden") {
                      var temp = toText;
                      toText = fromText;
                      fromText = temp;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.change_circle,
                    size: 66,
                    color: Color.fromRGBO(61, 86, 240, 1),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
