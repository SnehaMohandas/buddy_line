// To parse this JSON data, do
//
//     final billStatusModel = billStatusModelFromJson(jsonString);

import 'dart:convert';

BillStatusModel billStatusModelFromJson(String str) => BillStatusModel.fromJson(json.decode(str));

String billStatusModelToJson(BillStatusModel data) => json.encode(data.toJson());

class BillStatusModel {
  Data data;
  bool status;
  String message;

  BillStatusModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory BillStatusModel.fromJson(Map<String, dynamic> json) => BillStatusModel(
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
  List<Status> status;

  Data({
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": List<dynamic>.from(status.map((x) => x.toJson())),
  };
}

class Status {
  String stsId;
  String displayValue;

  Status({
    required this.stsId,
    required this.displayValue,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    stsId: json["sts_id"],
    displayValue: json["display_value"],
  );

  Map<String, dynamic> toJson() => {
    "sts_id": stsId,
    "display_value": displayValue,
  };
}
