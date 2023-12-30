import 'dart:async';

import 'package:buddy_line/screens/dashboard_screen/upload_bill_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import 'booking_model.dart';
import 'dashboard_mdel.dart';

class DashboardController extends GetxController {
  RxBool uploading = false.obs;
  var imagePath = ''.obs;
  var submit = false.obs;
  RxBool isVisible = true.obs;
  DashboardModel? dashboardModel;
  UploadBillModel? uploadBillModel;
  RxBool isLoading = true.obs;
  List spclOffer = [];
  RxString dateToday = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  BookingModel? bookingModel;

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  dashboardData() async {
    print('token $token');
    isLoading.value = true;
    var data = await HttpServices.getDashboard(token);
    if (data != null) {
      dashboardModel = data;
      spclOffer = dashboardModel!.data.specialOffer;
      isLoading.value = false;
    }
  }

  pickedImage(context, source) async {
    final image1 =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    try {
      if (image1 != null) {
        imagePath.value = image1.path;
      }
    } on PlatformException catch (e) {
      Get.snackbar('Permission Denied',
          'Please grant access to the gallery to pick an image.');
    }
  }

  uploadbilldata() async {
    if (imagePath.value == '') {
      Fluttertoast.showToast(
        msg: 'Please select bill image',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.black,
        textColor: ColorConstant.white,
      );
    } else {
      uploading.value = true;
      var data = await HttpServices.uploadBill(token, imagePath.value);
      if (data != null) {
        uploadBillModel = data;
        if (uploadBillModel!.status == true) {
          Get.back();
          uploading.value = false;
          imagePath.value == '';
          Fluttertoast.showToast(
            msg: uploadBillModel!.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorConstant.black,
            textColor: ColorConstant.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: uploadBillModel!.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorConstant.black,
            textColor: ColorConstant.white,
          );
        }
      }
    }
  }

  Bookingnow(productId) async {
    isLoading.value = true;
    var data = await HttpServices.postBookingRequest(token, productId);
    if (data != null) {
      bookingModel = data;
      isLoading.value = false;
      Get.back();
      if (bookingModel!.status == true) {
        Fluttertoast.showToast(
          msg: bookingModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: bookingModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    dashboardData();
  }

  @override
  void onInit() {
    dashboardData();
    super.onInit();
    Timer.periodic(const Duration(milliseconds: 500), (_) {
      toggleVisibility();
    });
  }
}
