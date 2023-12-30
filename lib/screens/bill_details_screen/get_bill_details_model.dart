// To parse this JSON data, do
//
//     final billDetailsModel = billDetailsModelFromJson(jsonString);

import 'dart:convert';

BillDetailsModel billDetailsModelFromJson(String str) => BillDetailsModel.fromJson(json.decode(str));

String billDetailsModelToJson(BillDetailsModel data) => json.encode(data.toJson());

class BillDetailsModel {
  Data data;
  bool status;
  String message;

  BillDetailsModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory BillDetailsModel.fromJson(Map<String, dynamic> json) => BillDetailsModel(
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
  String reqId;
  String reqNumber;
  String billNumber;
  String billDate;
  String dealer;
  String billAmount;
  List<ListElement> lists;

  Data({
    required this.reqId,
    required this.reqNumber,
    required this.billNumber,
    required this.billDate,
    required this.dealer,
    required this.billAmount,
    required this.lists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    reqId: json["req_id"],
    reqNumber: json["req_number"],
    billNumber: json["bill_number"],
    billDate: json["bill_date"],
    dealer: json["dealer"],
    billAmount: json["bill_amount"],
    lists: List<ListElement>.from(json["lists"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "req_id": reqId,
    "req_number": reqNumber,
    "bill_number": billNumber,
    "bill_date": billDate,
    "dealer": dealer,
    "bill_amount": billAmount,
    "lists": List<dynamic>.from(lists.map((x) => x.toJson())),
  };
}

class ListElement {
  String productName;
  String unit;
  String amount;
  String qty;
  String totalAmount;

  ListElement({
    required this.productName,
    required this.unit,
    required this.amount,
    required this.qty,
    required this.totalAmount,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    productName: json["product_name"],
    unit: json["unit"],
    amount: json["amount"],
    qty: json["qty"],
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "unit": unit,
    "amount": amount,
    "qty": qty,
    "total_amount": totalAmount,
  };
}
