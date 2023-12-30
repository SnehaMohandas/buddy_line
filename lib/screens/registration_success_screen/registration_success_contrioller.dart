import 'package:get/get.dart';

import '../login_screen/login_screen.dart';

class SuccessController extends GetxController{


  splashOn() {
    Future.delayed(
      const Duration(seconds: 3),
          () async {
          Get.offAll(
              duration: const Duration(microseconds: 900),
              transition: Transition.leftToRight,LoginScreen());
      },
    );
  }

  @override
  void onInit() {
    splashOn();
    super.onInit();
  }

}