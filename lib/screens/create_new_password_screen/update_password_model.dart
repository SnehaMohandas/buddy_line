// To parse this JSON data, do
//
//     final updatePasswordModel = updatePasswordModelFromJson(jsonString);

import 'dart:convert';

UpdatePasswordModel updatePasswordModelFromJson(String str) => UpdatePasswordModel.fromJson(json.decode(str));

String updatePasswordModelToJson(UpdatePasswordModel data) => json.encode(data.toJson());

class UpdatePasswordModel {
  String message;
  bool data;
  bool status;

  UpdatePasswordModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) => UpdatePasswordModel(
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
