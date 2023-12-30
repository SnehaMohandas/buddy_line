import 'package:buddy_line/screens/create_new_password_screen/create_new_password_screen.dart';
import 'package:buddy_line/screens/password_verification_otp_screen/password_verification_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../consts/color_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/bar_logo.dart';
import '../../widgets/custom_button.dart';
import '../forgot_password_screen/forgot_password_controller.dart';

class PasswordVerification extends StatelessWidget {
  PasswordVerification({super.key, required this.whatsappNumber});

  final String whatsappNumber;

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final PasswordVerificationOtpController
            passwordVerificationOtpController =
            Get.put(PasswordVerificationOtpController());
        final ForgotPasswordController forgotPasswordController =
            Get.find<ForgotPasswordController>();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: BarLogo(context)),
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  'Verify your number ',
                  style: TextingStyle.headFont24bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Enter your OTP code here!',
                  style: TextingStyle.font16NormalBlackLite,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50, left: 50),
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (index) => SizedBox(
                          height: 70,
                          width: 55,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: passwordVerificationOtpController
                                .otpController[index],
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1 && index <= 3) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isNotEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            decoration: const InputDecoration(hintText: ''),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    passwordVerificationOtpController.otpNumber.value = '';
                    for (int i = 0; i < 4; i++) {
                      passwordVerificationOtpController.otpNumber.value +=
                          passwordVerificationOtpController
                              .otpController[i].text;
                    }
                    print(
                        'typedotp+${passwordVerificationOtpController.otpNumber.value}');
                    if (passwordVerificationOtpController.otpNumber.value ==
                        forgotPasswordController.otp.value) {
                      Fluttertoast.showToast(
                        msg: 'Verification successful',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: ColorConstant.black,
                        textColor: ColorConstant.white,
                      );
                      Get.to(
                          duration: const Duration(microseconds: 900),
                          transition: Transition.leftToRight,
                          NewPasswordScreen());
                    } else {
                      Fluttertoast.showToast(
                        msg: 'You entered the wrong OTP',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: ColorConstant.black,
                        textColor: ColorConstant.white,
                      );
                    }
                  },
                  child: CustomButton(
                      'Verify',
                      MediaQuery.of(context).size.width * 0.75,
                      45,
                      ColorConstant.white,
                      ColorConstant.logoblue,
                      18),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't get the reset OTP? "),
                    GestureDetector(
                      onTap: () {
                        forgotPasswordController.sendOtp(whatsappNumber);
                        passwordVerificationOtpController
                            .otpController[0].text = '';
                        passwordVerificationOtpController
                            .otpController[1].text = '';
                        passwordVerificationOtpController
                            .otpController[2].text = '';
                        passwordVerificationOtpController
                            .otpController[3].text = '';
                      },
                      child: const Text(
                        'Resend',
                        style: TextingStyle.font14BoldBlack,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }
}
