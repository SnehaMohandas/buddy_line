// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  Data data;
  bool status;
  String message;

  EditProfileModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
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
  String userId;
  String profileImage;
  String name;
  String phone;
  String address1;
  String address2;
  String areaId;
  String pinCode;
  String districtId;
  String whatsappNo;
  String pancardNo;
  String adharcardNo;
  String dateOfBirth;
  String dateOfMarriage;
  String workshopAddress;
  String latitude;
  String longitude;
  String accountNo;
  String bankName;
  String ifsc;
  String upiId;
  String preferredDealer;

  Data({
    required this.userId,
    required this.profileImage,
    required this.name,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.areaId,
    required this.pinCode,
    required this.districtId,
    required this.whatsappNo,
    required this.pancardNo,
    required this.adharcardNo,
    required this.dateOfBirth,
    required this.dateOfMarriage,
    required this.workshopAddress,
    required this.latitude,
    required this.longitude,
    required this.accountNo,
    required this.bankName,
    required this.ifsc,
    required this.upiId,
    required this.preferredDealer,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    profileImage: json["profile_image"],
    name: json["name"],
    phone: json["phone"],
    address1: json["address1"],
    address2: json["address2"],
    areaId: json["area_id"],
    pinCode: json["pin_code"],
    districtId: json["district_id"],
    whatsappNo: json["whatsapp_no"],
    pancardNo: json["pancard_no"],
    adharcardNo: json["adharcard_no"],
    dateOfBirth: json["date_of_birth"],
    dateOfMarriage: json["date_of_marriage"],
    workshopAddress: json["workshop_address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    accountNo: json["account_no"],
    bankName: json["bank_name"],
    ifsc: json["ifsc"],
    upiId: json["upi_id"],
    preferredDealer: json["preferred_dealer"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profile_image": profileImage,
    "name": name,
    "phone": phone,
    "address1": address1,
    "address2": address2,
    "area_id": areaId,
    "pin_code": pinCode,
    "district_id": districtId,
    "whatsapp_no": whatsappNo,
    "pancard_no": pancardNo,
    "adharcard_no": adharcardNo,
    "date_of_birth": dateOfBirth,
    "date_of_marriage": dateOfMarriage,
    "workshop_address": workshopAddress,
    "latitude": latitude,
    "longitude": longitude,
    "account_no": accountNo,
    "bank_name": bankName,
    "ifsc": ifsc,
    "upi_id": upiId,
    "preferred_dealer": preferredDealer,
  };
}
