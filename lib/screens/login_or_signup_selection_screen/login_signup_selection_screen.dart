import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/consts/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/custom_button.dart';
import '../login_screen/login_screen.dart';
import '../sign_up_screen/signup_screen.dart';

class LoginSignupSelectionScreen extends StatelessWidget {
  LoginSignupSelectionScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        return Scaffold(
          backgroundColor: ColorConstant.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 220,
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetImages.splashImg))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const Text(
                    //   "We're all about turning your financial dreams into a reality",
                    //   textAlign: TextAlign.center,
                    //   style: TextingStyle.font20normal,
                    // ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(
                                  duration: const Duration(microseconds: 900),
                                  transition: Transition.leftToRight,
                                  SignupScreen());
                            },
                            child: CustomButton(
                                'Sign up',
                                150,
                                45,
                                ColorConstant.white,
                                ColorConstant.logoblue,
                                18)),
                        GestureDetector(
                            onTap: () {
                              Get.to(
                                  duration: const Duration(microseconds: 900),
                                  transition: Transition.leftToRight,
                                  LoginScreen());
                            },
                            child: CustomButton(
                                'Login',
                                150,
                                45,
                                ColorConstant.white,
                                ColorConstant.logoblue,
                                18)),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }
}
