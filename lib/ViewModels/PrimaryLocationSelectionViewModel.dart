// ignore_for_file: avoid_print, file_names
import 'package:aldigitti/Models/PlaceAutoCompleteResponse.dart';
import 'package:aldigitti/Services/NetworkManager.dart';
import 'dart:convert';

class PrimaryLocationSelectionViewModel {
  NetworkManager networkManager = NetworkManager();

  Future<List<Prediction>> placeAutoComplete(String query) async {
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
        return result.predictions;
      }
    }
    return [];
  }

  Future<Map<String, double>> fetchCoordinatesFromPlaceId(
      String placeId) async {
    const apiKey = "AIzaSyByasp53gOABTWi4gwPcSeRYNuP65aWCi8";
    final uri =
        Uri.https("maps.googleapis.com", "/maps/api/place/details/json", {
      "placeid": placeId,
      "key": apiKey,
    });

    String? response = await NetworkManager.fetchGoogleMapAPI(uri);
    Map<String, dynamic> jsonData = json.decode(response ?? "");

    if (jsonData['status'] == 'OK') {
      var location = jsonData['result']['geometry']['location'];
      return {
        'lat': location['lat'].toDouble(),
        'lng': location['lng'].toDouble(),
      };
    } else {
      throw Exception('Error fetching place details: ${jsonData['status']}');
    }
  }
}
