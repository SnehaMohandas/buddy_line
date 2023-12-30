import 'package:buddy_line/screens/roofing_calculator_screen/width_list_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import 'enquiry_send_model.dart';

class RoofingCalcController extends GetxController {
  RxBool enquirySending = false.obs;
  List finalCalculateList = [].obs;
  EnquirySendModel? enquirySendModel;
  RxBool isVisibility = false.obs;
  RxList<Map<String, dynamic>> productDataList = <Map<String, dynamic>>[].obs;
  WidthListModel? widthListModel;
  RxString selectWidth = '3.61'.obs;
  RxBool isLoading = true.obs;
  RxBool responseVal = false.obs;
  RxString sqftTotalString = '0'.obs;
  RxString sqMtrTotalString = '0'.obs;
  RxDouble sqftTotal = 0.0.obs;
  RxDouble sqMtrTotal = 0.0.obs;
  TextEditingController remarkTextController = TextEditingController();

  void addItem(Map<String, dynamic> data) {
    productDataList.add(data);
  }

  void removeItem(int index) {
    productDataList.removeAt(index);
  }

  getWidth() async {
    isLoading.value = true;
    var data = await HttpServices.getWidthLists(token);
    if (data != null) {
      widthListModel = data;
      isLoading.value = false;
    }
  }

  sendEnquiry(totalSqft, totalSqMtr, remarks, details) async {
    var data = await HttpServices.postEnquiry(
        token, totalSqft, totalSqMtr, remarks, details);
    if (data != null) {
      enquirySendModel = data;
      if (enquirySendModel!.status == true) {
        Fluttertoast.showToast(
          msg: enquirySendModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        enquirySending.value = false;
        productDataList.clear();
        sqMtrTotalString.value = '0';
        sqftTotalString.value = '0';
        sqftTotal.value = 0.0;
        sqMtrTotal.value = 0.0;
        remarkTextController.clear();
        isVisibility.value = false;
      } else {
        Fluttertoast.showToast(
          msg: enquirySendModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  @override
  void onInit() {
    getWidth();
    super.onInit();
  }
}
