// ignore_for_file: prefer_const_constructors

import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';

class PrimaryLocationSelection extends StatefulWidget {
  @override
  _PrimaryLocationSelectionState createState() =>
      _PrimaryLocationSelectionState();
}

class _PrimaryLocationSelectionState extends State<PrimaryLocationSelection> {
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konum Seçimi')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            PrimaryTextField(
              controller: _locationController,
              icon: Icons.map,
              placeholderText: "Konum Arayın",
            ),
            Expanded(
              child: Container(),
            ),
            PrimaryNextButton(
              buttonText: "Seç",
              onPressed: () {
                Navigator.pop(context);
              },
              isDoubleInfinity: true,
            ),
          ],
        ),
      ),
    );
  }
}
