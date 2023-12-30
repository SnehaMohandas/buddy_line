import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordVerificationOtpController extends GetxController{

  final otpController = List.generate(4, (index) => TextEditingController());

  var otpNumber = ''.obs;
}