// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class PrimaryDesi extends StatefulWidget {
  const PrimaryDesi({super.key});

  @override
  State<PrimaryDesi> createState() => _PrimaryDesiState();
}

class _PrimaryDesiState extends State<PrimaryDesi> {
  double _desi = 0;

  Future<void> _showDesiCalculationDialog(BuildContext context) async {
    TextEditingController widthController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    TextEditingController lengthController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Desi Hesaplama'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: widthController,
                  decoration: InputDecoration(hintText: "Genişlik (cm)"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: heightController,
                  decoration: InputDecoration(hintText: "Yükseklik (cm)"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: lengthController,
                  decoration: InputDecoration(hintText: "Uzunluk (cm)"),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  child: Text("Hesapla"),
                  onPressed: () => _calculateDesi(widthController.text,
                      heightController.text, lengthController.text),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _calculateDesi(String width, String height, String length) {
    double w = double.tryParse(width) ?? 0;
    double h = double.tryParse(height) ?? 0;
    double l = double.tryParse(length) ?? 0;

    var calculateResult = (w * h * l) / 3000;
    if (calculateResult > 100) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('En fazla 100 desi hesaplanabilir'),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _desi = calculateResult;
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _showDesiCalculationDialog(context),
      child: Container(
        height: screenSize.height * 80 / 812,
        width: screenSize.width * 0.25,
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
                "Desi",
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(144, 144, 144, 1)),
              ),
              Text(
                _desi.toStringAsFixed(2),
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
