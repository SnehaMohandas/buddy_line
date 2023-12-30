import 'dart:ffi';

import 'package:buddy_line/screens/wallet_screen/payout_request_model.dart';
import 'package:buddy_line/screens/wallet_screen/send_payout_req_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';

class WalletController extends GetxController {
  PayoutRequestModel? payoutRequestModel;
  PayOutRequestListModel? payOutRequestListModel;
  RxBool isLoading = true.obs;
  RxString selectedBox = 'all'.obs;
  RxBool listEmpty = true.obs;
  RxString walletAmount = ''.obs;

  getPayoutRequestList() async {
    isLoading.value = true;
    print('new val---  ${selectedBox.value}');
    print(token);
    payOutRequestListModel =
        await HttpServices.getPayOutRequests(token, selectedBox.value);
    if (payOutRequestListModel != null) {
      if (payOutRequestListModel!.data.lists.isEmpty) {
        print(payOutRequestListModel!.data.walletAmount);
        walletAmount.value = payOutRequestListModel!.data.walletAmount;
        listEmpty.value = true;
        isLoading.value = false;
      } else {
        print(payOutRequestListModel!.data.walletAmount);
        walletAmount.value = payOutRequestListModel!.data.walletAmount;
        listEmpty.value = false;
        isLoading.value = false;
      }
    }
  }

  sendPayoutRequest(amount) async {
    var data = await HttpServices.sendPayoutRequest(token, amount);
    if (data != null) {
      payoutRequestModel = data;
      Fluttertoast.showToast(
        msg: payoutRequestModel!.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.black,
        textColor: ColorConstant.white,
      );
      Get.back();
    } else {
      Fluttertoast.showToast(
        msg: payoutRequestModel!.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.black,
        textColor: ColorConstant.white,
      );
    }
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    getPayoutRequestList();
  }

  @override
  void onInit() {
    getPayoutRequestList();
    super.onInit();
  }
}
