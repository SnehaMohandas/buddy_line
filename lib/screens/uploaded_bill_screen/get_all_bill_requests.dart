// To parse this JSON data, do
//
//     final getBillRequstesModel = getBillRequstesModelFromJson(jsonString);

import 'dart:convert';

GetBillRequstesModel getBillRequstesModelFromJson(String str) => GetBillRequstesModel.fromJson(json.decode(str));

String getBillRequstesModelToJson(GetBillRequstesModel data) => json.encode(data.toJson());

class GetBillRequstesModel {
  List<Datum> data;
  bool status;
  String message;

  GetBillRequstesModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory GetBillRequstesModel.fromJson(Map<String, dynamic> json) => GetBillRequstesModel(
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
  String reqId;
  String label;
  String reqDate;
  String status;
  String reqStatus;
  String schemeAmount;
  String uploadedImg;
  String remarks;

  Datum({
    required this.reqId,
    required this.label,
    required this.reqDate,
    required this.status,
    required this.reqStatus,
    required this.schemeAmount,
    required this.uploadedImg,
    required this.remarks,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    reqId: json["req_id"],
    label: json["label"],
    reqDate: json["req_date"],
    status: json["status"],
    reqStatus: json["req_status"],
    schemeAmount: json["scheme_amount"],
    uploadedImg: json["uploaded_img"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "req_id": reqId,
    "label": label,
    "req_date": reqDate,
    "status": status,
    "req_status": reqStatus,
    "scheme_amount": schemeAmount,
    "uploaded_img": uploadedImg,
    "remarks": remarks,
  };
}
