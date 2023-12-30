// To parse this JSON data, do
//
//     final payOutRequestListModel = payOutRequestListModelFromJson(jsonString);

import 'dart:convert';

PayOutRequestListModel payOutRequestListModelFromJson(String str) => PayOutRequestListModel.fromJson(json.decode(str));

String payOutRequestListModelToJson(PayOutRequestListModel data) => json.encode(data.toJson());

class PayOutRequestListModel {
  Data data;
  bool status;
  String message;

  PayOutRequestListModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory PayOutRequestListModel.fromJson(Map<String, dynamic> json) => PayOutRequestListModel(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  List<ListElement> lists;
  String walletAmount;

  Data({
    required this.lists,
    required this.walletAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lists: List<ListElement>.from(json["lists"].map((x) => ListElement.fromJson(x))),
    walletAmount: json["wallet_amount"],
  );

  Map<String, dynamic> toJson() => {
    "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
    "wallet_amount": walletAmount,
  };
}

class ListElement {
  String id;
  String reqAmount;
  String status;
  String date;
  String reqStatus;
  Details details;

  ListElement({
    required this.id,
    required this.reqAmount,
    required this.status,
    required this.date,
    required this.reqStatus,
    required this.details,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    reqAmount: json["req_amount"],
    status: json["status"],
    date: json["date"],
    reqStatus: json["req_status"],
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "req_amount": reqAmount,
    "status": status,
    "date": date,
    "req_status": reqStatus,
    "details": details.toJson(),
  };
}

class Details {
  String sts;
  String reqDate;
  String createdDate;
  String paymentMethod;

  Details({
    required this.sts,
    required this.reqDate,
    required this.createdDate,
    required this.paymentMethod,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    sts: json["sts"],
    reqDate: json["req_date"],
    createdDate: json["created_date"],
    paymentMethod: json["payment_method"],
  );

  Map<String, dynamic> toJson() => {
    "sts": sts,
    "req_date": reqDate,
    "created_date": createdDate,
    "payment_method": paymentMethod,
  };
}
