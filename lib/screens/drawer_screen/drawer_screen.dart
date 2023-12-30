import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/consts/image_constants.dart';
import 'package:buddy_line/screens/change_password_screen/change_password_screen.dart';
import 'package:buddy_line/screens/dashboard_screen/dashboard_controller.dart';
import 'package:buddy_line/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:buddy_line/screens/gallery_screen/gallery_images_screen.dart';
import 'package:buddy_line/screens/viewer_screen/viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared_preference/shared_preference.dart';
import '../login_or_signup_selection_screen/login_signup_selection_screen.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key}) : super(key: key);

  final DashboardController dashboardController =
      Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Drawer(
            backgroundColor: ColorConstant.logoblue,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .27,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: ColorConstant.logoblue,
                        ),
                        // child: Positioned(
                        //     bottom: 10,
                        //     child: Text('Nayanthara',style: TextingStyle.font14BoldWhite,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 20,
                        ),
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            color: Colors.transparent,
                            image: dashboardController
                                        .dashboardModel!.data.profileImage ==
                                    ''
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(AssetImages.noProfile))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(dashboardController
                                        .dashboardModel!.data.profileImage),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: ColorConstant.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            leading: const SizedBox(
                                width: 25,
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ))),
                            title: const Text("Edit Profile",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            onTap: () => {
                              Get.to(EditProfileScreen()),
                            },
                          ),
                          Container(
                              width: 250,
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffd9d9d9))),
                          ListTile(
                            leading: const SizedBox(
                                width: 25,
                                child: Center(
                                    child: Icon(
                                  Icons.photo,
                                  color: Colors.black,
                                ))),
                            title: const Text("Gallery",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            onTap: () => {
                              Get.to(GalleryScreen()),
                            },
                          ),
                          Container(
                            width: 250,
                            height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffd9d9d9),
                            ),
                          ),
                          ListTile(
                            leading: const SizedBox(
                              width: 25,
                              child: Center(
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            title: const Text("Change Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            onTap: () => {
                              Get.to(ChangePasswordScreen()),
                            },
                          ),
                          Container(
                              width: 250,
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffd9d9d9))),
                          ListTile(
                            leading: const SizedBox(
                                width: 25,
                                child: Center(
                                    child: Icon(
                                  Icons.privacy_tip,
                                  color: Colors.black,
                                ))),
                            title: const Text("Privacy T&C",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            onTap: () => {
                              Get.to(ViewerScreen(
                                  myUrl:
                                      'https://dev2.login2.in/silverLine/home/TermsandConditions',
                                  type: 'page',
                                  title: 'Terms and Condition',
                                  share: false))
                            },
                          ),
                          Container(
                              width: 250,
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffd9d9d9))),
                          ListTile(
                            leading: const SizedBox(
                                width: 25,
                                child: Center(
                                    child: Icon(
                                  Icons.privacy_tip_outlined,
                                  color: Colors.black,
                                ))),
                            title: const Text("About",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            onTap: () => {
                              Get.to(ViewerScreen(
                                  myUrl:
                                      'https://dev2.login2.in/silverLine/home/aboutUs',
                                  type: 'file',
                                  title: 'About Us',
                                  share: false))
                            },
                          ),
                          Container(
                              width: 250,
                              height: 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffd9d9d9))),
                          const SizedBox(
                            height: 25,
                          ),
                          ListTile(
                            leading: SizedBox(
                                width: 25,
                                child: Center(
                                    child: Icon(
                                  Icons.logout,
                                  color: Colors.grey.shade700,
                                  size: 35,
                                ))),
                            title: const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text("Logout",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text(
                                        'Are you sure want to logout?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('No'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorConstant
                                              .logoblue, // Set the background color here
                                        ),
                                        onPressed: () async {
                                          showLogOut();
                                        },
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: ColorConstant.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLogOut() {
    CommonFunction.addDataToSharedPreferences('logout', 'success');
    Get.offAll(LoginSignupSelectionScreen());
    Get.delete<DashboardController>();
  }
}
