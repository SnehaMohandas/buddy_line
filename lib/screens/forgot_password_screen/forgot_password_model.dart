// To parse this JSON data, do
//
//     final forgotOtpModel = forgotOtpModelFromJson(jsonString);

import 'dart:convert';

ForgotOtpModel forgotOtpModelFromJson(String str) => ForgotOtpModel.fromJson(json.decode(str));

String forgotOtpModelToJson(ForgotOtpModel data) => json.encode(data.toJson());

class ForgotOtpModel {
  String message;
  bool data;
  bool status;

  ForgotOtpModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ForgotOtpModel.fromJson(Map<String, dynamic> json) => ForgotOtpModel(
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
