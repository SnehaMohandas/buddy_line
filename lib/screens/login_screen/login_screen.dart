import 'package:buddy_line/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:buddy_line/screens/login_screen/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/color_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/bar_logo.dart';
import '../../widgets/custom_button.dart';
import '../forgot_password_screen/forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: BarLogo(context)),
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'Login',
                      style: TextingStyle.headFont28bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Enter your login details',
                      style: TextingStyle.font16bold,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: usernameTextController,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Obx(() {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          obscureText: loginController.obscureText.value,
                          controller: passwordTextController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginController.toggleVisibility();
                              },
                              icon: loginController.obscureText.value == true
                                  ? const Icon(Icons.remove_red_eye_outlined)
                                  : const Icon(
                                      Icons.visibility_off_outlined,
                                      color: ColorConstant.blacklite,
                                      size: 22,
                                    ),
                            ),
                            contentPadding: const EdgeInsets.all(8),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        loginController.login(usernameTextController.text,
                            passwordTextController.text);
                      },
                      child: CustomButton(
                          'Login',
                          MediaQuery.of(context).size.width * 0.75,
                          45,
                          ColorConstant.white,
                          ColorConstant.logoblue,
                          18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Forgot Password ? ',
                          style: TextingStyle.font16NormalBlackLite,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(
                                  duration: const Duration(microseconds: 900),
                                  transition: Transition.leftToRight,
                                  ForgotPasswordScreen());
                            },
                            child: const Text(
                              'Click here!',
                              style: TextingStyle.font16bold,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
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
