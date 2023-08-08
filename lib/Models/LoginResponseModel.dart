// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  User user;
  String accessToken;
  String expiresIn;

  LoginResponseModel({
    required this.user,
    required this.accessToken,
    required this.expiresIn,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
        "expires_in": expiresIn,
      };
}

class User {
  String id;
  String username;
  String name;
  String surname;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "surname": surname,
      };
}
