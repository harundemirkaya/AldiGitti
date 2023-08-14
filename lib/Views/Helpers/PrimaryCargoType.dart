// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, file_names, unused_element, override_on_non_overriding_member

import 'package:aldigitti/Provider/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimaryCargoType extends StatefulWidget {
  final bool? isPublisher;
  const PrimaryCargoType({super.key, this.isPublisher});

  @override
  _PrimaryCargoTypeState createState() => _PrimaryCargoTypeState();
}

class _PrimaryCargoTypeState extends State<PrimaryCargoType> {
  @override
  bool isBelgeSelected = false;
  bool isPaketSelected = false;
  bool isKoliSelected = false;
  bool isCanliHayvanSelected = false;

  Future<void> _showSelectionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text((widget.isPublisher ?? false)
              ? "Kabul Edebileceğiniz Kargo Tiplerini Seçin"
              : 'Kargo Tipi Seçin'),
          content: (widget.isPublisher ?? false)
              ? StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CheckboxListTile(
                          title: Text("Belge"),
                          value: isBelgeSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isBelgeSelected = newValue!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text("Paket"),
                          value: isPaketSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isPaketSelected = newValue!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text("Koli"),
                          value: isKoliSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isKoliSelected = newValue!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text("Canlı Hayvan"),
                          value: isCanliHayvanSelected,
                          onChanged: (newValue) {
                            setState(() {
                              isCanliHayvanSelected = newValue!;
                            });
                          },
                        ),
                        ElevatedButton(
                            onPressed: () {
                              int selectedCount = 0;
                              if (isBelgeSelected) selectedCount++;
                              if (isPaketSelected) selectedCount++;
                              if (isKoliSelected) selectedCount++;
                              if (isCanliHayvanSelected) selectedCount++;

                              _updateValueAndPop(selectedCount.toString());
                            },
                            child: Text("Seç"))
                      ],
                    );
                  },
                )
              : SingleChildScrollView(
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
      final dataProvider = Provider.of<DataProvider>(context, listen: false);
      if (!(widget.isPublisher ?? false)) {
        dataProvider.setCargoType(value);
      } else {
        //dropdownValue = "$value Adet"; TO DO
      }
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
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
                (widget.isPublisher ?? false) ? "0" : dataProvider.cargoType,
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
