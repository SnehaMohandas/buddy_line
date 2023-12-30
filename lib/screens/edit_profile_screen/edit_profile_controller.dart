import 'dart:math';
import 'package:buddy_line/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:buddy_line/screens/edit_profile_screen/update_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import '../../services/services.dart';
import '../sign_up_screen/dealer_model.dart';
import '../sign_up_screen/get_areas_model.dart';
import '../sign_up_screen/get_district_model.dart';
import '../sign_up_screen/register_otp_model.dart';
import 'get_profile_model.dart';

//
class EditProfileController extends GetxController {
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
  UpdateProfileModel? updateProfileModel;
  var otp = ''.obs;
  GetDistrictModel? getDistrictModel;
  RegisterOtpModel? registerOtpModel;
  GetAreasModel? getAreasModel;
  RxBool isVerified = false.obs;
  RxString selectArea = ''.obs;
  var domDate = ''.obs;
  var dobDate = ''.obs;
  DealerModel? dealerModel;
  EditProfileModel? editProfileModel;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController address1TextController = TextEditingController();
  TextEditingController address2TextController = TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController whatsappTextController = TextEditingController();
  TextEditingController panCardTextController = TextEditingController();
  TextEditingController aadhaarTextController = TextEditingController();
  TextEditingController dobTextController = TextEditingController();
  TextEditingController domTextController = TextEditingController();
  TextEditingController workShopTextController = TextEditingController();
  TextEditingController accountNumberTextController = TextEditingController();
  TextEditingController iFSETextController = TextEditingController();
  TextEditingController bankNameTextController = TextEditingController();
  TextEditingController gpayNumberTextController = TextEditingController();
  TextEditingController upiIdTextController = TextEditingController();

  toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  pickedImage(context, source) async {
    final image1 =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    try {
      if (image1 != null) {
        userImage.value = image1.path;
        isLoading.value = true;
        isLoading.value = false;
      }
    } on PlatformException catch (e) {
      Get.snackbar('Permission Denied',
          'Please grant access to the gallery to pick an image.');
    }
  }

  // selectMultiImage(
  //   ImageSource? source,
  // ) async {
  //   if (source != null) {
  //     final XFile? selectedImages =
  //         await ImagePicker().pickImage(source: source);
  //     if (selectedImages != null) {
  //       list.add(selectedImages);
  //       isLoading.value = true;
  //       isLoading.value = false;
  //     }
  //     return list;
  //   } else {
  //     final List<XFile> images = await ImagePicker().pickMultiImage();
  //     if (images.isNotEmpty) {
  //       list.addAll(images);
  //       isLoading.value = true;
  //       isLoading.value = false;
  //     }
  //     return list;
  //   }
  // }

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

  getProfileData() async {
    var data = await HttpServices.getProfile(token);
    if (data != null) {
      editProfileModel = data;
      nameTextController.text = editProfileModel!.data.name;
      pinCodeTextController.text = editProfileModel!.data.pinCode;
      address1TextController.text = editProfileModel!.data.address1;
      address2TextController.text = editProfileModel!.data.address2;
      selectDistrict.value = editProfileModel!.data.districtId;
      aadhaarTextController.text = editProfileModel!.data.adharcardNo;
      panCardTextController.text = editProfileModel!.data.pancardNo;
      workShopTextController.text = editProfileModel!.data.workshopAddress;
      accountNumberTextController.text = editProfileModel!.data.accountNo;
      bankNameTextController.text = editProfileModel!.data.bankName;
      iFSETextController.text = editProfileModel!.data.ifsc;
      upiIdTextController.text = editProfileModel!.data.upiId;
      if (editProfileModel!.data.dateOfBirth == '') {
        dobDate.value = editProfileModel!.data.dateOfBirth;
      } else {
        dobDate.value = editProfileModel!.data.dateOfBirth;
        // dobDate.value = DateFormat('dd-MM-yyyy').format(editProfileModel!.data.dateOfBirth);
      }
      if (editProfileModel!.data.dateOfMarriage == '') {
        domDate.value = editProfileModel!.data.dateOfMarriage;
      } else {
        domDate.value = editProfileModel!.data.dateOfMarriage;
        // domDate.value = DateFormat('dd-MM-yyyy')
        //     .format(editProfileModel!.data.dateOfMarriage);
      }
      latitude.value = editProfileModel!.data.latitude;
      longitude.value = editProfileModel!.data.longitude;
      selectDealer.value = editProfileModel!.data.preferredDealer;
      print('new dealer comes ${editProfileModel!.data.preferredDealer}');
      print('new dealer ${selectDealer.value}');
      isLoading.value = false;
    }
  }

  updateProfileData(address1, address2, adharNo, pincode, pancard, workshop,
      accountNo, bankName, Ifsc, upiId) async {
    var data = await HttpServices.updateProfile(
        token,
        name,
        address1,
        address2,
        selectDistrict.value,
        adharNo,
        userImage.value,
        pincode,
        pancard,
        dobDate.value,
        domDate.value,
        workshop,
        latitude.value,
        longitude.value,
        accountNo,
        bankName,
        Ifsc,
        upiId,
        selectDealer.value);
    if (data != null) {
      updateProfileModel = data;
      if (updateProfileModel!.status == true) {
        Fluttertoast.showToast(
          msg: updateProfileModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.offAll(BottomNavigationScreen());
      } else {
        Fluttertoast.showToast(
          msg: updateProfileModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  //
  // signup(
  //     name,
  //     address1,
  //     address2,
  //     whatsappNo,
  //     pancardNo,
  //     adharNo,
  //     workshopAdreess,
  //     bankName,
  //     ifscCode,
  //     accountNo,
  //     transfer,
  //     userName,
  //     password) async {
  //   print(selectArea.value);
  //   whatsappNum.value = whatsappNo;
  //   var data = await HttpServices.signingUp(
  //       name,
  //       address1,
  //       address2,
  //       selectArea.value,
  //       selectDistrict.value,
  //       whatsappNo,
  //       pancardNo,
  //       adharNo,
  //       dobDate.value,
  //       domDate.value,
  //       workshopAdreess,
  //       latitude.value,
  //       bankName,
  //       ifscCode,
  //       accountNo,
  //       transfer,
  //       userName,
  //       password,
  //       userImage.value,
  //       list,
  //       longitude.value,
  //       selectDealer.value);
  //   if (data != null) {
  //     signupModel = data;
  //     print(signupModel!.status.toString());
  //     print(signupModel!.message);
  //     if (signupModel!.status == true) {
  //       Fluttertoast.showToast(
  //         msg: signupModel!.message,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: ColorConstant.black,
  //         textColor: ColorConstant.white,
  //       );
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: signupModel!.message,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: ColorConstant.black,
  //         textColor: ColorConstant.white,
  //       );
  //     }
  //   }
  // }

  getdistrictData() async {
    isLoading.value = true;
    var data = await HttpServices.getDistrictList();
    if (data != null) {
      getDistrictModel = data;
      getareas();
    }
  }

  getareas() async {
    var data = await HttpServices.getAreas();
    if (data != null) {
      getAreasModel = data;
      getDealer();
    }
  }

  getDealer() async {
    var data = await HttpServices.getDealer();
    if (data != null) {
      getProfileData();
      dealerModel = data;
    }
  }

  @override
  void onInit() {
    getdistrictData();
    super.onInit();
  }
}
