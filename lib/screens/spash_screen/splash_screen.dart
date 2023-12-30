import 'package:buddy_line/screens/spash_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/image_constants.dart';
import '../../controller/network_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final NetworkController networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        SplashController splashController = Get.put(SplashController());
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetImages.splashImg))),
              )
            ],
          ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }
}
