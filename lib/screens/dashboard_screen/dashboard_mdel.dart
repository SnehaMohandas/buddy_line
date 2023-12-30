// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  bool status;
  String message;
  Data data;

  DashboardModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
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
  List<Offer> specialOffer;
  List<Offer> offers;
  String walletAmount;
  String profileImage;

  Data({
    required this.specialOffer,
    required this.offers,
    required this.walletAmount,
    required this.profileImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    specialOffer: List<Offer>.from(json["special_offer"].map((x) => Offer.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    walletAmount: json["wallet_amount"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "special_offer": List<dynamic>.from(specialOffer.map((x) => x.toJson())),
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
    "wallet_amount": walletAmount,
    "profile_image": profileImage,
  };
}

class Offer {
  String productId;
  String image;
  String productName;
  String offerPrice;
  String regularPrice;
  String isOffer;
  String expiryDate;
  String schemeBenefit;
  bool isSchemeBenefit;
  bool isExpand;

  Offer({
    required this.productId,
    required this.image,
    required this.productName,
    required this.offerPrice,
    required this.regularPrice,
    required this.isOffer,
    required this.expiryDate,
    required this.schemeBenefit,
    required this.isSchemeBenefit,
    required this.isExpand,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    productId: json["product_id"],
    image: json["image"],
    productName: json["product_name"],
    offerPrice: json["offer_price"],
    regularPrice: json["regular_price"],
    isOffer: json["is_offer"],
    expiryDate: json["expiry_date"],
    schemeBenefit: json["scheme_benefit"],
    isSchemeBenefit: json["is_scheme_benefit"],
    isExpand: json["is_expand"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "image": image,
    "product_name": productName,
    "offer_price": offerPrice,
    "regular_price": regularPrice,
    "is_offer": isOffer,
    "expiry_date": expiryDate,
    "scheme_benefit": schemeBenefit,
    "is_scheme_benefit": isSchemeBenefit,
    "is_expand": isExpand,
  };
}
