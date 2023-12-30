import 'package:buddy_line/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:buddy_line/screens/dashboard_screen/dashboard_screen.dart';
import 'package:buddy_line/services/services.dart';
import 'package:get/get.dart';

import '../../consts/user_data.dart';
import '../../shared_preference/shared_preference.dart';
import '../login_or_signup_selection_screen/login_signup_selection_screen.dart';
import 'check_token_model.dart';

class SplashController extends GetxController {
  CheckTokenModel? checkTokenModel;

  splashOn() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        name = await CommonFunction.getSavedKey('username');
        token = await CommonFunction.getSavedKey('token');
        userId = await CommonFunction.getSavedKey('userId');
        print(' ------$name');
        if (name == null) {
          Get.offAll(LoginSignupSelectionScreen());
        } else {
          checkToken();
        }
      },
    );
  }

  checkToken() async {
    checkTokenModel = await HttpServices.checkToken(token);
    if (checkTokenModel != null && checkTokenModel!.status == true) {
      Get.to(BottomNavigationScreen());
    } else {
      Get.offAll(LoginSignupSelectionScreen());
    }
  }

  @override
  void onInit() {
    splashOn();
    super.onInit();
  }
}
