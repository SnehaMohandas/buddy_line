// To parse this JSON data, do
//
//     final uploadBillModel = uploadBillModelFromJson(jsonString);

import 'dart:convert';

UploadBillModel uploadBillModelFromJson(String str) => UploadBillModel.fromJson(json.decode(str));

String uploadBillModelToJson(UploadBillModel data) => json.encode(data.toJson());

class UploadBillModel{
  String message;
  bool data;
  bool status;

  UploadBillModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory UploadBillModel.fromJson(Map<String, dynamic> json) => UploadBillModel(
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
