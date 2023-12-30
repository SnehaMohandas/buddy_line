// To parse this JSON data, do
//
//     final addImageModel = addImageModelFromJson(jsonString);

import 'dart:convert';

AddImageModel addImageModelFromJson(String str) => AddImageModel.fromJson(json.decode(str));

String addImageModelToJson(AddImageModel data) => json.encode(data.toJson());

class AddImageModel {
  String message;
  bool data;
  bool status;

  AddImageModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory AddImageModel.fromJson(Map<String, dynamic> json) => AddImageModel(
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
