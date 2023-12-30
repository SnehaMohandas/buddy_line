import 'package:buddy_line/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:buddy_line/screens/change_password_screen/update_password_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import 'check_password_model.dart';

class ChangePasswordController extends GetxController {
  var obscureText = true.obs;
  var obscureText1 = true.obs;
  CheckPasswordModel? checkPasswordModel;
  RxBool verified = false.obs;
  PasswordUpdateModel? passwordUpdateModel;

  toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  toggleVisibility1() {
    obscureText1.value = !obscureText1.value;
  }

  checkCurrentPassword(currentPassword) async {
    var data = await HttpServices.checkCurrentPassword(token, currentPassword);
    if (data != null) {
      checkPasswordModel = data;
      if (checkPasswordModel!.status == true) {
        Fluttertoast.showToast(
          msg: checkPasswordModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        verified.value = true;
      } else {
        Fluttertoast.showToast(
          msg: checkPasswordModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  resetPassword(newPass) async {
    var data = await HttpServices.setNewPassword(token, newPass);
    if (data != null) {
      passwordUpdateModel = data;
      if (passwordUpdateModel!.status == true) {
        Fluttertoast.showToast(
          msg: passwordUpdateModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.offAll(BottomNavigationScreen());
      } else {
        Fluttertoast.showToast(
          msg: passwordUpdateModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }
}
