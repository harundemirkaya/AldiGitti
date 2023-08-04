// ignore_for_file: avoid_print

import 'package:aldigitti/Models/LoginResponseModel.dart';
import 'package:aldigitti/Services/NetworkManager.dart';
import 'dart:convert';

class LoginViewModel {
  NetworkManager networkManager = NetworkManager();

  Future<LoginResponseModel> registerUser(Map<String, dynamic> user) async {
    final response = await networkManager.post('/auth/login', user);
    if (response.statusCode == 201) {
      print("✅ PRINT DEBUG ✅ Success Login");
      print('HTTP Status Code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      print("❌ PRINT DEBUG ❌ Failed Login");
      print('HTTP Status Code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to register user');
    }
  }
}
