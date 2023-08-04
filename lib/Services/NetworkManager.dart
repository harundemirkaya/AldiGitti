// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkManager {
  final String baseUrl = 'https://api.demoapp.gq/v1';

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }
}
