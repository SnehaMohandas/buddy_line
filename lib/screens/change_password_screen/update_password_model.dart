// To parse this JSON data, do
//
//     final passwordUpdateModel = passwordUpdateModelFromJson(jsonString);

import 'dart:convert';

PasswordUpdateModel passwordUpdateModelFromJson(String str) => PasswordUpdateModel.fromJson(json.decode(str));

String passwordUpdateModelToJson(PasswordUpdateModel data) => json.encode(data.toJson());

class PasswordUpdateModel {
  String message;
  bool data;
  bool status;

  PasswordUpdateModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory PasswordUpdateModel.fromJson(Map<String, dynamic> json) => PasswordUpdateModel(
    message: json["message"],
    data: json["data"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
    "status": status,
  };
}
