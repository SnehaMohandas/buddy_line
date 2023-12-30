// To parse this JSON data, do
//
//     final widthListModel = widthListModelFromJson(jsonString);

import 'dart:convert';

WidthListModel widthListModelFromJson(String str) => WidthListModel.fromJson(json.decode(str));

String widthListModelToJson(WidthListModel data) => json.encode(data.toJson());

class WidthListModel {
  List<Datum> data;
  bool status;
  String message;

  WidthListModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory WidthListModel.fromJson(Map<String, dynamic> json) => WidthListModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Datum {
  String id;
  String width;

  Datum({
    required this.id,
    required this.width,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
  };
}
