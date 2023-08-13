// ignore_for_file: prefer_const_constructors, file_names, prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:convert';

import 'package:aldigitti/Models/PlaceAutoCompleteResponse.dart';
import 'package:aldigitti/Services/NetworkManager.dart';
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
  List<Prediction> placePredictions = [];

  Future<void> placeAutoComplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", "/maps/api/place/autocomplete/json", {
      "input": query,
      "key": "AIzaSyByasp53gOABTWi4gwPcSeRYNuP65aWCi8",
    });

    String? response = await NetworkManager.fetchGoogleMapAPI(uri);
    Map<String, dynamic> jsonData = json.decode(response ?? "");
    if (response != null) {
      PlaceAutoCompleteResponse result =
          PlaceAutoCompleteResponse.fromJson(jsonData);
      if (result.predictions != null) {
        placePredictions = result.predictions;
        print(placePredictions.length);
        print(placePredictions[0].structuredFormatting.mainText);
      }
    }
  }

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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: placePredictions.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        placePredictions[index]
                                            .structuredFormatting
                                            .mainText,
                                        overflow: TextOverflow.ellipsis),
                                    Text(
                                      placePredictions[index].description,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                          Divider()
                        ],
                      )),
            ),
            Spacer(),
            PrimaryNextButton(
              buttonText: "Ara",
              onPressed: () async {
                await placeAutoComplete(_locationController.text);
                setState(() {});
              },
              isDoubleInfinity: true,
            ),
          ],
        ),
      ),
    );
  }
}
