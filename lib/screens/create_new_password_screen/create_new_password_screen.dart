import 'package:buddy_line/screens/create_new_password_screen/create_new_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/color_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/bar_logo.dart';
import '../../widgets/custom_button.dart';
import '../forgot_password_screen/forgot_password_controller.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});

  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final CreateNewPasswordController createNewPasswordController =
            Get.put(CreateNewPasswordController());
        final ForgotPasswordController forgotPasswordController =
            Get.find<ForgotPasswordController>();

        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: BarLogo(context)),
                    const SizedBox(
                      height: 120,
                    ),
                    const Text(
                      'Create new password',
                      style: TextingStyle.headFont24bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Set your new password',
                      style: TextingStyle.font16bold,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(() {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          obscureText:
                              createNewPasswordController.obscureText.value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be empty';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            } else {
                              return null;
                            }
                          },
                          controller: newPasswordTextController,
                          decoration: const InputDecoration(
                            hintText: 'Enter New Password',
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(() {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          obscureText:
                              createNewPasswordController.obscureText.value,
                          // obscureText: ,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password cannot be empty';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            } else {
                              return null;
                            }
                          },
                          controller: confirmPasswordTextController,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                createNewPasswordController.toggleVisibility();
                              },
                              icon: Icon(
                                createNewPasswordController.obscureText.value ==
                                        true
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
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
                      height: 18,
                    ),
                    // PasswordFormField(context, 'Confirm Password'),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (newPasswordTextController.text ==
                              confirmPasswordTextController.text) {
                            createNewPasswordController.updateNewPassword(
                                forgotPasswordController.whatsappNum.value,
                                newPasswordTextController.text);
                          } else {
                            Get.snackbar("Oops", "Password doesn't match");
                          }
                        }
                      },
                      child: CustomButton(
                          'Submit',
                          MediaQuery.of(context).size.width * 0.75,
                          45,
                          ColorConstant.white,
                          ColorConstant.logoblue,
                          18),
                    ),
                    const SizedBox(
                      height: 10,
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
