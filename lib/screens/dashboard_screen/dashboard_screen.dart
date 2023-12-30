import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/screens/bottom_navigation_screen/bottom_Navigation_Controller.dart';
import 'package:buddy_line/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:buddy_line/screens/dashboard_screen/dashboard_controller.dart';
import 'package:buddy_line/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:buddy_line/screens/login_or_signup_selection_screen/login_signup_selection_screen.dart';
import 'package:buddy_line/screens/product_details_screen/product_details_screen.dart';
import 'package:buddy_line/screens/products_screen/products_screen.dart';
import 'package:buddy_line/screens/roofing_calculator_screen/roofing_calculator_screen.dart';
import 'package:buddy_line/screens/wallet_screen/wallet_screen.dart';
import 'package:buddy_line/widgets/custom_button.dart';
import 'package:buddy_line/widgets/upload_screenshot_popup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../consts/image_constants.dart';
import '../../consts/text_styles.dart';
import '../../consts/user_data.dart';
import '../../shared_preference/shared_preference.dart';
import '../drawer_screen/drawer_screen.dart';
import '../product_details_screen/product_detail_controller.dart';
import '../uploaded_bill_screen/uploaded_bill_screen.dart';
import '../wallet_screen/wallet_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController dashboardController =
      Get.put(DashboardController());
  final ProductDetailController productDetailController =
      Get.put(ProductDetailController());
  final BottomNavigationController bottomNavigationController =
      Get.find<BottomNavigationController>();
  final WalletController walletController = Get.put(WalletController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('Are you sure to exit BuddyLine?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant
                            .logoblue, // Set the background color here
                      ),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: ColorConstant.white,
                        ),
                      ))
                ],
              );
            },
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetImages.splashImg),
                    ),
                  ),
                ),
                const Text(
                  'Buddy Line',
                  style: TextingStyle.font18BoldLogoBlue,
                )
              ],
            ),
          ),
          key: _scaffoldKey,
          endDrawer: DrawerScreen(),
          body: dashboardController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: dashboardController.onRefresh,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.58,
                                height: 90,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Container(
                                      //   height: 70,
                                      //   width: 70,
                                      //   decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.white),
                                      //     borderRadius: BorderRadius.circular(50),
                                      //     image: const DecorationImage(
                                      //       fit: BoxFit.cover,
                                      //       image: NetworkImage(
                                      //         'https://i.pinimg.com/736x/1c/42/db/1c42dbe4cfb44025ac69d041568cf2c5.jpg',
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.46,
                                            child: Text(
                                              name!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextingStyle
                                                  .font16BoldLogoBlue,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.52,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  dashboardController
                                                      .dateToday.value,
                                                  style: TextingStyle
                                                      .font14NormalBlack,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  bottomNavigationController.changeTabIndex(3);
                                  walletController.getPayoutRequestList();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      color: ColorConstant.walletContainer),
                                  child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      AssetImages.wallet),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('My Wallet'),
                                              Text(
                                                "₹ ${dashboardController.dashboardModel!.data.walletAmount}",
                                                style: TextingStyle
                                                    .font20boldlogoblue,
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 5),
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: GridView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, crossAxisSpacing: 3),
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(UploadedBillListScreen());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image:
                                              AssetImage(AssetImages.gridImg1),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Uploaded\nBills',
                                          style: TextingStyle.font16BoldWhite,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      bottomNavigationController
                                          .changeTabIndex(2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image:
                                              AssetImage(AssetImages.gridImg1),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Products',
                                          style: TextingStyle.font16BoldWhite,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      bottomNavigationController
                                          .changeTabIndex(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image:
                                              AssetImage(AssetImages.gridImg1),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Roof\nCalculator',
                                          style: TextingStyle.font16BoldWhite,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 12, top: 5, bottom: 5),
                            child: Text(
                              'Special Offers',
                              style: TextingStyle.font20NormalSlate,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  aspectRatio: 18 / 5,
                                  viewportFraction: 1.0,
                                  height:
                                      MediaQuery.of(context).size.height * 0.39,
                                  autoPlay: true),
                              items: dashboardController.spclOffer.map((e) {
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.39,
                                    decoration: const BoxDecoration(
                                      color: ColorConstant.adContainer,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.26,
                                          placeholder: (context, url) => Center(
                                            child: Lottie.asset(
                                                AssetImages.loader),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                            child: Icon(
                                              Icons.error,
                                              size: 48,
                                              color: ColorConstant.redcolor,
                                            ),
                                          ),
                                          imageUrl: e.image.toString(),
                                        ),
                                        // Container(
                                        //   height: MediaQuery.of(context).size.height * 0.26,
                                        //   width: double.infinity,
                                        //   decoration: BoxDecoration(
                                        //       image: DecorationImage(
                                        //           image: NetworkImage(e.toString()),
                                        //           fit: BoxFit.fitWidth)),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.productName,
                                                    style: TextingStyle
                                                        .font14BoldSlate,
                                                  ),
                                                  Obx(() {
                                                    return e.isSchemeBenefit ==
                                                            true
                                                        ? SizedBox(
                                                            height: 25,
                                                            child: Visibility(
                                                              visible:
                                                                  dashboardController
                                                                      .isVisible
                                                                      .value,
                                                              child: Text(
                                                                'Benefit ' +
                                                                    e.schemeBenefit,
                                                                style: TextingStyle
                                                                    .font16BoldRed,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox();
                                                  }),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '₹${e.offerPrice}/Sqft',
                                                        style: TextingStyle
                                                            .font14NormalLogoBlue,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '₹${e.regularPrice}/Sqft',
                                                        style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        'Expiry date :',
                                                        style: TextingStyle
                                                            .font14NormalBlack,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(e.expiryDate,
                                                          style: TextingStyle
                                                              .font14NormalRed),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: const Text(
                                                                'Are you sure Book this product?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'No'),
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      ColorConstant
                                                                          .logoblue, // Set the background color here
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  dashboardController
                                                                      .Bookingnow(
                                                                          e.productId);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Yes',
                                                                  style:
                                                                      TextStyle(
                                                                    color: ColorConstant
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: CustomButton(
                                                        'Book Now',
                                                        100,
                                                        30,
                                                        ColorConstant.white,
                                                        ColorConstant.logoblue,
                                                        14),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      productDetailController
                                                          .GetprodctDetailById(
                                                              e.productId);
                                                      Get.to(
                                                          transition: Transition
                                                              .leftToRight,
                                                          ProductDetailScreen());
                                                    },
                                                    child: CustomButton(
                                                        'View More',
                                                        100,
                                                        30,
                                                        ColorConstant.white,
                                                        ColorConstant.black,
                                                        14),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }).toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 12, bottom: 5),
                            child: Text(
                              'Offers',
                              style: TextingStyle.font20NormalSlate,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              // Change this line
                              itemCount: dashboardController
                                  .dashboardModel!.data.offers.length,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .70,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    productDetailController.GetprodctDetailById(
                                        dashboardController.dashboardModel!.data
                                            .offers[index].productId);
                                    Get.to(
                                        duration:
                                            const Duration(microseconds: 900),
                                        transition: Transition.leftToRight,
                                        ProductDetailScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: ColorConstant.adContainer),
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.14,
                                            placeholder: (context, url) =>
                                                Center(
                                                    child: Lottie.asset(
                                                        AssetImages.loader)),
                                            imageUrl: dashboardController
                                                .dashboardModel!
                                                .data
                                                .offers[index]
                                                .image,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                bottom: 8,
                                                top: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dashboardController
                                                      .dashboardModel!
                                                      .data
                                                      .offers[index]
                                                      .productName,
                                                  style: TextingStyle
                                                      .font11BoldSlate,
                                                ),
                                                Obx(() {
                                                  return dashboardController
                                                              .dashboardModel!
                                                              .data
                                                              .offers[index]
                                                              .isSchemeBenefit ==
                                                          true
                                                      ? SizedBox(
                                                          height: 20,
                                                          child: Visibility(
                                                              visible:
                                                                  dashboardController
                                                                      .isVisible
                                                                      .value,
                                                              child: Text(
                                                                'Benefit ${dashboardController.dashboardModel!.data.offers[index].schemeBenefit}',
                                                                style: TextingStyle
                                                                    .font12NormalRed,
                                                              )),
                                                        )
                                                      : const SizedBox();
                                                }),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '₹${dashboardController.dashboardModel!.data.offers[index].offerPrice}/Sqft',
                                                      style: TextingStyle
                                                          .font11NormalLogoBlue,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '₹${dashboardController.dashboardModel!.data.offers[index].regularPrice}/Sqft',
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Expiry date :',
                                                      style: TextingStyle
                                                          .font11NormalBlack,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        dashboardController
                                                            .dashboardModel!
                                                            .data
                                                            .offers[index]
                                                            .expiryDate,
                                                        style: TextingStyle
                                                            .font11NormalRed),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              content: const Text(
                                                                  'Are you sure Book this product?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'No'),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        ColorConstant
                                                                            .logoblue, // Set the background color here
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    dashboardController.Bookingnow(dashboardController
                                                                        .dashboardModel!
                                                                        .data
                                                                        .offers[
                                                                            index]
                                                                        .productId);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Yes',
                                                                    style:
                                                                        TextStyle(
                                                                      color: ColorConstant
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: CustomButton(
                                                          'Book Now',
                                                          70,
                                                          25,
                                                          ColorConstant.white,
                                                          ColorConstant
                                                              .logoblue,
                                                          11),
                                                    ),
                                                    CustomButton(
                                                        'View More',
                                                        70,
                                                        25,
                                                        ColorConstant.white,
                                                        ColorConstant.black,
                                                        11),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: ColorConstant.logoblue,
            icon: const Icon(
              Icons.add_circle,
              color: ColorConstant.white,
            ),
            label: const Text(
              'Upload\nBill',
              textAlign: TextAlign.center,
              style: TextingStyle.font14NormalWhite,
            ),
            onPressed: () async {
              dashboardController.imagePath.value = '';
              UploadPopUp(context, dashboardController);
            },
          ),
        ),
      );
    });
  }

  showLogOut() {
    CommonFunction.addDataToSharedPreferences('logout', 'success');
    Get.offAll(LoginSignupSelectionScreen());
    Get.delete<DashboardController>();
  }
}
