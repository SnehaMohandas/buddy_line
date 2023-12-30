// To parse this JSON data, do
//
//     final checkTokenModel = checkTokenModelFromJson(jsonString);

import 'dart:convert';

CheckTokenModel checkTokenModelFromJson(String str) => CheckTokenModel.fromJson(json.decode(str));

String checkTokenModelToJson(CheckTokenModel data) => json.encode(data.toJson());

class CheckTokenModel {
  bool status;
  String message;
  bool data;

  CheckTokenModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CheckTokenModel.fromJson(Map<String, dynamic> json) => CheckTokenModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
