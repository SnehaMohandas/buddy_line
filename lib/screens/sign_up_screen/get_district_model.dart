// To parse this JSON data, do
//
//     final getDistrictModel = getDistrictModelFromJson(jsonString);

import 'dart:convert';

GetDistrictModel getDistrictModelFromJson(String str) => GetDistrictModel.fromJson(json.decode(str));

String getDistrictModelToJson(GetDistrictModel data) => json.encode(data.toJson());

class GetDistrictModel {
  bool status;
  String message;
  List<Datum> data;

  GetDistrictModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetDistrictModel.fromJson(Map<String, dynamic> json) => GetDistrictModel(
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
  String districtId;
  String districtName;

  Datum({
    required this.districtId,
    required this.districtName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    districtId: json["district_id"],
    districtName: json["district_name"],
  );

  Map<String, dynamic> toJson() => {
    "district_id": districtId,
    "district_name": districtName,
  };
}
