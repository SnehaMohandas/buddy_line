import 'package:buddy_line/screens/otp_verification_screen/otp_verification_controller.dart';
import 'package:buddy_line/screens/registration_success_screen/registration_success_screen.dart';
import 'package:buddy_line/screens/sign_up_screen/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../consts/color_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/bar_logo.dart';
import '../../widgets/custom_button.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({
    super.key,
  });

  // List<TextEditingController> _controllers ;
  // List<FocusNode> _focusNodes;
  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final OtpVerificationController otpVerificationController =
            Get.put(OtpVerificationController());
        final SignupController signupController = Get.find<SignupController>();
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
                            controller:
                                otpVerificationController.otpController[index],
                            // focusNode: _focusNodes[index],
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            // controller:
                            // AuthController.instance.otpController[index],
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1 && index <= 3) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isNotEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                            decoration: const InputDecoration(
                                counterText: '', hintText: ''),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        otpVerificationController.otpNumber.value = '';
                        for (int i = 0; i < 4; i++) {
                          otpVerificationController.otpNumber.value +=
                              otpVerificationController.otpController[i].text;
                        }
                        // print('typed otp ${otpVerificationController.otpNumber.value}');
                        // print(otpVerificationController.otp.value);
                        // print(otpVerificationController.otpNumber.value);
                        if (signupController.otp.value ==
                            otpVerificationController.otpNumber.value) {
                          Fluttertoast.showToast(
                            msg: 'Verification successful',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorConstant.black,
                            textColor: ColorConstant.white,
                          );
                          signupController.signup(
                              signupController.nameTextController.text,
                              signupController.address1TextController.text,
                              signupController.address2TextController.text,
                              signupController.whatsappTextController.text,
                              signupController.aadhaarTextController.text,
                              signupController.passwordTextController.text,
                              signupController.pinCodeTextController.text);
                        } else {
                          print('no');
                          Fluttertoast.showToast(
                            msg: 'You entered the wrong OTP',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: ColorConstant.black,
                            textColor: ColorConstant.white,
                          );
                          // print('----' + otpVerificationController.otp.value);
                          // print('tttt' + otpVerificationController.otpNumber.value);
                        }
                      },
                      child: CustomButton(
                        'Verify',
                        MediaQuery.of(context).size.width * 0.75,
                        45,
                        ColorConstant.white,
                        ColorConstant.logoblue,
                        18,
                      ),
                    );
                  },
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
                        // otpVerificationController.whatsapp.value = whatsappNo;
                        // signupController.resendValue.value = true;
                        signupController.sendOtp();
                        otpVerificationController.otpController[0].text = '';
                        otpVerificationController.otpController[1].text = '';
                        otpVerificationController.otpController[2].text = '';
                        otpVerificationController.otpController[3].text = '';
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
