import 'package:buddy_line/controller/network_controller.dart';
import 'package:buddy_line/screens/change_password_screen/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../../consts/text_styles.dart';
import '../../widgets/custom_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  TextEditingController currentPasswordTextController = TextEditingController();
  final NetworkController networkController = Get.find<NetworkController>();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value == true) {
        final ChangePasswordController changePasswordController =
            Get.put(ChangePasswordController());
        return Scaffold(
          appBar: AppBar(
            title: const Text('Change your Password'),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  changePasswordController.verified.value == false
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 13,
                            ),
                            const Text(
                              'Tye your current password',
                              style: TextingStyle.font16bold,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: TextFormField(
                                  obscureText: changePasswordController
                                      .obscureText.value,
                                  controller: currentPasswordTextController,
                                  decoration: InputDecoration(
                                    hintText: 'Current Password',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        changePasswordController
                                            .toggleVisibility();
                                      },
                                      icon: changePasswordController
                                                  .obscureText.value ==
                                              true
                                          ? const Icon(
                                              Icons.remove_red_eye_outlined)
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
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                changePasswordController.checkCurrentPassword(
                                    currentPasswordTextController.text);
                              },
                              child: CustomButton(
                                  'Verify',
                                  MediaQuery.of(context).size.width * 0.45,
                                  45,
                                  ColorConstant.white,
                                  ColorConstant.logoblue,
                                  18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
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
                                height: 15,
                              ),
                              Obx(() {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    obscureText: changePasswordController
                                        .obscureText1.value,
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
                                height: 20,
                              ),
                              Obx(() {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    obscureText: changePasswordController
                                        .obscureText1.value,
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
                                          changePasswordController
                                              .toggleVisibility1();
                                        },
                                        icon: Icon(
                                          changePasswordController
                                                      .obscureText1.value ==
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
                                      // changePasswordController.updateNewPassword(
                                      //     forgotPasswordController.whatsappNum.value,
                                      //     );
                                      changePasswordController.resetPassword(
                                          newPasswordTextController.text);
                                    } else {
                                      Get.snackbar(
                                          "Oops", "Password doesn't match",
                                          colorText: ColorConstant.redcolor);
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
                ],
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
