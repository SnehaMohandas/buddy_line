import 'package:buddy_line/consts/image_constants.dart';
import 'package:buddy_line/screens/viewer_screen/viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../consts/color_constants.dart';
import '../consts/text_styles.dart';

Widget TransactionWidget(context, controller, billListController) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.75,
    decoration: BoxDecoration(
        color: ColorConstant.greyType, borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 37,
                width: 37,
                decoration: BoxDecoration(
                  color: ColorConstant.white,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(AssetImages.splashImg),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.reqDate,
                    style: TextingStyle.font14BoldBlack,
                  ),
                  Text(controller.status,
                      style: controller.reqStatus == "approved"
                          ? TextingStyle.font12NormalGreen
                          : controller.reqStatus == "pending"
                              ? TextingStyle.font12NormalOrange
                              : TextingStyle.font12NormalRed)
                ],
              ),
            ],
          ),
          Row(
            children: [
              controller.reqStatus == "pending"
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  const Text('Are you sure want to Delete?'),
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
                                    billListController
                                        .deleteRequestById(controller.reqId);
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
                      icon: const Icon(Icons.delete),
                      color: ColorConstant.redcolor,
                    )
                  : const SizedBox(),
              controller.reqStatus == "approved"
                  ? Text('+₹ ${controller.schemeAmount}',
                      style: TextingStyle.font18BoldGreen)
                  : controller.reqStatus == "pending" ||
                          controller.reqStatus == "rejected"
                      ? GestureDetector(
                          onTap: () {
                            Get.to(ViewerScreen(
                                myUrl: controller.uploadedImg,
                                type: 'image',
                                title: 'Upload Bill',
                                share: false));
                          },
                          child: const Icon(
                            Icons.image,
                            color: ColorConstant.logoblue,
                          ))
                      : const Icon(Icons.remove_red_eye)
            ],
          )
        ],
      ),
    ),
  );
}
