import 'dart:math';
import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/screens/sign_up_screen/register_otp_model.dart';
import 'package:buddy_line/screens/sign_up_screen/signup_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../otp_verification_screen/otp_verification_screen.dart';
import '../registration_success_screen/registration_success_screen.dart';
import 'get_district_model.dart';

class SignupController extends GetxController {
  var obscureText = true.obs;
  RxBool resendValue = false.obs;
  var userImage = ''.obs;
  RxList list = [].obs;
  RxBool isLoading = false.obs;
  var longitude = ''.obs;
  var selectDistrict = ''.obs;
  var selectDealer = ''.obs;
  var latitude = ''.obs;
  RxString whatsappNum = ''.obs;
  var otp = ''.obs;
  GetDistrictModel? getDistrictModel;
  RegisterOtpModel? registerOtpModel;
  SignupModel? signupModel;

  // GetAreasModel? getAreasModel;
  RxBool isVerified = false.obs;
  RxString selectArea = ''.obs;
  var domDate = ''.obs;
  var dobDate = ''.obs;

  // DealerModel? dealerModel;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController address1TextController = TextEditingController();
  TextEditingController address2TextController = TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController whatsappTextController = TextEditingController();
  TextEditingController aadhaarTextController = TextEditingController();

  toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  pickedImage(context, source) async {
    final image1 =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    try {
      if (image1 != null) {
        userImage.value = image1.path;
      }
    } on PlatformException catch (e) {
      Get.snackbar('Permission Denied',
          'Please grant access to the gallery to pick an image.');
    }
  }

  selectMultiImage(
    ImageSource? source,
  ) async {
    if (source != null) {
      final XFile? selectedImages =
          await ImagePicker().pickImage(source: source);
      if (selectedImages != null) {
        list.add(selectedImages);
        isLoading.value = true;
        isLoading.value = false;
      }
      return list;
    } else {
      final List<XFile> images = await ImagePicker().pickMultiImage();
      if (images.isNotEmpty) {
        list.addAll(images);
        isLoading.value = true;
        isLoading.value = false;
      }
      return list;
    }
  }

  getCurrentLocation() async {
    isLoading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {}
    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitudes = position.latitude;
    double longitudes = position.longitude;

    latitude.value = latitudes.toString();
    longitude.value = longitudes.toString();
    isLoading.value = false;
  }

  signup(
      name, address1, address2, whatsappNo, adharNo, password, pincode) async {
    print(selectArea.value);
    whatsappNum.value = whatsappNo;
    var data = await HttpServices.signingUp(
      name,
      address1,
      address2,
      selectDistrict.value,
      whatsappNo,
      adharNo,
      password,
      userImage.value,
      list,
      pincode,
    );
    if (data != null) {
      signupModel = data;
      print(signupModel!.status.toString());
      print(signupModel!.message);
      if (signupModel!.status == true) {
        Fluttertoast.showToast(
          msg: signupModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.to(
            duration: const Duration(microseconds: 900),
            transition: Transition.leftToRight,
            RegistrationSuccessScreen());
      } else {
        Fluttertoast.showToast(
          msg: signupModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  sendOtp() async {
    otp.value = await generateRandomNumbers(1);
    print(otp);
    var data = await HttpServices.registeringOTP(
        whatsappTextController.text, otp.value);
    if (data != null) {
      registerOtpModel = data;
      if (registerOtpModel!.status == true) {
        Fluttertoast.showToast(
          msg: registerOtpModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.to(
            duration: const Duration(microseconds: 900),
            transition: Transition.leftToRight,
            OtpVerificationScreen());
      } else {
        Fluttertoast.showToast(
          msg: registerOtpModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  generateRandomNumbers(int count) {
    Random random = Random();
    int randomNumber;
    var otp = '';

    for (int i = 0; i < count; i++) {
      randomNumber = random.nextInt(9000) + 1000;
      // print('otp : $randomNumber');
      otp = randomNumber.toString();
    }
    return otp;
  }

  getdistrictData() async {
    isLoading.value = true;
    var data = await HttpServices.getDistrictList();
    if (data != null) {
      getDistrictModel = data;
      isLoading.value = false;
    }
  }

  // getareas() async {
  //   var data = await HttpServices.getAreas();
  //   if (data != null) {
  //     getAreasModel = data;
  //     getDealer();
  //   }
  // }

  // getDealer() async {
  //   var data = await HttpServices.getDealer();
  //   if (data != null) {
  //     dealerModel = data;
  //     isLoading.value = false;
  //   }
  // }

  @override
  void onInit() {
    getdistrictData();
    super.onInit();
  }
}
