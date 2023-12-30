// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  String message;
  Data data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String token;
  String username;
  String userId;

  Data({
    required this.token,
    required this.username,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    username: json["username"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "username": username,
    "user_id": userId,
  };
}
