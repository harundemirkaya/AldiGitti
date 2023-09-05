// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class PrimaryMessageRow extends StatefulWidget {
  const PrimaryMessageRow({super.key});

  @override
  State<PrimaryMessageRow> createState() => _PrimaryMessageRowState();
}

class _PrimaryMessageRowState extends State<PrimaryMessageRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/63802051?v=4",
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Harun Demirkaya",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "İstanbul - Ankara",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
        Spacer(),
        Icon(
          Icons.keyboard_arrow_right,
          size: 30,
        )
      ],
    );
  }
}
