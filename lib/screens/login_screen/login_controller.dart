import 'package:buddy_line/screens/login_screen/login_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import '../../shared_preference/shared_preference.dart';
import '../bottom_navigation_screen/bottom_navigation_screen.dart';

class LoginController extends GetxController {
  RxString deviceToken = '123'.obs;
  LoginModel? loginModel;
  var obscureText = true.obs;

  toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  login(userName, password) async {
    var data =
        await HttpServices.userLogin(userName, password, deviceToken.value);
    if (data != null) {
      loginModel = data;
      token = loginModel!.data.token;
      name = loginModel!.data.username;
      userId = loginModel!.data.userId;
      if (loginModel!.status == true) {
        Fluttertoast.showToast(
          msg: loginModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        CommonFunction.addDataToSharedPreferences(
            'token', loginModel!.data.token);
        CommonFunction.addDataToSharedPreferences(
            'username', loginModel!.data.username);
        CommonFunction.addDataToSharedPreferences(
            'userId', loginModel!.data.userId);
        Get.offAll(BottomNavigationScreen());
      }
      Fluttertoast.showToast(
        msg: loginModel!.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.black,
        textColor: ColorConstant.white,
      );
    }
  }
}
