import 'dart:io';
import 'package:buddy_line/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../consts/color_constants.dart';
import '../consts/image_constants.dart';
import 'custom_button.dart';

// final AdsDetailController adsDetailController = Get.find<AdsDetailController>();

Future UploadPopUp(context, controller) {
  return showDialog(
    barrierColor: Colors.white.withOpacity(.2),
    context: context,
    builder: (BuildContext context) {
      return Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                color: ColorConstant.logoblue,
              ),
              width: 295,
              height: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.66,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 0.5,
                                color: ColorConstant.bordercolor,
                              ),
                            ),
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Container(
                                    height: 80,
                                    width: 80,
                                    decoration: controller.imagePath.value == ''
                                        ? BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    AssetImages.upload)),
                                          )
                                        : BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(
                                                File(
                                                    controller.imagePath.value),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text('Select Source'),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  controller.pickedImage(
                                                      context,
                                                      ImageSource.camera);
                                                },
                                                child: const Text("Camera"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  controller.pickedImage(
                                                      context,
                                                      ImageSource.gallery);
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
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: CustomButton(
                                      'Choose Image',
                                      160,
                                      42,
                                      ColorConstant.black,
                                      ColorConstant.white,
                                      16),
                                )
                              ],
                            )),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 25,
                                color: ColorConstant.logoblue,
                              ),
                            ),
                          ),
                        ),
                        // Add additional widgets inside the stack if needed
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.uploadbilldata();
                          },
                          child: controller.uploading.value == true
                              ? const Text(
                                  'Uploading..',
                                  style: TextingStyle.font14BoldWhite,
                                )
                              : CustomButton(
                                  'Upload',
                                  MediaQuery.of(context).size.width * 0.65,
                                  45,
                                  ColorConstant.black,
                                  ColorConstant.white,
                                  18),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
