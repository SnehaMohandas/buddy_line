import 'package:buddy_line/screens/wallet_screen/wallet_controller.dart';
import 'package:buddy_line/widgets/payout_status_popup.dart';
import 'package:buddy_line/widgets/wallet_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../consts/color_constants.dart';
import '../../consts/image_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/custom_button.dart';
import '../bottom_navigation_screen/bottom_Navigation_Controller.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  final TextEditingController amountTextController = TextEditingController();
  final NetworkController networkController = Get.find<NetworkController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value == true) {
        final WalletController walletController = Get.find<WalletController>();
        final BottomNavigationController bottomNavigationController =
            Get.find<BottomNavigationController>();
        return WillPopScope(
          onWillPop: () async {
            bottomNavigationController.changeTabIndex(0);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Wallet'),
            ),
            body: walletController.isLoading.value == true
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: walletController.onRefresh,
                    child: Stack(
                      children: <Widget>[
                        ListView(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: WalletContainer(
                                      context,
                                      0.85,
                                      true,
                                      walletController
                                          .payOutRequestListModel!.data),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            walletController.selectedBox.value =
                                                'all';
                                            walletController
                                                .getPayoutRequestList();
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.present_to_all_outlined,
                                                size: 45,
                                                color: walletController
                                                            .selectedBox
                                                            .value ==
                                                        'all'
                                                    ? ColorConstant.redcolor
                                                    : ColorConstant.logoblue,
                                              ),
                                              const Text(
                                                'All Request',
                                                style:
                                                    TextingStyle.font12BolBlack,
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            walletController.selectedBox.value =
                                                'credit';
                                            await walletController
                                                .getPayoutRequestList();
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.file_download_outlined,
                                                size: 45,
                                                color: walletController
                                                            .selectedBox
                                                            .value ==
                                                        'credit'
                                                    ? ColorConstant.redcolor
                                                    : ColorConstant.logoblue,
                                              ),
                                              const Text(
                                                'Credit',
                                                style:
                                                    TextingStyle.font12BolBlack,
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            walletController.selectedBox.value =
                                                'debit';
                                            walletController
                                                .getPayoutRequestList();
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.file_upload_outlined,
                                                size: 45,
                                                color: walletController
                                                            .selectedBox
                                                            .value ==
                                                        'debit'
                                                    ? ColorConstant.redcolor
                                                    : ColorConstant.logoblue,
                                              ),
                                              const Text(
                                                'Debit',
                                                style:
                                                    TextingStyle.font12BolBlack,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: SizedBox(
                                                        height: 300,
                                                        child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            children: [
                                                              WalletContainer(
                                                                  context,
                                                                  0.70,
                                                                  false,
                                                                  walletController
                                                                      .payOutRequestListModel!
                                                                      .data),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              const Text(
                                                                'Payout Request',
                                                                style: TextingStyle
                                                                    .headFont24bold,
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.7,
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'amount cannot be empty';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  controller:
                                                                      amountTextController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          contentPadding: const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                          hintText:
                                                                              'Max amount ${walletController.payOutRequestListModel!.data.walletAmount}',
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                const BorderSide(
                                                                              color: ColorConstant.bordercolor,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          )),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 13,
                                                              ),
                                                              const SizedBox(
                                                                height: 13,
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.7,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.30,
                                                                        height:
                                                                            45,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: ColorConstant.greyType),
                                                                          color:
                                                                              ColorConstant.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            'Cancel',
                                                                            style:
                                                                                TextStyle(
                                                                              color: ColorConstant.logoblue,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (_formKey.currentState !=
                                                                                null &&
                                                                            _formKey.currentState!.validate()) {
                                                                          _formKey
                                                                              .currentState!
                                                                              .save();
                                                                          int amount =
                                                                              int.parse(amountTextController.text);
                                                                          print(
                                                                              'integer amount $amount');
                                                                          int maxamount = int.parse(walletController
                                                                              .walletAmount
                                                                              .value);
                                                                          print(
                                                                              'integer amount $maxamount');
                                                                          if (maxamount >=
                                                                              amount) {
                                                                            await walletController.sendPayoutRequest(amountTextController.text);
                                                                            amountTextController.text =
                                                                                '';
                                                                          } else {
                                                                            Fluttertoast.showToast(
                                                                              msg: "You have insufficient balance ",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              backgroundColor: ColorConstant.redcolor,
                                                                              textColor: ColorConstant.white,
                                                                            );
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          CustomButton(
                                                                        'Send',
                                                                        MediaQuery.of(context).size.width *
                                                                            0.30,
                                                                        45,
                                                                        ColorConstant
                                                                            .white,
                                                                        ColorConstant
                                                                            .logoblue,
                                                                        18,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                size: 45,
                                                color: ColorConstant.logoblue,
                                              ),
                                            ),
                                            const Text(
                                              'Request',
                                              style:
                                                  TextingStyle.font12BolBlack,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Latest Transactions',
                                        style: TextingStyle.font16BoldBlack,
                                      ),
                                    ],
                                  ),
                                ),
                                walletController.listEmpty.value == true
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 60, bottom: 60),
                                        child: Container(
                                          height: 200,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  AssetImages.noDataFound),
                                            ),
                                          ),
                                          child: const Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'No Transactions found',
                                                  style: TextingStyle
                                                      .font16BoldBlack,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: walletController
                                                .payOutRequestListModel!
                                                .data
                                                .lists
                                                .length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  PayoutStatusPopUp(
                                                      context,
                                                      walletController
                                                          .payOutRequestListModel!
                                                          .data
                                                          .lists[index]
                                                          .details);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 13),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          ColorConstant.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.75,
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .greyType,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 37,
                                                                  width: 37,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: ColorConstant
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          AssetImages
                                                                              .splashImg),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      walletController
                                                                          .payOutRequestListModel!
                                                                          .data
                                                                          .lists[
                                                                              index]
                                                                          .date,
                                                                      style: TextingStyle
                                                                          .font14BoldBlack,
                                                                    ),
                                                                    Text(
                                                                        walletController
                                                                            .payOutRequestListModel!
                                                                            .data
                                                                            .lists[
                                                                                index]
                                                                            .status,
                                                                        style: walletController.payOutRequestListModel!.data.lists[index].reqStatus ==
                                                                                "approved"
                                                                            ? TextingStyle.font12NormalRed
                                                                            : walletController.payOutRequestListModel!.data.lists[index].reqStatus == "pending"
                                                                                ? TextingStyle.font12NormalOrange
                                                                                : walletController.payOutRequestListModel!.data.lists[index].reqStatus == "credit"
                                                                                    ? TextingStyle.font12NormalGreen
                                                                                    : TextingStyle.font12NormalBlackLite)
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                walletController
                                                                            .payOutRequestListModel!
                                                                            .data
                                                                            .lists[
                                                                                index]
                                                                            .reqStatus ==
                                                                        "approved"
                                                                    ? Text(
                                                                        '₹ ${walletController.payOutRequestListModel!.data.lists[index].reqAmount} ',
                                                                        style: TextingStyle
                                                                            .font18BoldRed)
                                                                    : walletController.payOutRequestListModel!.data.lists[index].reqStatus ==
                                                                            "pending"
                                                                        ? Text(
                                                                            '₹ ${walletController.payOutRequestListModel!.data.lists[index].reqAmount} ',
                                                                            style: TextingStyle
                                                                                .font18BoldOrange)
                                                                        : walletController.payOutRequestListModel!.data.lists[index].reqStatus ==
                                                                                "credit"
                                                                            ? Text('+₹ ${walletController.payOutRequestListModel!.data.lists[index].reqAmount}',
                                                                                style: TextingStyle.font18BoldGreen)
                                                                            : walletController.payOutRequestListModel!.data.lists[index].reqStatus == "debit"
                                                                                ? Text('₹ ${walletController.payOutRequestListModel!.data.lists[index].reqAmount}', style: TextingStyle.font18BoldRed)
                                                                                : Text(
                                                                                    '₹ ${walletController.payOutRequestListModel!.data.lists[index].reqAmount}',
                                                                                    style: TextingStyle.font18BoldBlackLite,
                                                                                  )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
