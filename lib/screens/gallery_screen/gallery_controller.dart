import 'package:buddy_line/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import 'add_image_model.dart';
import 'delete_gallery_image_model.dart';
import 'get_gallery_model.dart';

class WorkshopGalleryController extends GetxController {
  DeleteImageGalleryModel? deleteImageGalleryModel;
  GetGalleryModel? getGalleryModel;
  RxBool isLoading = true.obs;
  var workshopImage = ''.obs;
  AddImageModel? addImageModel;

  pickedImage(context, source) async {
    final image1 =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    try {
      if (image1 != null) {
        workshopImage.value = image1.path;
      }
    } on PlatformException catch (e) {
      Get.snackbar('Permission Denied',
          'Please grant access to the gallery to pick an image.');
    }
  }

  GetImages() async {
    isLoading.value = true;
    var data = await HttpServices.getShopImages(token);
    if (data != null) {
      getGalleryModel = data;
      isLoading.value = false;
    }
  }

  DeleteGalleryImage(imageId) async {
    var data = await HttpServices.DeleteImageById(token, imageId);
    if (data != null) {
      deleteImageGalleryModel = data;
      if (deleteImageGalleryModel!.status == true) {
        GetImages();
        Fluttertoast.showToast(
          msg: deleteImageGalleryModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: deleteImageGalleryModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  uploadImage() async {
    var data = await HttpServices.addImageToGallery(token, workshopImage.value);
    if (data != null) {
      addImageModel = data;
      if (addImageModel!.status == true) {
        GetImages();
        Fluttertoast.showToast(
          msg: addImageModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        workshopImage.value = '';
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: addImageModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        workshopImage.value = '';
        Get.back();
      }
    }
  }

  @override
  void onInit() {
    GetImages();
    super.onInit();
  }
}
