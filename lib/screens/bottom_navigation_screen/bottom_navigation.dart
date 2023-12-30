import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:buddy_line/screens/bottom_navigation_screen/bottom_Navigation_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/color_constants.dart';

class MyBottomNavigationBar extends StatelessWidget {
  BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavyBar(
        containerHeight: 60,
        showElevation: false,
        selectedIndex: controller.tabIndex.value,
        backgroundColor: ColorConstant.logoblue,
        animationDuration: const Duration(milliseconds: 270),
        curve: Curves.easeInOutQuad,
        onItemSelected: (index) {
          controller.changeTabIndex(index);
        },
        itemCornerRadius: 10,
        items: [
          buildBottomNavyBarItem(const Icon(Icons.home), const Text("Home"),
              ColorConstant.black, ColorConstant.black),
          buildBottomNavyBarItem(
              const Icon(Icons.calculate_outlined),
              const Text("Calculator"),
              ColorConstant.black,
              ColorConstant.black),
          buildBottomNavyBarItem(const Icon(Icons.grid_view),
              const Text("Products"), ColorConstant.black, ColorConstant.black),
          buildBottomNavyBarItem(
              const Icon(Icons.account_balance_wallet_rounded),
              const Text("Wallet"),
              ColorConstant.black,
              ColorConstant.black),
        ],
      ),
    );
  }

  buildBottomNavyBarItem(
    Icon icon,
    Text iconName,
    Color activeColor,
    Color inactiveColor,
  ) {
    return BottomNavyBarItem(
      icon: icon,
      title: iconName,
      activeColor: ColorConstant.white,
      inactiveColor: ColorConstant.white,
    );
  }
}
