// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimaryDesi extends StatefulWidget {
  final bool? isPublisher;
  const PrimaryDesi({super.key, this.isPublisher});

  @override
  State<PrimaryDesi> createState() => _PrimaryDesiState();
}

class _PrimaryDesiState extends State<PrimaryDesi> {
  Future<void> _showDesiCalculationDialog(BuildContext context) async {
    TextEditingController widthController = TextEditingController();
    TextEditingController heightController = TextEditingController();
    TextEditingController lengthController = TextEditingController();
    TextEditingController maxDesiController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Desi Hesaplama'),
          content: (widget.isPublisher ?? false)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: maxDesiController,
                      decoration: InputDecoration(hintText: "Max Desi"),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      child: Text("Seç"),
                      onPressed: () =>
                          _calculateDesi("", "", "", maxDesiController.text),
                    ),
                  ],
                )
              : SingleChildScrollView(
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
                            heightController.text, lengthController.text, ""),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _calculateDesi(
      String width, String height, String length, String maxDesi) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    if (widget.isPublisher ?? false) {
      setState(() {
        if (maxDesi != "") {
          dataProvider.setDriverDesi(double.parse(maxDesi));
        }
      });
    } else {
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
          dataProvider.setDriverDesi(calculateResult);
        });
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
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
                (widget.isPublisher ?? false)
                    ? dataProvider.driverDesi.toStringAsFixed(2)
                    : dataProvider.customerDesi.toStringAsFixed(2),
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
