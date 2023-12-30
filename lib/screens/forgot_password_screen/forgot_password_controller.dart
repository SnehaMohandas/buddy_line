import 'dart:math';

import 'package:buddy_line/screens/password_verification_otp_screen/password_verification_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../../services/services.dart';
import '../sign_up_screen/register_otp_model.dart';
import 'forgot_password_model.dart';

class ForgotPasswordController extends GetxController {
  RxString otp = ''.obs;
  RxString whatsappNum = ''.obs;
  ForgotOtpModel? forgotOtpModel;

  sendOtp(whatsapp) async {
    whatsappNum.value = whatsapp;
    otp.value = await generateRandomNumbers(1);
    print(otp);

    var data = await HttpServices.forgotOtp(whatsappNum.value, otp.value);
    if (data != null) {
      forgotOtpModel = data;
      if (forgotOtpModel!.status == true) {
        Fluttertoast.showToast(
          msg: forgotOtpModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.to(
            duration: const Duration(microseconds: 900),
            transition: Transition.leftToRight,
            PasswordVerification(
              whatsappNumber: whatsappNum.value,
            ));
      } else {
        Fluttertoast.showToast(
          msg: forgotOtpModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  generateRandomNumbers(int count) {
    Random random = Random();
    int randomNumber;
    var otp = '';

    for (int i = 0; i < count; i++) {
      randomNumber = random.nextInt(9000) + 1000;
      // print('otp : $randomNumber');
      otp = randomNumber.toString();
    }
    return otp;
  }
}
