// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class PrimaryCargoType extends StatefulWidget {
  const PrimaryCargoType({super.key});

  @override
  _PrimaryCargoTypeState createState() => _PrimaryCargoTypeState();
}

class _PrimaryCargoTypeState extends State<PrimaryCargoType> {
  String dropdownValue = 'Belge';

  Future<void> _showSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kargo Tipi Seçin'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Belge"),
                  onTap: () => _updateValueAndPop('Belge'),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Paket"),
                  onTap: () => _updateValueAndPop('Paket'),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Koli"),
                  onTap: () => _updateValueAndPop('Koli'),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Canlı Hayvan"),
                  onTap: () => _updateValueAndPop('C. Hayvan'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateValueAndPop(String value) {
    setState(() {
      dropdownValue = value;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _showSelectionDialog(context),
      child: Container(
        height: screenSize.height * 80 / 812,
        width: screenSize.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(246, 246, 246, 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Text(
                "Kargo Tipi",
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(144, 144, 144, 1)),
              ),
              Text(
                dropdownValue,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
