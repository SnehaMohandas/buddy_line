// To parse this JSON data, do
//
//     final deletetransactionModel = deletetransactionModelFromJson(jsonString);

import 'dart:convert';

DeletetransactionModel deletetransactionModelFromJson(String str) => DeletetransactionModel.fromJson(json.decode(str));

String deletetransactionModelToJson(DeletetransactionModel data) => json.encode(data.toJson());

class DeletetransactionModel {
  String message;
  bool data;
  bool status;

  DeletetransactionModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory DeletetransactionModel.fromJson(Map<String, dynamic> json) => DeletetransactionModel(
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
