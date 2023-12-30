// To parse this JSON data, do
//
//     final enquirySendModel = enquirySendModelFromJson(jsonString);

import 'dart:convert';

EnquirySendModel enquirySendModelFromJson(String str) => EnquirySendModel.fromJson(json.decode(str));

String enquirySendModelToJson(EnquirySendModel data) => json.encode(data.toJson());

class EnquirySendModel {
  String message;
  bool data;
  bool status;

  EnquirySendModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory EnquirySendModel.fromJson(Map<String, dynamic> json) => EnquirySendModel(
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
