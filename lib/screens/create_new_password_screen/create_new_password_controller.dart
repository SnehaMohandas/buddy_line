import 'package:buddy_line/screens/create_new_password_screen/update_password_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../login_screen/login_screen.dart';

class CreateNewPasswordController extends GetxController {
  UpdatePasswordModel? updatePasswordModel;
  var obscureText = true.obs;

  toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  updateNewPassword(phonenumber, password) async {
    var data = await HttpServices.updatePassword(phonenumber, password);
    if (data != null) {
      updatePasswordModel = data;
      if (updatePasswordModel!.status == true) {
        Fluttertoast.showToast(
          msg: updatePasswordModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.to(
            duration: const Duration(microseconds: 900),
            transition: Transition.leftToRight,
            LoginScreen());
      } else {
        Fluttertoast.showToast(
          msg: updatePasswordModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }
}
