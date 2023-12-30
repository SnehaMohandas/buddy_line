import 'dart:io';

import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/screens/gallery_screen/gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../consts/image_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value == true) {
        final WorkshopGalleryController controller =
            Get.put(WorkshopGalleryController());
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Workshop Images',
              style: TextingStyle.font16BoldBlack,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Obx(
                            () => AlertDialog(
                              scrollable: true,
                              title: controller.workshopImage.value == ''
                                  ? const Text('Select Source')
                                  : const Text('Selected Image'),
                              content: controller.workshopImage.value == ''
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            controller.pickedImage(
                                                context, ImageSource.camera);
                                          },
                                          child: const Text("Camera"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.pickedImage(
                                                context, ImageSource.gallery);
                                          },
                                          child: const Text("Gallery"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                File(controller
                                                    .workshopImage.value),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                                controller.workshopImage.value =
                                                    '';
                                              },
                                              child: const Text('close'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.uploadImage();
                                              },
                                              child: const Text('Upload'),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          );
                        });
                  },
                  child: Text('Add Image'),
                ),
              ),
            ],
          ),
          body: controller.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      controller.getGalleryModel!.data.isEmpty
                          ? Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AssetImages.noDataFound),
                                ),
                              ),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'No Transactions found',
                                      style: TextingStyle.font16BoldBlack,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  controller.getGalleryModel!.data.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 8,
                                          bottom: 8),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.greyType,
                                          image: DecorationImage(
                                            image: NetworkImage(controller
                                                .getGalleryModel!
                                                .data[index]
                                                .shopImage),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 35,
                                      top: 20,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: const Text(
                                                      'Are you sure want to Delete?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: const Text('No'),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorConstant
                                                                .logoblue, // Set the background color here
                                                      ),
                                                      onPressed: () async {
                                                        controller
                                                            .DeleteGalleryImage(
                                                                controller
                                                                    .getGalleryModel!
                                                                    .data[index]
                                                                    .id);
                                                      },
                                                      child: const Text(
                                                        'Yes',
                                                        style: TextStyle(
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
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Icon(
                                              Icons.delete,
                                              color: ColorConstant.redcolor,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                );
                              },
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
}
