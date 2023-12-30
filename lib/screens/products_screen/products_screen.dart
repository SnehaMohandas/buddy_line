import 'package:buddy_line/screens/dashboard_screen/dashboard_controller.dart';
import 'package:buddy_line/screens/product_details_screen/product_details_screen.dart';
import 'package:buddy_line/screens/products_screen/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../consts/color_constants.dart';
import '../../consts/image_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/custom_button.dart';
import '../bottom_navigation_screen/bottom_Navigation_Controller.dart';
import '../product_details_screen/product_detail_controller.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final ProductController productController =
            Get.put(ProductController());
        final ProductDetailController productDetailController =
            Get.find<ProductDetailController>();
        final DashboardController dashboardController =
            Get.find<DashboardController>();
        final BottomNavigationController bottomNavigationController =
            Get.find<BottomNavigationController>();
        return WillPopScope(
          //canPop: false,
          onWillPop: () async {
            bottomNavigationController.changeTabIndex(0);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
            ),
            body: productController.isLoading.value == true
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            // Change this line
                            itemCount:
                                productController.allProductsModel!.data.length,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .79,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  productDetailController.GetprodctDetailById(
                                      productController.allProductsModel!
                                          .data[index].productId);
                                  Get.to(ProductDetailScreen());
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
                                              0.13,
                                          placeholder: (context, url) => Center(
                                            child: Lottie.asset(
                                                AssetImages.loader),
                                          ),
                                          imageUrl: productController
                                              .allProductsModel!
                                              .data[index]
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
                                                productController
                                                    .allProductsModel!
                                                    .data[index]
                                                    .productName,
                                                style: TextingStyle
                                                    .font11BoldSlate,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '₹${productController.allProductsModel!.data[index].regularPrice}/Sqft',
                                                    style: TextingStyle
                                                        .font11NormalLogoBlue,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  // Text(
                                                  //   '₹110/sqft',
                                                  //   style: TextStyle(
                                                  //     fontSize: 10,
                                                  //     decoration:
                                                  //         TextDecoration.lineThrough,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              // const Row(
                                              //   mainAxisAlignment: MainAxisAlignment.start,
                                              //   children: [
                                              //     Text(
                                              //       'Expiry date :',
                                              //       style: TextingStyle.font11NormalBlack,
                                              //     ),
                                              //     SizedBox(
                                              //       width: 10,
                                              //     ),
                                              //     Text(productController.allProductsModel!.data[index].,
                                              //         style: TextingStyle.font11NormalRed),
                                              //   ],
                                              // ),
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
                                                                  dashboardController.Bookingnow(productController
                                                                      .allProductsModel!
                                                                      .data[
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
                                                        ColorConstant.logoblue,
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
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }
}
