// To parse this JSON data, do
//
//     final getAreasModel = getAreasModelFromJson(jsonString);

import 'dart:convert';

GetAreasModel getAreasModelFromJson(String str) => GetAreasModel.fromJson(json.decode(str));

String getAreasModelToJson(GetAreasModel data) => json.encode(data.toJson());

class GetAreasModel {
  Data data;
  bool status;
  String message;

  GetAreasModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory GetAreasModel.fromJson(Map<String, dynamic> json) => GetAreasModel(
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
  List<Area> area;

  Data({
    required this.area,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    area: List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "area": List<dynamic>.from(area.map((x) => x.toJson())),
  };
}

class Area {
  String id;
  String areaName;

  Area({
    required this.id,
    required this.areaName,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"],
    areaName: json["area_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area_name": areaName,
  };
}
