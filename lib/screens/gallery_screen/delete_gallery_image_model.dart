// To parse this JSON data, do
//
//     final deleteImageGalleryModel = deleteImageGalleryModelFromJson(jsonString);

import 'dart:convert';

DeleteImageGalleryModel deleteImageGalleryModelFromJson(String str) => DeleteImageGalleryModel.fromJson(json.decode(str));

String deleteImageGalleryModelToJson(DeleteImageGalleryModel data) => json.encode(data.toJson());

class DeleteImageGalleryModel {
  String message;
  bool data;
  bool status;

  DeleteImageGalleryModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory DeleteImageGalleryModel.fromJson(Map<String, dynamic> json) => DeleteImageGalleryModel(
    message: json["message"],
    data: json["data"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
    "status": status,
  };
}
