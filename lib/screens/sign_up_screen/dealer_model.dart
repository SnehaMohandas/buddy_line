// To parse this JSON data, do
//
//     final dealerModel = dealerModelFromJson(jsonString);

import 'dart:convert';

DealerModel dealerModelFromJson(String str) => DealerModel.fromJson(json.decode(str));

String dealerModelToJson(DealerModel data) => json.encode(data.toJson());

class DealerModel {
  bool status;
  String message;
  List<Datum> data;

  DealerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String dealerName;

  Datum({
    required this.id,
    required this.dealerName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    dealerName: json["dealer_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dealer_name": dealerName,
  };
}
