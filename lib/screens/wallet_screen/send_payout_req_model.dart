// To parse this JSON data, do
//
//     final payoutRequestModel = payoutRequestModelFromJson(jsonString);

import 'dart:convert';

PayoutRequestModel payoutRequestModelFromJson(String str) => PayoutRequestModel.fromJson(json.decode(str));

String payoutRequestModelToJson(PayoutRequestModel data) => json.encode(data.toJson());

class PayoutRequestModel {
  String message;
  bool data;
  bool status;

  PayoutRequestModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory PayoutRequestModel.fromJson(Map<String, dynamic> json) => PayoutRequestModel(
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
