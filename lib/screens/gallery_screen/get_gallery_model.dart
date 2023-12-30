// To parse this JSON data, do
//
//     final getGalleryModel = getGalleryModelFromJson(jsonString);

import 'dart:convert';

GetGalleryModel getGalleryModelFromJson(String str) => GetGalleryModel.fromJson(json.decode(str));

String getGalleryModelToJson(GetGalleryModel data) => json.encode(data.toJson());

class GetGalleryModel {
  List<Datum> data;
  bool status;
  String message;

  GetGalleryModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory GetGalleryModel.fromJson(Map<String, dynamic> json) => GetGalleryModel(
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
  String shopImage;

  Datum({
    required this.id,
    required this.shopImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    shopImage: json["shop_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_image": shopImage,
  };
}
