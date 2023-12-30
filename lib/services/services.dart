import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/bill_details_screen/get_bill_details_model.dart';
import '../screens/change_password_screen/check_password_model.dart';
import '../screens/change_password_screen/update_password_model.dart';
import '../screens/create_new_password_screen/update_password_model.dart';
import '../screens/dashboard_screen/booking_model.dart';
import '../screens/dashboard_screen/dashboard_mdel.dart';
import '../screens/dashboard_screen/upload_bill_model.dart';
import '../screens/edit_profile_screen/get_profile_model.dart';
import '../screens/edit_profile_screen/update_profile_model.dart';
import '../screens/forgot_password_screen/forgot_password_model.dart';
import '../screens/gallery_screen/add_image_model.dart';
import '../screens/gallery_screen/delete_gallery_image_model.dart';
import '../screens/gallery_screen/get_gallery_model.dart';
import '../screens/login_screen/login_model.dart';
import '../screens/product_details_screen/product_detail_model.dart';
import '../screens/products_screen/all_products_model.dart';
import '../screens/roofing_calculator_screen/enquiry_send_model.dart';
import '../screens/roofing_calculator_screen/width_list_model.dart';
import '../screens/sign_up_screen/dealer_model.dart';
import '../screens/sign_up_screen/get_areas_model.dart';
import '../screens/sign_up_screen/get_district_model.dart';
import '../screens/sign_up_screen/register_otp_model.dart';
import '../screens/sign_up_screen/signup_model.dart';
import '../screens/spash_screen/check_token_model.dart';
import '../screens/uploaded_bill_screen/bill_status_model.dart';
import '../screens/uploaded_bill_screen/delete_request_model.dart';
import '../screens/uploaded_bill_screen/get_all_bill_requests.dart';
import '../screens/wallet_screen/payout_request_model.dart';
import '../screens/wallet_screen/send_payout_req_model.dart';

