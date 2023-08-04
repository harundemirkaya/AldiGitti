// ignore_for_file: avoid_print

import 'package:aldigitti/Models/RegisterResponseModel.dart';
import 'package:aldigitti/Services/NetworkManager.dart';
import 'dart:convert';

class RegisterViewModel {
  NetworkManager networkManager = NetworkManager();

  Future<RegisterResponseModel> registerUser(Map<String, dynamic> user) async {
    final response = await networkManager.post('/auth/register', user);
    if (response.statusCode == 201) {
      print("✅ PRINT DEBUG ✅ Success Register");
      print('HTTP Status Code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return RegisterResponseModel.fromJson(jsonDecode(response.body));
    } else {
      print("❌ PRINT DEBUG ❌ Failed Register");
      print('HTTP Status Code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to register user');
    }
  }
}
