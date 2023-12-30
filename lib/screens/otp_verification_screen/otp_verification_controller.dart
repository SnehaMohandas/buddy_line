import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../sign_up_screen/register_otp_model.dart';

class OtpVerificationController extends GetxController {

  final otpController = List.generate(4, (index) => TextEditingController());

  var otpNumber = ''.obs;
  var whatsapp = ''.obs;
  RegisterOtpModel? registerOtpModel;




}