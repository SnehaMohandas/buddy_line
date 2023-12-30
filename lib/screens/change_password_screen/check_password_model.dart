// To parse this JSON data, do
//
//     final checkPasswordModel = checkPasswordModelFromJson(jsonString);

import 'dart:convert';

CheckPasswordModel checkPasswordModelFromJson(String str) => CheckPasswordModel.fromJson(json.decode(str));

String checkPasswordModelToJson(CheckPasswordModel data) => json.encode(data.toJson());

class CheckPasswordModel {
  String message;
  bool data;
  bool status;

  CheckPasswordModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory CheckPasswordModel.fromJson(Map<String, dynamic> json) => CheckPasswordModel(
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
