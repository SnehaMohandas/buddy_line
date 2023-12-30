import 'package:buddy_line/screens/registration_success_screen/registration_success_contrioller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/image_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/bar_logo.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  RegistrationSuccessScreen({super.key});
  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final SuccessController successController =
            Get.put(SuccessController());

        return Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BarLogo(context),
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    'Registration Successful!',
                    style: TextingStyle.headFont28bold,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(AssetImages.approveImg)),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    'You will be redirected to the\nhome page in few seconds...',
                    textAlign: TextAlign.center,
                    style: TextingStyle.font20boldlogoblue,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Click here if you are not redirected automatically',
                    textAlign: TextAlign.center,
                    style: TextingStyle.font20normalLiteBlack,
                  ),
                  const SizedBox(
                    height: 50,
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