class HttpServices {
  static Future signingUp(
    name,
    address1,
    address2,
    district,
    whatsappNo,
    adharNo,
    password,
    buddyPhoto,
    glryImg,
    pincode,
  ) async {
    print('glryImg --- $glryImg');
    print('buddyPhoto --- $buddyPhoto');
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${baseUrl}postRegister'));
      request.fields.addAll({
        'name': name,
        'address_1': address1,
        'address_2': address2,
        'district': district,
        'whatsapp_no': whatsappNo,
        'adhar_no': adharNo,
        'password': password,
        'pin_code': pincode,
      });
      if (buddyPhoto != '') {
        request.files
            .add(await http.MultipartFile.fromPath('buddy_photo', buddyPhoto));
      }
      if (glryImg.length > 0) {
        for (int i = 0; i < glryImg.length; i++) {
          request.files.add(await http.MultipartFile.fromPath(
              'glry_img[]', glryImg[i].path.toString()));
        }
      }

      http.StreamedResponse response = await request.send();
      final res = await http.Response.fromStream(response);

      print(response.statusCode);
      if (response.statusCode == 200) {
// print("11111");
        print(res.statusCode);
        return signupModelFromJson(res.body);
      } else if (response.statusCode == 401) {
        print('okeyyy');
        return null;
      } else {
// print("11113");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future userLogin(userName, password, deviceToken) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}login"),
        body: ({
          'user_name': userName,
          'password': password,
          'device_token': deviceToken
        }));
    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    }
  }

  static Future getDashboard(
    token,
  ) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}getAllOfferProducts"),
            body: ({
              'token': token,
            }));
    if (response.statusCode == 200) {
      return dashboardModelFromJson(response.body);
    }
  }

  static Future allProducts(
    token,
  ) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}getProducts"),
        body: ({
          'token': token,
        }));
    if (response.statusCode == 200) {
      return allProductsModelFromJson(response.body);
    }
  }

  static Future productDetailById(token, productId) async {
    http.Response response = await http.post(
        Uri.parse("${baseUrl}getProductById"),
        body: ({'token': token, 'product_id': productId}));
    if (response.statusCode == 200) {
      return productsDetailByIdModelFromJson(response.body);
    }
  }

  static Future registeringOTP(number, otp) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}sentOtp"),
        body: ({'phone_number': number, 'otp': otp}));
    if (response.statusCode == 200) {
      return registerOtpModelFromJson(response.body);
    }
  }

  static Future getDistrictList() async {
    String url = '${await baseUrl}getDistrict';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return getDistrictModelFromJson(response.body);
    } else {}
  }

  static Future getAreas() async {
    String url = '${await baseUrl}getArea';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return getAreasModelFromJson(response.body);
    } else {}
  }

  static Future getDealer() async {
    String url = '${await baseUrl}getDealers';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return dealerModelFromJson(response.body);
    } else {}
  }

  static Future forgotOtp(number, otp) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}forgotOtp"),
        body: ({'phone_number': number, 'otp': otp}));
    if (response.statusCode == 200) {
      return forgotOtpModelFromJson(response.body);
    }
  }

  static Future updatePassword(number, password) async {
    http.Response response = await http.post(
        Uri.parse("${baseUrl}updatePassword"),
        body: ({'phone_number': number, 'password': password}));
    if (response.statusCode == 200) {
      return updatePasswordModelFromJson(response.body);
    }
  }

  static Future uploadBill(token, billImage) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${baseUrl}uploadBill'));
      request.fields.addAll({
        'token': token,
      });
      if (billImage != "") {
        request.files
            .add(await http.MultipartFile.fromPath('upload_img', billImage));
      }
      http.StreamedResponse response = await request.send();
      final res = await http.Response.fromStream(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print("11111");
        // print(res.statusCode);
        return uploadBillModelFromJson(res.body);
      } else if (response.statusCode == 401) {
        return null;
      } else {
        // print("11113");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future getBillStatus(token) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}getStatus"),
        body: ({
          'token': token,
        }));
    if (response.statusCode == 200) {
      return billStatusModelFromJson(response.body);
    }
  }

  static Future getBillupdatesList(token, fDate, tDate, status) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}getStatus"),
        body: ({
          'token': token,
          'fdate': fDate,
          'Tdate': tDate,
          'status': status
        }));
    if (response.statusCode == 200) {
      return (response.body);
    }
  }

  static Future sendPayoutRequest(token, reqAmount) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}payoutRequest"),
            body: ({
              'token': token,
              'req_amount': reqAmount,
            }));
    if (response.statusCode == 200) {
      return payoutRequestModelFromJson(response.body);
    }
  }

  static Future getBillRequests(token, fromDate, toDate, status) async {
    print(status);
    http.Response response = await http.post(
        Uri.parse("${baseUrl}getBillRequests"),
        body: ({
          'token': token,
          'from_date': fromDate,
          'to_date': toDate,
          'status': status
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return getBillRequstesModelFromJson(response.body);
    }
  }

  static Future getBillDetails(
    token,
    reqstId,
  ) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}getBillDetails"),
            body: ({
              'token': token,
              'request_id': reqstId,
            }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return billDetailsModelFromJson(response.body);
    }
  }

  static Future getPayOutRequests(
    token,
    status,
  ) async {
    print('new - - - -  $status');
    http.Response response =
        await http.post(Uri.parse("${baseUrl}getPayOutRequests"),
            body: ({
              'token': token,
              'status': status,
            }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return payOutRequestListModelFromJson(response.body);
    }
  }

  static Future postBookingRequest(
    token,
    productId,
  ) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}postBookingRequest"),
            body: ({
              'token': token,
              'product_id': productId,
            }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return bookingModelFromJson(response.body);
    }
  }

  static Future postEnquiry(
      token, totalSqft, totalSqMtr, remarks, details) async {
    print(jsonEncode(details));
    http.Response response = await http.post(Uri.parse("${baseUrl}postEnquiry"),
        body: ({
          'token': token,
          'total_sq_ft': totalSqft,
          'total_sq_mtr': totalSqMtr,
          'remarks': remarks,
          'enq_details': jsonEncode(details),
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return enquirySendModelFromJson(response.body);
    }
  }

  static Future getProfile(
    token,
  ) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}getProfile"),
        body: ({
          'token': token,
        }));
    if (response.statusCode == 200) {
      return editProfileModelFromJson(response.body);
    }
  }

  static Future updateProfile(
      token,
      name,
      address1,
      address2,
      district,
      adharNo,
      buddyPhoto,
      pincode,
      pancard,
      dob,
      dom,
      workshop,
      latitude,
      longitude,
      accountNo,
      bankName,
      Ifsc,
      upiId,
      dealer) async {
    print(token);
    print(address1);
    print(address2);
    print(adharNo);
    print(pincode);
    print(pancard);
    print('buddyPhoto --- $buddyPhoto');
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${baseUrl}updateProfile'));
      request.fields.addAll({
        'token': token,
        'name': name,
        'address1': address1,
        'address2': address2,
        'district_id': district,
        'adharcard_no': adharNo,
        'pin_code': pincode,
        'pancard_no': pancard,
        'date_of_birth': dob,
        'date_of_marriage': dom,
        'workshop_address ': workshop,
        'latitude': latitude,
        'longitude': longitude,
        'account_no': accountNo,
        'bank_name': bankName,
        'ifsc': Ifsc,
        'upi_id': upiId,
        'preferred_dealer': dealer,
      });
      if (buddyPhoto != '') {
        request.files.add(
            await http.MultipartFile.fromPath('profile_image', buddyPhoto));
      }

      http.StreamedResponse response = await request.send();
      final res = await http.Response.fromStream(response);

      print(response.statusCode);
      if (response.statusCode == 200) {
// print("11111");
        print(res.statusCode);
        return updateProfileModelFromJson(res.body);
      } else if (response.statusCode == 401) {
        print('okeyyy');
        return null;
      } else {
// print("11113");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getShopImages(
    token,
  ) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}getGalleryImages"),
            body: ({
              'token': token,
            }));
    if (response.statusCode == 200) {
      return getGalleryModelFromJson(response.body);
    }
  }

  static Future DeleteImageById(token, imageId) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}deleteShopImage"),
            body: ({
              'token': token,
              'img_id': imageId,
            }));
    if (response.statusCode == 200) {
      return deleteImageGalleryModelFromJson(response.body);
    }
  }

  static Future addImageToGallery(token, image) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${baseUrl}postShopImage'));
      request.fields.addAll({
        'token': token,
      });
      if (image != '') {
        request.files
            .add(await http.MultipartFile.fromPath('glry_img[]', image));
      }

      http.StreamedResponse response = await request.send();
      final res = await http.Response.fromStream(response);

      print(response.statusCode);
      if (response.statusCode == 200) {
// print("11111");
        print(res.statusCode);
        return addImageModelFromJson(res.body);
      } else if (response.statusCode == 401) {
        print('okeyyy');
        return null;
      } else {
// print("11113");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getWidthLists(
    token,
  ) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}getWidthLists"),
            body: ({
              'token': token,
            }));
    if (response.statusCode == 200) {
      return widthListModelFromJson(response.body);
    }
  }

  static Future checkCurrentPassword(token, currentPassword) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}checkCurrentPassword"),
            body: ({
              'token': token,
              'current_password': currentPassword,
            }));
    if (response.statusCode == 200) {
      return checkPasswordModelFromJson(response.body);
    }
  }

  static Future setNewPassword(token, newPass) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}setNewPassword"),
            body: ({
              'token': token,
              'new_password': newPass,
            }));
    if (response.statusCode == 200) {
      return passwordUpdateModelFromJson(response.body);
    }
  }

  static Future deleteRequest(token, Id) async {
    http.Response response =
        await http.post(Uri.parse("${baseUrl}deleteRequest"),
            body: ({
              'token': token,
              'req_id': Id,
            }));
    if (response.statusCode == 200) {
      print(response.statusCode);
      return deletetransactionModelFromJson(response.body);
    }
  }

  static Future checkToken(
    token,
  ) async {
    http.Response response = await http.post(Uri.parse("${baseUrl}checkToken"),
        body: ({
          'token': token,
        }));
    if (response.statusCode == 200) {
      return checkTokenModelFromJson(response.body);
    }
  }
}
