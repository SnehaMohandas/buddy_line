// To parse this JSON data, do
//
//     final registerOtpModel = registerOtpModelFromJson(jsonString);

import 'dart:convert';

RegisterOtpModel registerOtpModelFromJson(String str) => RegisterOtpModel.fromJson(json.decode(str));

String registerOtpModelToJson(RegisterOtpModel data) => json.encode(data.toJson());

class RegisterOtpModel {
  String message;
  bool data;
  bool status;

  RegisterOtpModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory RegisterOtpModel.fromJson(Map<String, dynamic> json) => RegisterOtpModel(
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
