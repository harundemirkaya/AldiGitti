// ignore_for_file: file_names, avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkManager {
  final String baseUrl = 'https://api.demoapp.gq/v1';

  Future<Map<String, double>> fetchCoordinates(String placeId) async {
    const apiKey = 'AIzaSyByasp53gOABTWi4gwPcSeRYNuP65aWCi8';
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'OK') {
        var location = data['result']['geometry']['location'];
        return {
          'lat': location['lat'],
          'lng': location['lng'],
        };
      } else {
        throw Exception('Error fetching place details: ${data['status']}');
      }
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  static Future<String?> fetchGoogleMapAPI(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("❌ PRINT DEBUG ❌ Error: $e");
    }
    return null;
  }
}
