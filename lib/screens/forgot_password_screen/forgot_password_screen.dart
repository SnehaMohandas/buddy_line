import 'package:buddy_line/screens/forgot_password_screen/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/color_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/bar_logo.dart';
import '../../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  TextEditingController phoneNumberTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final ForgotPasswordController forgotPasswordController =
            Get.put(ForgotPasswordController());

        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: BarLogo(context),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    const Text(
                      'Forgot Password',
                      style: TextingStyle.headFont28bold,
                    ),
                    const Text(
                      'Reset your password using\nWhatsapp number',
                      textAlign: TextAlign.center,
                      style: TextingStyle.font16bold,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Must enter phone number';
                          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Invalid phone number. Please enter 10 digits.';
                          } else {
                            return null;
                          }
                        },
                        controller: phoneNumberTextController,
                        decoration: const InputDecoration(
                          hintText: 'whatsapp number',
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            forgotPasswordController
                                .sendOtp(phoneNumberTextController.text);
                          }
                        },
                        child: CustomButton(
                            'Submit',
                            MediaQuery.of(context).size.width * 0.75,
                            45,
                            ColorConstant.white,
                            ColorConstant.logoblue,
                            18)),
                    const SizedBox(
                      height: 35,
                    ),
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
