// To parse this JSON data, do
//
//     final productsDetailByIdModel = productsDetailByIdModelFromJson(jsonString);

import 'dart:convert';

ProductsDetailByIdModel productsDetailByIdModelFromJson(String str) => ProductsDetailByIdModel.fromJson(json.decode(str));

String productsDetailByIdModelToJson(ProductsDetailByIdModel data) => json.encode(data.toJson());

class ProductsDetailByIdModel {
  bool status;
  String message;
  Data data;

  ProductsDetailByIdModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductsDetailByIdModel.fromJson(Map<String, dynamic> json) => ProductsDetailByIdModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String productId;
  String productName;
  String regularPrice;
  String offerPrice;
  String expiryDate;
  bool isOffer;
  String dimension;
  String description;
  String schemeAmount;
  bool isScheme;
  String brochureImg;
  bool isBrochure;
  String pdfImg;
  bool isPdf;
  List<Image> images;

  Data({
    required this.productId,
    required this.productName,
    required this.regularPrice,
    required this.offerPrice,
    required this.expiryDate,
    required this.isOffer,
    required this.dimension,
    required this.description,
    required this.schemeAmount,
    required this.isScheme,
    required this.brochureImg,
    required this.isBrochure,
    required this.pdfImg,
    required this.isPdf,
    required this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["product_id"],
    productName: json["product_name"],
    regularPrice: json["regular_price"],
    offerPrice: json["offer_price"],
    expiryDate: json["expiry_date"],
    isOffer: json["is_offer"],
    dimension: json["dimension"],
    description: json["description"],
    schemeAmount: json["scheme_amount"],
    isScheme: json["is_scheme"],
    brochureImg: json["brochure_img"],
    isBrochure: json["is_brochure"],
    pdfImg: json["pdf_img"],
    isPdf: json["is_pdf"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "regular_price": regularPrice,
    "offer_price": offerPrice,
    "expiry_date": expiryDate,
    "is_offer": isOffer,
    "dimension": dimension,
    "description": description,
    "scheme_amount": schemeAmount,
    "is_scheme": isScheme,
    "brochure_img": brochureImg,
    "is_brochure": isBrochure,
    "pdf_img": pdfImg,
    "is_pdf": isPdf,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  String imgPath;

  Image({
    required this.imgPath,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imgPath: json["img_path"],
  );

  Map<String, dynamic> toJson() => {
    "img_path": imgPath,
  };
}
