// To parse this JSON data, do
//
//     final allProductsModel = allProductsModelFromJson(jsonString);

import 'dart:convert';

AllProductsModel allProductsModelFromJson(String str) => AllProductsModel.fromJson(json.decode(str));

String allProductsModelToJson(AllProductsModel data) => json.encode(data.toJson());

class AllProductsModel {
  bool status;
  String message;
  List<Datum> data;

  AllProductsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) => AllProductsModel(
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
  String productId;
  String image;
  String productName;
  String regularPrice;

  Datum({
    required this.productId,
    required this.image,
    required this.productName,
    required this.regularPrice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    productId: json["product_id"],
    image: json["image"],
    productName: json["product_name"],
    regularPrice: json["regular_price"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "image": image,
    "product_name": productName,
    "regular_price": regularPrice,
  };
}
