import 'package:buddy_line/screens/bottom_navigation_screen/bottom_Navigation_Controller.dart';
import 'package:buddy_line/screens/bottom_navigation_screen/bottom_navigation.dart';
import 'package:buddy_line/screens/products_screen/products_screen.dart';
import 'package:buddy_line/screens/roofing_calculator_screen/roofing_calculator_screen.dart';
import 'package:buddy_line/screens/wallet_screen/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';
import '../../controller/network_controller.dart';
import '../dashboard_screen/dashboard_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () {
            if (networkController.isConnected.value) {
              switch (Get.find<BottomNavigationController>().tabIndex.value) {
                case 0:
                  return DashboardScreen();
                case 1:
                  return RoofingCalculatorScreen();
                case 2:
                  return ProductsScreen();
                default:
                  return WalletScreen();
              }
            } else {
              return networkController.noDataImage(context);
            }
          },
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
