// ignore_for_file: prefer_const_constructors, file_names, prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:convert';

import 'package:aldigitti/Models/PlaceAutoCompleteResponse.dart';
import 'package:aldigitti/Provider/DataProvider.dart';
import 'package:aldigitti/Services/NetworkManager.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:provider/provider.dart';

class PrimaryLocationSelection extends StatefulWidget {
  final bool isFrom;

  const PrimaryLocationSelection({this.isFrom = false});
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
      if (result.predictions != []) {
        placePredictions = result.predictions;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
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
              onChanged: (String? value) async {
                await placeAutoComplete(value ?? "i");
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: placePredictions.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          GeoCode geoCode = GeoCode();

                          try {
                            Coordinates coordinates =
                                await geoCode.forwardGeocoding(
                                    address:
                                        placePredictions[index].description);
                            /* Navigator.pop(
                                context,
                                coordinates.latitude.toString() +
                                    "," +
                                    coordinates.longitude.toString()); */
                            if (widget.isFrom) {
                              dataProvider.setFromData(
                                  placePredictions[index]
                                      .structuredFormatting
                                      .mainText,
                                  coordinates.latitude ?? 0,
                                  coordinates.longitude ?? 0);
                            } else {
                              dataProvider.setToData(
                                  placePredictions[index]
                                      .structuredFormatting
                                      .mainText,
                                  coordinates.latitude ?? 0,
                                  coordinates.longitude ?? 0);
                            }
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        placePredictions[index]
                                            .structuredFormatting
                                            .mainText,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
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
                        ),
                      )),
            ),
            Spacer(),
            PrimaryNextButton(
              buttonText: "Ara",
              onPressed: () {},
              isDoubleInfinity: true,
            ),
          ],
        ),
      ),
    );
  }
}
