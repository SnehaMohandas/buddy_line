import 'dart:ffi';

import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/consts/text_styles.dart';
import 'package:buddy_line/screens/bottom_navigation_screen/bottom_Navigation_Controller.dart';
import 'package:buddy_line/screens/roofing_calculator_screen/roofing_calculator_controller.dart';
import 'package:buddy_line/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/network_controller.dart';

class RoofingCalculatorScreen extends StatelessWidget {
  RoofingCalculatorScreen({super.key});

  TextEditingController feetTextController = TextEditingController();
  TextEditingController inchesTextController = TextEditingController();
  TextEditingController countTextController = TextEditingController();

  // TextEditingController widthTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final NetworkController networkController = Get.find<NetworkController>();

  double? inchesVal;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final RoofingCalcController roofingCalcController =
            Get.put(RoofingCalcController());
        final BottomNavigationController bottomNavigationController =
            Get.find<BottomNavigationController>();
        return WillPopScope(
          onWillPop: () async {
            bottomNavigationController.changeTabIndex(0);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('RoofingCalculator'),
            ),
            body: Obx(
              () => roofingCalcController.isLoading.value == true
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    if (roofingCalcController
                                            .selectWidth.value ==
                                        '') {
                                      Fluttertoast.showToast(
                                        msg: 'Please Select the width',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: ColorConstant.black,
                                        textColor: ColorConstant.white,
                                      );
                                    } else {
                                      showDialog(
                                        barrierColor:
                                            Colors.white.withOpacity(.2),
                                        context: context,
                                        builder: (context) {
                                          return Material(
                                            type: MaterialType.transparency,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 4,
                                                        blurRadius: 10,
                                                        offset: Offset(1, 1),
                                                      )
                                                    ],
                                                    color: ColorConstant.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  height: 355,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  child: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const Text(
                                                          'Add here',
                                                          style: TextingStyle
                                                              .headFont24bold,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            child:
                                                                TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Must enter feet';
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              controller:
                                                                  feetTextController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      'Feet',
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10,
                                                                          horizontal:
                                                                              10),
                                                                  border:
                                                                      OutlineInputBorder()),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  inchesTextController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      'Inches',
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10,
                                                                          horizontal:
                                                                              10),
                                                                  border:
                                                                      OutlineInputBorder()),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  countTextController,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Must enter numbercount';
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      'number (nos)',
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10,
                                                                          horizontal:
                                                                              10),
                                                                  border:
                                                                      OutlineInputBorder()),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (_formKey.currentState !=
                                                                    null &&
                                                                _formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                              _formKey
                                                                  .currentState!
                                                                  .save();
                                                              double feetVal =
                                                                  double.parse(
                                                                      feetTextController
                                                                          .text);
                                                              if (inchesTextController
                                                                      .text ==
                                                                  '') {
                                                                inchesTextController
                                                                    .text = '0';
                                                                inchesVal =
                                                                    double.parse(
                                                                        inchesTextController
                                                                            .text);
                                                              } else {
                                                                inchesVal =
                                                                    double.parse(
                                                                        inchesTextController
                                                                            .text);
                                                              }
                                                              double countVal =
                                                                  double.parse(
                                                                      countTextController
                                                                          .text);
                                                              double widthVal =
                                                                  double.parse(
                                                                      roofingCalcController
                                                                          .selectWidth
                                                                          .value);

                                                              double sqftValE =
                                                                  ((inchesVal! /
                                                                              12) +
                                                                          feetVal) *
                                                                      widthVal *
                                                                      countVal;
                                                              double
                                                                  sqfMtrValE =
                                                                  sqftValE *
                                                                      0.092903;
                                                              String
                                                                  sqftValString =
                                                                  sqftValE
                                                                      .toStringAsFixed(
                                                                          3);
                                                              String
                                                                  sqfMtrValString =
                                                                  sqfMtrValE
                                                                      .toStringAsFixed(
                                                                          4);
                                                              double sqftVal =
                                                                  double.parse(
                                                                      sqftValString);
                                                              double sqfMtrVal =
                                                                  double.parse(
                                                                      sqfMtrValString);
                                                              roofingCalcController
                                                                      .sqftTotal
                                                                      .value =
                                                                  roofingCalcController
                                                                          .sqftTotal
                                                                          .value +
                                                                      sqftVal;
                                                              roofingCalcController
                                                                      .sqftTotalString
                                                                      .value =
                                                                  roofingCalcController
                                                                      .sqftTotal
                                                                      .value
                                                                      .toStringAsFixed(
                                                                          3);
                                                              roofingCalcController
                                                                      .sqMtrTotal
                                                                      .value =
                                                                  roofingCalcController
                                                                          .sqMtrTotal
                                                                          .value +
                                                                      sqfMtrVal;
                                                              roofingCalcController
                                                                      .sqMtrTotalString
                                                                      .value =
                                                                  roofingCalcController
                                                                      .sqMtrTotal
                                                                      .value
                                                                      .toStringAsFixed(
                                                                          4);
                                                              roofingCalcController
                                                                  .addItem({
                                                                'width':
                                                                    widthVal,
                                                                'feet': feetVal,
                                                                'inch':
                                                                    inchesVal,
                                                                'nos': countVal,
                                                                'sqFt': sqftVal,
                                                                'sqMtr':
                                                                    sqfMtrVal,
                                                              });
                                                              roofingCalcController
                                                                  .isVisibility
                                                                  .value = true;
                                                              Get.back();
                                                              inchesTextController
                                                                  .text = '';
                                                              countTextController
                                                                  .text = '';
                                                              feetTextController
                                                                  .text = '';
                                                            }
                                                          },
                                                          child: CustomButton(
                                                              'Submit',
                                                              200,
                                                              35,
                                                              ColorConstant
                                                                  .white,
                                                              ColorConstant
                                                                  .logoblue,
                                                              14),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: CustomButton(
                                      'New Row',
                                      85,
                                      25,
                                      ColorConstant.white,
                                      ColorConstant.greenF,
                                      10),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: ColorConstant.browney,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    child: const Center(
                                        child: Text(
                                      'Width',
                                      style: TextingStyle.font10BoldFontWhite,
                                    )),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    decoration: const BoxDecoration(
                                      color: ColorConstant.adContainer,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          iconDisabledColor:
                                              ColorConstant.white,
                                          iconEnabledColor: ColorConstant.black,
                                          style: const TextStyle(
                                              color: ColorConstant.black),
                                          isExpanded: true,
                                          value: roofingCalcController
                                                      .selectWidth.value ==
                                                  ''
                                              ? null
                                              : roofingCalcController
                                                  .selectWidth.value,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          autofocus: false,
                                          items: roofingCalcController
                                              .widthListModel!.data
                                              .map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem<String>(
                                              value: e.width,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .35,
                                                child: Text(
                                                  e.width,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (res) {
                                            roofingCalcController.selectWidth
                                                .value = res.toString();
                                          },
                                          hint: const Text(
                                            'Select Width',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: MediaQuery.of(context).size.width * 0.45,
                                  //   child: const Center(
                                  //     child: Text(
                                  //       'Area',
                                  //       style: TextingStyle.font10BoldBlack,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Visibility(
                              visible: roofingCalcController.isVisibility.value,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.14), // Using 10%
                                        1: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.14), // Using 30%
                                        2: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.14),
                                        3: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.22), // Using 20%
                                        4: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.22),
                                        5: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.10),
                                      },
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            color: ColorConstant.blueLiteTouch,
                                          ),
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Feet',
                                                  style: TextingStyle
                                                      .font12BoldBlack,
                                                  textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Inch',
                                                  style: TextingStyle
                                                      .font12BoldBlack,
                                                  textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Nos',
                                                  style: TextingStyle
                                                      .font12BoldBlack,
                                                  textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Text('Sqr.Ft',
                                                  style: TextingStyle
                                                      .font12BoldBlack,
                                                  textAlign: TextAlign.center),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Sqr.Mtr',
                                                style: TextingStyle
                                                    .font12BoldBlack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Text(' ',
                                                  style: TextingStyle
                                                      .font12BoldBlack,
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: roofingCalcController
                                    .productDataList.length,
                                itemBuilder: (context, index) {
                                  Color color = index % 2 == 0
                                      ? ColorConstant.adContainer
                                      : ColorConstant.blueLiteTouch;
                                  int count = index + 1;
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.14), // Using 10%
                                        1: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.14), // Using 30%
                                        2: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.14),
                                        3: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.22), // Using 20%
                                        4: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.22),
                                        5: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.10),
                                      },
                                      children: [
                                        // Each TableRow represents a row in the Table
                                        TableRow(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1),
                                            color: color,
                                          ),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                roofingCalcController
                                                    .productDataList[index]
                                                        ['feet']
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextingStyle
                                                    .font12NormalBlack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                roofingCalcController
                                                    .productDataList[index]
                                                        ['inch']
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextingStyle
                                                    .font12NormalBlack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                roofingCalcController
                                                    .productDataList[index]
                                                        ['nos']
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextingStyle
                                                    .font12NormalBlack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                roofingCalcController
                                                    .productDataList[index]
                                                        ['sqFt']
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextingStyle
                                                    .font12NormalBlack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                roofingCalcController
                                                    .productDataList[index]
                                                        ['sqMtr']
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextingStyle
                                                    .font12NormalBlack,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                roofingCalcController
                                                        .sqMtrTotal.value =
                                                    roofingCalcController
                                                            .sqMtrTotal.value -
                                                        roofingCalcController
                                                                .productDataList[
                                                            index]['sqMtr'];
                                                roofingCalcController
                                                        .sqftTotal.value =
                                                    roofingCalcController
                                                            .sqftTotal.value -
                                                        roofingCalcController
                                                                .productDataList[
                                                            index]['sqFt'];
                                                roofingCalcController
                                                    .removeItem(index);
                                                roofingCalcController
                                                        .sqftTotalString.value =
                                                    roofingCalcController
                                                        .sqftTotal.value
                                                        .toStringAsFixed(3);
                                                roofingCalcController
                                                        .sqMtrTotalString
                                                        .value =
                                                    roofingCalcController
                                                        .sqMtrTotal.value
                                                        .toStringAsFixed(4);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: ColorConstant.redcolor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: roofingCalcController.isVisibility.value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 70,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Total',
                                          style: TextingStyle.font14BoldBlack,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: ColorConstant.browney),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  roofingCalcController
                                                      .sqftTotalString.value,
                                                  style: TextingStyle
                                                      .font14BoldWhite,
                                                ),
                                                const Text(
                                                  'Sq.ft',
                                                  style: TextingStyle
                                                      .font10BoldFontWhite,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  roofingCalcController
                                                      .sqMtrTotalString.value,
                                                  style: TextingStyle
                                                      .font14BoldWhite,
                                                ),
                                                const Text(
                                                  'Sq.mtr',
                                                  style: TextingStyle
                                                      .font10BoldFontWhite,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: TextFormField(
                                controller:
                                    roofingCalcController.remarkTextController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                    hintText: 'Other Requirements',
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Obx(() => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: roofingCalcController
                                              .enquirySending.value ==
                                          true
                                      ? const Text(
                                          'Sending...',
                                          style:
                                              TextingStyle.font16BoldLogoBlue,
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            List finalCalculateList =
                                                roofingCalcController
                                                    .productDataList
                                                    .map((e) {
                                              return {
                                                "width": "${e['width']}",
                                                "feet": "${e['feet']}",
                                                "inch": "${e['inch']}",
                                                "nos": "${e['nos']}",
                                                "sqr_ft": "${e['sqFt']}",
                                                "sqr_mtr": "${e['sqMtr']}",
                                              };
                                            }).toList();
                                            if (finalCalculateList.isEmpty) {
                                              Fluttertoast.showToast(
                                                msg: 'Please add New Row',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor:
                                                    ColorConstant.black,
                                                textColor: ColorConstant.white,
                                              );
                                              print('tapped');
                                            } else {
                                              print('tappedhere');
                                              roofingCalcController
                                                  .enquirySending.value = true;
                                              roofingCalcController.sendEnquiry(
                                                  roofingCalcController
                                                      .sqftTotalString.value,
                                                  roofingCalcController
                                                      .sqMtrTotalString.value,
                                                  roofingCalcController
                                                      .remarkTextController
                                                      .text,
                                                  finalCalculateList);
                                            }
                                          },
                                          child: CustomButton(
                                              'Send Enquiry',
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              35,
                                              ColorConstant.white,
                                              ColorConstant.logoblue,
                                              14),
                                        ),
                                ))
                          ],
                        ),
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
