import 'dart:io';
import 'dart:ui';

import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/consts/text_styles.dart';
import 'package:buddy_line/screens/dashboard_screen/dashboard_controller.dart';
import 'package:buddy_line/screens/product_details_screen/product_detail_controller.dart';
import 'package:buddy_line/screens/viewer_screen/viewer_screen.dart';
import 'package:buddy_line/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consts/image_constants.dart';
import '../../controller/network_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final ProductDetailController productDetailController =
            Get.find<ProductDetailController>();
        final DashboardController dashboardController =
            Get.find<DashboardController>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Details'),
          ),
          body: productDetailController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 8, bottom: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              print('hai');
                              _fileFromImageUrl(
                                  productDetailController.indexImage.value);
                              // shareImageOnWhatsApp();
                            },
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 300,
                                  placeholder: (context, url) => Center(
                                    child: Lottie.asset(AssetImages.loader),
                                  ),
                                  imageUrl:
                                      productDetailController.indexImage.value,
                                ),
                                Positioned(
                                  right: 7,
                                  top: 7,
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: ColorConstant.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0,
                                            sigmaY:
                                                10.0), // Adjust blur intensity
                                        child: Container(
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.29,
                                          color: Colors.white.withOpacity(
                                              0.0), // Background color with opacity
                                          child: const Center(
                                            child: Icon(Icons.share),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 80,
                          child: ListView.builder(
                            itemCount: productDetailController
                                .productsDetailByIdModel!.data.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // print('ontap $index');
                                  // print(
                                  //     productDetailController.indexImage.value);
                                  productDetailController.indexImage.value =
                                      productDetailController
                                          .productsDetailByIdModel!
                                          .data
                                          .images[index]
                                          .imgPath;
                                  productDetailController.isimageChange.value =
                                      false;
                                  // productDetailController.isLoading.value =
                                  // false;
                                  productDetailController.isimageChange.value =
                                      true;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: productDetailController
                                                    .indexImage.value ==
                                                productDetailController
                                                    .productsDetailByIdModel!
                                                    .data
                                                    .images[index]
                                                    .imgPath
                                            ? Border.all(
                                                width: 3.0,
                                                color: ColorConstant.logoblue,
                                              )
                                            : Border.all(
                                                color: ColorConstant.white),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 77,
                                        height: 56,
                                        placeholder: (context, url) => Center(
                                          child:
                                              Lottie.asset(AssetImages.loader),
                                        ),
                                        imageUrl: productDetailController
                                            .productsDetailByIdModel!
                                            .data
                                            .images[index]
                                            .imgPath,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  productDetailController
                                      .productsDetailByIdModel!
                                      .data
                                      .productName,
                                  style: TextingStyle.font20BoldSlate),
                              const SizedBox(
                                height: 5,
                              ),
                              productDetailController.productsDetailByIdModel!
                                          .data.isScheme ==
                                      true
                                  ? SizedBox(
                                      height: 20,
                                      child: Visibility(
                                          visible: productDetailController
                                              .isVisible.value,
                                          child: Text(
                                            'Benefit ${productDetailController.productsDetailByIdModel!.data.schemeAmount}',
                                            style:
                                                TextingStyle.font16BoldFontREd,
                                          )),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        productDetailController
                                                    .productsDetailByIdModel!
                                                    .data
                                                    .isOffer ==
                                                true
                                            ? Text(
                                                '₹ ${productDetailController.productsDetailByIdModel!.data.regularPrice}/Sqft',
                                                style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorConstant.black,
                                                ),
                                              )
                                            : Text(
                                                '₹ ${productDetailController.productsDetailByIdModel!.data.regularPrice}/Sqft',
                                                style: TextingStyle
                                                    .font16NormalBlack,
                                              ),
                                      ],
                                    ),
                                    productDetailController
                                                .productsDetailByIdModel!
                                                .data
                                                .isOffer ==
                                            true
                                        ? Row(
                                            children: [
                                              const Text(
                                                'Offer  ',
                                                style: TextingStyle
                                                    .font16BoldFontREd,
                                              ),
                                              Text(
                                                  '₹${productDetailController.productsDetailByIdModel!.data.offerPrice}/Sqft',
                                                  style: TextingStyle
                                                      .font16BoldBlack)
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text('Dimensions : '),
                                  Text(productDetailController
                                      .productsDetailByIdModel!.data.dimension),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                productDetailController
                                    .productsDetailByIdModel!.data.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  productDetailController
                                              .productsDetailByIdModel!
                                              .data
                                              .isBrochure ==
                                          true
                                      ? GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              ViewerScreen(
                                                myUrl: productDetailController
                                                    .productsDetailByIdModel!
                                                    .data
                                                    .brochureImg,
                                                type: 'Image',
                                                title: 'Brochure',
                                                share: true,
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.image),
                                                Text('Brochure')
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  productDetailController
                                              .productsDetailByIdModel!
                                              .data
                                              .isPdf ==
                                          true
                                      ? GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              ViewerScreen(
                                                myUrl: productDetailController
                                                    .productsDetailByIdModel!
                                                    .data
                                                    .pdfImg,
                                                type: 'Pdf',
                                                title: 'PDF',
                                                share: true,
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.picture_as_pdf),
                                                Text(' Pdf')
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: GestureDetector(
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
                                              child: const Text('No'),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: ColorConstant
                                                    .logoblue, // Set the background color here
                                              ),
                                              onPressed: () async {
                                                dashboardController.Bookingnow(
                                                    productDetailController
                                                        .productsDetailByIdModel!
                                                        .data
                                                        .productId);
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
                                  child: CustomButton(
                                      'Book Now',
                                      MediaQuery.of(context).size.width * 0.9,
                                      45,
                                      ColorConstant.white,
                                      ColorConstant.logoblue,
                                      20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }

  // Future<void> shareImageOnWhatsApp(String imageUrl) async {
  //   // await File('/yourPath/myItem.png').writeAsBytes(imageUrl);
  // }

  Future _fileFromImageUrl(String imageUrl) async {
    print('hello');
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, 'imagetest.jpg'));
    print('ok');
    file.writeAsBytesSync(response.bodyBytes);
    print('++++++++++++$file');
    await Share.shareFiles(
      [file.path],
    );
  }
}
