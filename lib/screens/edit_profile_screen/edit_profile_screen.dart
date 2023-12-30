import 'dart:io';
import 'package:buddy_line/screens/edit_profile_screen/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import '../../consts/color_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? filename;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value == true) {
        final EditProfileController editProfileController =
            Get.put(EditProfileController());
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: editProfileController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          children: [
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
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller:
                                    editProfileController.nameTextController,
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
                            // const SizedBox(
                            //   height: 18,
                            // ),
                            // Obx(() {
                            //   return SizedBox(
                            //     width: MediaQuery
                            //         .of(context)
                            //         .size
                            //         .width * 0.75,
                            //     child: TextFormField(
                            //       obscureText: editProfileController.obscureText.value,
                            //       validator: (value) {
                            //         if (value!.isEmpty) {
                            //           return 'Password cannot be empty';
                            //         } else if (value.length < 6) {
                            //           return 'Password must be at least 6 characters long';
                            //         } else {
                            //           return null;
                            //         }
                            //       },
                            //       controller: editProfileController.passwordTextController,
                            //       decoration: InputDecoration(
                            //         suffixIcon: IconButton(
                            //           onPressed: () {
                            //             editProfileController.toggleVisibility();
                            //           },
                            //           icon: editProfileController.obscureText.value ==
                            //               true
                            //               ? const Icon(
                            //               Icons.remove_red_eye_outlined)
                            //               : const Icon(
                            //             Icons.visibility_off_outlined,
                            //           ),
                            //         ),
                            //         label: const Text('Password*'),
                            //         contentPadding: const EdgeInsets.all(8),
                            //         border: const OutlineInputBorder(),
                            //       ),
                            //     ),
                            //   );
                            // }),
                            const SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Address field can't be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: editProfileController
                                    .address1TextController,
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
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: editProfileController
                                    .address2TextController,
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
                            //   width: MediaQuery
                            //       .of(context)
                            //       .size
                            //       .width * 0.75,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       editProfileController.isVerified.value == false
                            //           ? const Text(
                            //         'Area (Choose your nearest area)*',
                            //         style: TextingStyle.font12NormalRed,
                            //       )
                            //           : const Text(''),
                            //     ],
                            //   ),
                            // ),
                            // Container(
                            //   height: 50,
                            //   width: MediaQuery
                            //       .of(context)
                            //       .size
                            //       .width * 0.75,
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
                            //           editProfileController.selectArea.value == ''
                            //               ? null
                            //               : editProfileController.selectArea.value,
                            //           borderRadius: BorderRadius.circular(8),
                            //           autofocus: false,
                            //           items: editProfileController
                            //               .getAreasModel!.data.area
                            //               .map<DropdownMenuItem<String>>((e) {
                            //             return DropdownMenuItem<String>(
                            //               value: e.id,
                            //               child: SizedBox(
                            //                 width: MediaQuery
                            //                     .of(context)
                            //                     .size
                            //                     .width *
                            //                     .35,
                            //                 child: Text(
                            //                   e.areaName,
                            //                   overflow: TextOverflow.ellipsis,
                            //                 ),
                            //               ),
                            //             );
                            //           }).toList(),
                            //           onChanged: (res) {
                            //             editProfileController.selectArea.value =
                            //                 res.toString();
                            //             editProfileController.isVerified.value = true;
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
                                      value: editProfileController
                                                  .selectDistrict.value ==
                                              ''
                                          ? null
                                          : editProfileController
                                              .selectDistrict.value,
                                      borderRadius: BorderRadius.circular(8),
                                      autofocus: false,
                                      items: editProfileController
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
                                        editProfileController.selectDistrict
                                            .value = res.toString();
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
                                    editProfileController.pinCodeTextController,
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
                            // SizedBox(
                            //   width: MediaQuery
                            //       .of(context)
                            //       .size
                            //       .width * 0.75,
                            //   child: TextFormField(
                            //     keyboardType: TextInputType.number,
                            //     validator: (value) {
                            //       if (value!.isEmpty) {
                            //         return 'Must enter WhatsApp number';
                            //       } else if (!RegExp(r'^[0-9]{10}$')
                            //           .hasMatch(value)) {
                            //         return 'Invalid phone number. Please enter 10 digits.';
                            //       } else {
                            //         return null;
                            //       }
                            //     },
                            //     controller:editProfileController.whatsappTextController,
                            //     decoration: const InputDecoration(
                            //       label: Text('WhatsApp Number*'),
                            //       contentPadding: EdgeInsets.all(8),
                            //       border: OutlineInputBorder(),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 18,
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: TextFormField(
                                controller:
                                    editProfileController.panCardTextController,
                                decoration: const InputDecoration(
                                  label: Text('Pan card'),
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
                                    editProfileController.aadhaarTextController,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date of Birth',
                                    style: TextingStyle.font14NormalBlack,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final selctedDatetimetemp =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                editProfileController.dobDate.value =
                                    DateFormat('dd-MM-yyyy')
                                        .format(selctedDatetimetemp!);
                              },
                              child: Container(
                                height: 47,
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: ColorConstant.slate)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(editProfileController
                                                    .dobDate.value ==
                                                ''
                                            ? 'DOB'
                                            : editProfileController
                                                .dobDate.value),
                                      );
                                    }),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: ColorConstant.slate,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'DOM',
                                    style: TextingStyle.font14NormalBlack,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final selctedDatetimetemp =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                );
                                editProfileController.domDate.value =
                                    DateFormat('dd-MM-yyyy')
                                        .format(selctedDatetimetemp!);
                              },
                              child: Container(
                                height: 47,
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: ColorConstant.slate),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          editProfileController.domDate.value ==
                                                  ''
                                              ? 'DOM'
                                              : editProfileController
                                                  .domDate.value,
                                        ),
                                      );
                                    }),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: ColorConstant.slate,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prefered dealer',
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
                                      value: editProfileController
                                                  .selectDealer.value ==
                                              ''
                                          ? null
                                          : editProfileController
                                              .selectDealer.value,
                                      borderRadius: BorderRadius.circular(8),
                                      autofocus: false,
                                      items: editProfileController
                                          .dealerModel!.data
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem<String>(
                                          value: e.id,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .35,
                                            child: Text(
                                              e.dealerName,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (res) {
                                        editProfileController.selectDealer
                                            .value = res.toString();
                                      },
                                      hint: const Text(
                                        'Preferred dealer',
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
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: editProfileController
                                    .workShopTextController,
                                decoration: const InputDecoration(
                                  label: Text('Workshop Address'),
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
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Bank account number can't be empty";
                                //   } else if (value.length < 10 ||
                                //       value.length > 20) {
                                //     return "Invalid bank account number length";
                                //   } else if (!RegExp(r'^[0-9]+$')
                                //       .hasMatch(value)) {
                                //     return "Bank account number must contain only digits";
                                //   } else {
                                //     return null; // If all validation rules pass
                                //   }
                                // },
                                controller: editProfileController
                                    .accountNumberTextController,
                                decoration: const InputDecoration(
                                  label: Text('Account Number*'),
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
                                textCapitalization:
                                    TextCapitalization.sentences,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Bank name can't be empty";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                controller: editProfileController
                                    .bankNameTextController,
                                decoration: const InputDecoration(
                                  hintText: 'Bank name*',
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
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "IFSC code can't be empty";
                                //   } else if (value.length != 11) {
                                //     return "Invalid IFSC code length";
                                //   } else if (!RegExp(r'^[A-Z|a-z]{4}[0][\d]{6}$')
                                //       .hasMatch(value)) {
                                //     return "Invalid IFSC code format";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                controller:
                                    editProfileController.iFSETextController,
                                decoration: const InputDecoration(
                                  hintText: 'IFSE code*',
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
                                controller: editProfileController
                                    .gpayNumberTextController,
                                decoration: const InputDecoration(
                                  label: Text('Gpay Number or UPI ID'),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('GPS Pick from map'),
                                      Icon(Icons.location_on)
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('OR'),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              if (editProfileController.isLoading.value ==
                                  false) {
                                return GestureDetector(
                                  onTap: () async {
                                    print('taP');
                                    editProfileController.getCurrentLocation();
                                    // print(signupController.latitude.value);
                                    // print(signupController.longitude.value);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          editProfileController
                                                      .latitude.value ==
                                                  ''
                                              ? const Text(
                                                  'Use current location')
                                              : const Text(
                                                  'Your Location Fetched'),
                                          editProfileController
                                                      .latitude.value ==
                                                  ''
                                              ? const Icon(Icons.gps_fixed)
                                              : const Icon(Icons.check,
                                                  color: ColorConstant.green)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                            const SizedBox(
                              height: 18,
                            ),
                            editProfileController.userImage.value == ''
                                ? editProfileController.editProfileModel!.data
                                            .profileImage !=
                                        ''
                                    ? Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                editProfileController
                                                    .editProfileModel!
                                                    .data
                                                    .profileImage),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                                : Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(File(
                                              editProfileController
                                                  .userImage.value))),
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
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
                                              editProfileController.pickedImage(
                                                  context, ImageSource.camera);
                                            },
                                            child: const Text("Camera"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                              editProfileController.pickedImage(
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
                                    print(
                                        editProfileController.userImage.value);
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
                                              editProfileController
                                                          .userImage.value ==
                                                      ''
                                                  ? 'Upload UserImage'
                                                  : filename = basename(
                                                      editProfileController
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
                                              editProfileController
                                                          .userImage.value ==
                                                      ''
                                                  ? '*No file  selected'
                                                  : '',
                                              style:
                                                  TextingStyle.font8NormalRed,
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
                            // GestureDetector(
                            //   onTap: () {
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return AlertDialog(
                            //           title: const Text("Select"),
                            //           actions: [
                            //             TextButton(
                            //               onPressed: () async {
                            //                 await editProfileController
                            //                     .selectMultiImage(
                            //                   ImageSource.camera,
                            //                 );
                            //                 Get.back();
                            //               },
                            //               child: const Text(
                            //                 'Camera',
                            //                 style: TextStyle(
                            //                   color: Colors.blue,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //             TextButton(
                            //               onPressed: () async {
                            //                 await editProfileController
                            //                     .selectMultiImage(
                            //                   null,
                            //                 );
                            //                 Get.back();
                            //               },
                            //               child: const Text(
                            //                 'Gallery',
                            //                 style: TextStyle(
                            //                   color: Colors.blue,
                            //                   fontSize: 16,
                            //                   fontFamily: 'DM Sans',
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   },
                            //   child: Container(
                            //     width: MediaQuery
                            //         .of(context)
                            //         .size
                            //         .width * 0.75,
                            //     decoration: BoxDecoration(
                            //         border: Border.all(),
                            //         borderRadius: BorderRadius.circular(5)),
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(right: 10),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           const Padding(
                            //             padding: EdgeInsets.all(14.0),
                            //             child: Text(
                            //               'Workshop Photo',
                            //             ),
                            //           ),
                            //           Column(
                            //             children: [
                            //               const SizedBox(
                            //                 height: 5,
                            //               ),
                            //               Container(
                            //                 decoration: BoxDecoration(
                            //                     color: ColorConstant.liteGrey,
                            //                     borderRadius:
                            //                     BorderRadius.circular(3)),
                            //                 child: const Padding(
                            //                   padding: EdgeInsets.all(4.0),
                            //                   child: Text(
                            //                     'Choose file',
                            //                   ),
                            //                 ),
                            //               ),
                            //               Text(
                            //                 editProfileController.list.isNotEmpty
                            //                     ? ''
                            //                     : '*No file  selected',
                            //                 style: TextingStyle.font8NormalRed,
                            //               ),
                            //               const SizedBox(
                            //                 height: 8,
                            //               ),
                            //             ],
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 8,
                            // ),
                            // Obx(() {
                            //   return editProfileController.list.isEmpty
                            //       ? SizedBox()
                            //       : SizedBox(
                            //     height: 105,
                            //     child: ListView.builder(
                            //       shrinkWrap: true,
                            //       scrollDirection: Axis.horizontal,
                            //       itemCount: editProfileController.list.length,
                            //       itemBuilder: (context, index) {
                            //         final xFile =
                            //         editProfileController.list[index];
                            //         final file = File(xFile.path);
                            //         print(file);
                            //         return Container(
                            //           width: 100,
                            //           height: 100,
                            //           margin: const EdgeInsets.all(8),
                            //           decoration: BoxDecoration(
                            //             image: DecorationImage(
                            //               fit: BoxFit.fill,
                            //               image: FileImage(file),
                            //             ),
                            //             color: ColorConstant.greyType,
                            //             borderRadius:
                            //             BorderRadius.circular(5),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   );
                            // }),
                            // const SizedBox(
                            //   height: 18,
                            // ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  editProfileController.updateProfileData(
                                      editProfileController
                                          .address1TextController.text,
                                      editProfileController
                                          .address2TextController.text,
                                      editProfileController
                                          .aadhaarTextController.text,
                                      editProfileController
                                          .pinCodeTextController.text,
                                      editProfileController
                                          .panCardTextController.text,
                                      editProfileController
                                          .workShopTextController.text,
                                      editProfileController
                                          .accountNumberTextController.text,
                                      editProfileController
                                          .bankNameTextController.text,
                                      editProfileController
                                          .iFSETextController.text,
                                      editProfileController
                                          .upiIdTextController.text);
                                }
                              },
                              child: CustomButton(
                                  'Update Profile',
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
                ),
        );
      }
      return networkController.noDataImage(context);
    });
  }
}
