import 'dart:io';
import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/screens/sign_up_screen/signup_controller.dart';
import 'package:buddy_line/widgets/bar_logo.dart';
import 'package:buddy_line/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  // TextEditingController areaTextController = TextEditingController();

  // TextEditingController panCardTextController = TextEditingController();

  // TextEditingController dobTextController = TextEditingController();
  // TextEditingController domTextController = TextEditingController();
  // TextEditingController workShopTextController = TextEditingController();
  // TextEditingController accountNumberTextController = TextEditingController();
  // TextEditingController iFSETextController = TextEditingController();
  // TextEditingController bankNameTextController = TextEditingController();
  // TextEditingController gpayNumberTextController = TextEditingController();
  // TextEditingController upiIdTextController = TextEditingController();
  final NetworkController networkController = Get.find<NetworkController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? filename;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final SignupController signupController = Get.put(SignupController());
        return Scaffold(
          body: signupController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: BarLogo(context),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Sign Up',
                            style: TextingStyle.headFont28bold,
                          ),
                          const Text(
                            'Enter your details to register',
                            style: TextingStyle.font16bold,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Must enter Name';
                                } else {
                                  return null;
                                }
                              },
                              textCapitalization: TextCapitalization.sentences,
                              controller: signupController.nameTextController,
                              decoration: const InputDecoration(
                                label: Text('Name*'),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     controller: userNameTextController,
                          //     decoration: const InputDecoration(
                          //       label: Text('username*'),
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     validator: (value) {
                          //       if (value!.isEmpty) {
                          //         return 'Must enter phone number';
                          //       } else if (!RegExp(r'^[0-9]{10}$')
                          //           .hasMatch(value)) {
                          //         return 'Invalid phone number. Please enter 10 digits.';
                          //       } else {
                          //         return null;
                          //       }
                          //     },
                          //     keyboardType: TextInputType.number,
                          //     controller: phoneNumberTextController,
                          //     decoration: const InputDecoration(
                          //       label: Text('Phone number'),
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 18,
                          ),
                          Obx(() {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: TextFormField(
                                obscureText: signupController.obscureText.value,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password cannot be empty';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  } else {
                                    return null;
                                  }
                                },
                                controller:
                                    signupController.passwordTextController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      signupController.toggleVisibility();
                                    },
                                    icon: signupController.obscureText.value ==
                                            true
                                        ? const Icon(
                                            Icons.remove_red_eye_outlined)
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                          ),
                                  ),
                                  label: const Text('Password*'),
                                  contentPadding: const EdgeInsets.all(8),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Address field can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              controller:
                                  signupController.address1TextController,
                              decoration: const InputDecoration(
                                label: Text('Adress 1*'),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller:
                                  signupController.address2TextController,
                              decoration: const InputDecoration(
                                label: Text('Adress 2'),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       signupController.isVerified.value == false
                          //           ? const Text(
                          //               'Area (Choose your nearest area)*',
                          //               style: TextingStyle.font12NormalRed,
                          //             )
                          //           : const Text(''),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   height: 50,
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     border: Border.all(color: ColorConstant.slate),
                          //   ),
                          //   child: Center(
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(4.0),
                          //       child: DropdownButtonHideUnderline(
                          //         child: DropdownButton(
                          //           isExpanded: true,
                          //           value:
                          //               signupController.selectArea.value == ''
                          //                   ? null
                          //                   : signupController.selectArea.value,
                          //           borderRadius: BorderRadius.circular(8),
                          //           autofocus: false,
                          //           items: signupController
                          //               .getAreasModel!.data.area
                          //               .map<DropdownMenuItem<String>>((e) {
                          //             return DropdownMenuItem<String>(
                          //               value: e.id,
                          //               child: SizedBox(
                          //                 width: MediaQuery.of(context)
                          //                         .size
                          //                         .width *
                          //                     .35,
                          //                 child: Text(
                          //                   e.areaName,
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //               ),
                          //             );
                          //           }).toList(),
                          //           onChanged: (res) {
                          //             signupController.selectArea.value =
                          //                 res.toString();
                          //           },
                          //           hint: const Text(
                          //             'Select Area',
                          //             textAlign: TextAlign.left,
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'District',
                                  style: TextingStyle.font12BoldBlack,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: ColorConstant.slate),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: signupController
                                                .selectDistrict.value ==
                                            ''
                                        ? null
                                        : signupController.selectDistrict.value,
                                    borderRadius: BorderRadius.circular(8),
                                    autofocus: false,
                                    items: signupController
                                        .getDistrictModel!.data
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.districtId,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .35,
                                          child: Text(
                                            e.districtName,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (res) {
                                      signupController.selectDistrict.value =
                                          res.toString();
                                      signupController.isVerified.value = true;
                                    },
                                    hint: const Text(
                                      'Select District',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller:
                                  signupController.pinCodeTextController,
                              decoration: const InputDecoration(
                                label: Text('Pincode'),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Must enter WhatsApp number';
                                } else if (!RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value)) {
                                  return 'Invalid phone number. Please enter 10 digits.';
                                } else {
                                  return null;
                                }
                              },
                              controller:
                                  signupController.whatsappTextController,
                              decoration: const InputDecoration(
                                label: Text('WhatsApp Number*'),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     controller: panCardTextController,
                          //     decoration: const InputDecoration(
                          //       label: Text('Pan card'),
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Aadhar card number can't be empty";
                                } else if (value.length != 12) {
                                  return "Invalid Aadhar card number length";
                                } else if (!RegExp(r'^[0-9]+$')
                                    .hasMatch(value)) {
                                  return "Aadhar card number must contain only digits";
                                } else {
                                  return null; // If all validation rules pass
                                }
                              },
                              controller:
                                  signupController.aadhaarTextController,
                              decoration: const InputDecoration(
                                label: Text('Aadhaar Card*'),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: const Row(
                          //     mainAxisAlignment: MainAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         'Prefered dealer',
                          //         style: TextingStyle.font12BoldBlack,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   height: 50,
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     border: Border.all(color: ColorConstant.slate),
                          //   ),
                          //   child: Center(
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(4.0),
                          //       child: DropdownButtonHideUnderline(
                          //         child: DropdownButton(
                          //           isExpanded: true,
                          //           value: signupController
                          //                       .selectDealer.value ==
                          //                   ''
                          //               ? null
                          //               : signupController.selectDistrict.value,
                          //           borderRadius: BorderRadius.circular(8),
                          //           autofocus: false,
                          //           items: signupController.dealerModel!.data
                          //               .map<DropdownMenuItem<String>>((e) {
                          //             return DropdownMenuItem<String>(
                          //               value: e.id,
                          //               child: SizedBox(
                          //                 width: MediaQuery.of(context)
                          //                         .size
                          //                         .width *
                          //                     .35,
                          //                 child: Text(
                          //                   e.dealerName,
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //               ),
                          //             );
                          //           }).toList(),
                          //           onChanged: (res) {
                          //             signupController.selectDealer.value =
                          //                 res.toString();
                          //           },
                          //           hint: const Text(
                          //             'Preferred dealer',
                          //             textAlign: TextAlign.left,
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.w400,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     textCapitalization: TextCapitalization.sentences,
                          //     controller: workShopTextController,
                          //     decoration: const InputDecoration(
                          //       label: Text('Workshop Address'),
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.number,
                          //     validator: (value) {
                          //       if (value!.isEmpty) {
                          //         return "Bank account number can't be empty";
                          //       } else if (value.length < 10 ||
                          //           value.length > 20) {
                          //         return "Invalid bank account number length";
                          //       } else if (!RegExp(r'^[0-9]+$')
                          //           .hasMatch(value)) {
                          //         return "Bank account number must contain only digits";
                          //       } else {
                          //         return null; // If all validation rules pass
                          //       }
                          //     },
                          //     controller: accountNumberTextController,
                          //     decoration: const InputDecoration(
                          //       label: Text('Account Number*'),
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     textCapitalization: TextCapitalization.sentences,
                          //     validator: (value) {
                          //       if (value!.isEmpty) {
                          //         return "Bank name can't be empty";
                          //       } else {
                          //         return null;
                          //       }
                          //     },
                          //     controller: bankNameTextController,
                          //     decoration: const InputDecoration(
                          //
                          //       hintText: 'Bank name*',
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     validator: (value) {
                          //       if (value!.isEmpty) {
                          //         return "IFSC code can't be empty";
                          //       } else if (value.length != 11) {
                          //         return "Invalid IFSC code length";
                          //       } else if (!RegExp(r'^[A-Z|a-z]{4}[0][\d]{6}$')
                          //           .hasMatch(value)) {
                          //         return "Invalid IFSC code format";
                          //       } else {
                          //         return null;
                          //       }
                          //     },
                          //     controller: iFSETextController,
                          //     decoration: const InputDecoration(
                          //       hintText: 'IFSE code*',
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.75,
                          //   child: TextFormField(
                          //     controller: gpayNumberTextController,
                          //     decoration: const InputDecoration(
                          //       label: Text('Gpay Number or UPI ID'),
                          //       contentPadding: EdgeInsets.all(8),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const SizedBox(
                          //   height: 18,
                          // ),
                          // Container(
                          //     width: MediaQuery.of(context).size.width * 0.75,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(),
                          //         borderRadius: BorderRadius.circular(5)),
                          //     child: const Padding(
                          //       padding: EdgeInsets.all(12.0),
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text('GPS Pick from map'),
                          //           Icon(Icons.location_on)
                          //         ],
                          //       ),
                          //     )),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const Text('OR'),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // Obx(() {
                          //   if (signupController.isLoading.value == false) {
                          //     return GestureDetector(
                          //       onTap: () async {
                          //         print('taP');
                          //         signupController.getCurrentLocation();
                          //         print(signupController.latitude.value);
                          //         print(signupController.longitude.value);
                          //       },
                          //       child: Container(
                          //         width:
                          //             MediaQuery.of(context).size.width * 0.75,
                          //         decoration: BoxDecoration(
                          //             border: Border.all(),
                          //             borderRadius: BorderRadius.circular(5)),
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(12.0),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               signupController.latitude.value == ''
                          //                   ? const Text('Use current location')
                          //                   : const Text(
                          //                       'Your Location Fetched'),
                          //               signupController.latitude.value == ''
                          //                   ? const Icon(Icons.gps_fixed)
                          //                   : const Icon(Icons.check,
                          //                       color: ColorConstant.green)
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   } else {
                          //     return const CircularProgressIndicator();
                          //   }
                          // }),
                          // const SizedBox(
                          //   height: 18,
                          // ),
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
                                            signupController.pickedImage(
                                                context, ImageSource.camera);
                                          },
                                          child: const Text("Camera"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            signupController.pickedImage(
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
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Obx(() {
                                  print(signupController.userImage.value);
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(14.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Text(
                                            signupController.userImage.value ==
                                                    ''
                                                ? 'Upload UserImage'
                                                : filename = basename(
                                                    signupController
                                                        .userImage.value),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: ColorConstant.liteGrey,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                'Choose file',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            signupController.userImage.value ==
                                                    ''
                                                ? '*No file  selected'
                                                : '',
                                            style: TextingStyle.font8NormalRed,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Select"),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          await signupController
                                              .selectMultiImage(
                                            ImageSource.camera,
                                          );
                                          Get.back();
                                        },
                                        child: const Text(
                                          'Camera',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await signupController
                                              .selectMultiImage(
                                            null,
                                          );
                                          Get.back();
                                        },
                                        child: const Text(
                                          'Gallery',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(14.0),
                                      child: Text(
                                        'Workshop Photo',
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: ColorConstant.liteGrey,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              'Choose file',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          signupController.list.isNotEmpty
                                              ? ''
                                              : '*No file  selected',
                                          style: TextingStyle.font8NormalRed,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(() {
                            return signupController.list.isEmpty
                                ? SizedBox()
                                : SizedBox(
                                    height: 105,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: signupController.list.length,
                                      itemBuilder: (context, index) {
                                        final xFile =
                                            signupController.list[index];
                                        final file = File(xFile.path);
                                        print(file);
                                        return Container(
                                          width: 100,
                                          height: 100,
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: FileImage(file),
                                            ),
                                            color: ColorConstant.greyType,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          }),
                          const SizedBox(
                            height: 18,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (signupController.isVerified.value == true) {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  signupController.sendOtp();
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Please select District',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: ColorConstant.redcolor,
                                  textColor: ColorConstant.white,
                                );
                              }
                            },
                            child: CustomButton(
                                'Signup',
                                MediaQuery.of(context).size.width * 0.75,
                                40,
                                ColorConstant.white,
                                ColorConstant.logoblue,
                                16),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
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
