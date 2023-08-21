// ignore_for_file: prefer_const_constructors, file_names, prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, avoid_print

import 'package:aldigitti/Models/PlaceAutoCompleteResponse.dart';
import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:aldigitti/ViewModels/PrimaryLocationSelectionViewModel.dart';
import 'package:aldigitti/Views/Helpers/PrimaryNextButton.dart';
import 'package:aldigitti/Views/Helpers/PrimaryTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimaryLocationSelection extends StatefulWidget {
  final bool isFrom;
  final bool isPublisher;

  const PrimaryLocationSelection(
      {this.isFrom = false, this.isPublisher = false});
  @override
  _PrimaryLocationSelectionState createState() =>
      _PrimaryLocationSelectionState();
}

class _PrimaryLocationSelectionState extends State<PrimaryLocationSelection> {
  TextEditingController _locationController = TextEditingController();
  List<Prediction> placePredictions = [];

  PrimaryLocationSelectionViewModel viewModel =
      PrimaryLocationSelectionViewModel();

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    bool isClicked = false;
    return Scaffold(
      appBar: AppBar(title: Text(widget.isFrom ? "Nereden" : "Nereye")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            PrimaryTextField(
              controller: _locationController,
              icon: Icons.map,
              placeholderText: widget.isFrom ? "Nereden" : "Nereye",
              onChanged: (String? value) async {
                placePredictions =
                    await viewModel.placeAutoComplete(value ?? "i");
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
                          var coordinates =
                              await viewModel.fetchCoordinatesFromPlaceId(
                                  placePredictions[index].placeId);
                          print(coordinates['lat']);
                          print(coordinates['lng']);

                          if (!isClicked) {
                            isClicked = true;
                            if (widget.isFrom) {
                              if (widget.isPublisher) {
                                dataProvider.setDriverFromName(
                                    placePredictions[index]
                                        .structuredFormatting
                                        .mainText);
                                dataProvider
                                    .setDriverFromLat(coordinates['lat'] ?? 0);
                                dataProvider
                                    .setDriverFromLong(coordinates['lng'] ?? 0);
                              } else {
                                dataProvider.setCustomerFromName(
                                    placePredictions[index]
                                        .structuredFormatting
                                        .mainText);
                                dataProvider.setCustomerFromLat(
                                    coordinates['lat'] ?? 0);
                                dataProvider.setCustomerFromLong(
                                    coordinates['lng'] ?? 0);
                              }
                            } else {
                              if (widget.isPublisher) {
                                dataProvider.setDriverToName(
                                    placePredictions[index]
                                        .structuredFormatting
                                        .mainText);
                                dataProvider
                                    .setDriverToLat(coordinates['lat'] ?? 0);
                                dataProvider
                                    .setDriverToLong(coordinates['lng'] ?? 0);
                              } else {
                                dataProvider.setCustomerToName(
                                    placePredictions[index]
                                        .structuredFormatting
                                        .mainText);
                                dataProvider
                                    .setCustomerToLat(coordinates['lat'] ?? 0);
                                dataProvider
                                    .setCustomerToLong(coordinates['lng'] ?? 0);
                              }
                            }
                            Navigator.pop(context);
                            isClicked = false;
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
