import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/screens/bill_details_screen/bill_details_controller.dart';
import 'package:buddy_line/screens/bill_details_screen/bill_details_screen.dart';
import 'package:buddy_line/screens/uploaded_bill_screen/BillListController.dart';
import 'package:buddy_line/widgets/custom_button.dart';
import 'package:buddy_line/widgets/upload_date_picker_Container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../consts/image_constants.dart';
import '../../consts/text_styles.dart';
import '../../controller/network_controller.dart';
import '../../widgets/transactions_widget.dart';

class UploadedBillListScreen extends StatelessWidget {
  UploadedBillListScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value == true) {
        final BillListController billListController =
            Get.put(BillListController());
        final BillDetailsController billDetailsController =
            Get.put(BillDetailsController());
        return Scaffold(
          appBar: AppBar(
            title: const Text('Uploaded Bill List'),
          ),
          body: billListController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: billListController.onRefresh,
                  child: Stack(
                    children: <Widget>[
                      ListView(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SelectDateContainer(
                                  context, billListController),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    return Container(
                                      height: 38,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: ColorConstant.slate),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              isExpanded: true,
                                              value: billListController
                                                          .selectSatus.value ==
                                                      ''
                                                  ? null
                                                  : billListController
                                                      .selectSatus.value,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              autofocus: false,
                                              items: billListController
                                                  .billStatusModel!.data.status
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.stsId,
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .35,
                                                    child: Text(
                                                      e.displayValue,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (res) {
                                                billListController.selectSatus
                                                    .value = res.toString();
                                              },
                                              hint: const Text(
                                                'Select Status',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  GestureDetector(
                                    onTap: () async {
                                      billListController
                                          .getAllBillrequstesByDate();
                                    },
                                    child: CustomButton(
                                        'Search',
                                        MediaQuery.of(context).size.width *
                                            0.37,
                                        35,
                                        ColorConstant.white,
                                        ColorConstant.logoblue,
                                        14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: billListController
                                          .getBillRequstesModel!.data.isEmpty
                                      ? Container(
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
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: billListController
                                              .getBillRequstesModel!
                                              .data
                                              .length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (billListController
                                                        .getBillRequstesModel!
                                                        .data[index]
                                                        .reqStatus ==
                                                    "pending") {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        'Your uploaded bill has not yet been reviewed',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        ColorConstant.black,
                                                    textColor:
                                                        ColorConstant.white,
                                                  );
                                                } else if (billListController
                                                        .getBillRequstesModel!
                                                        .data[index]
                                                        .reqStatus ==
                                                    "rejected") {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Reason for Rejection'),
                                                        content: Text(
                                                            billListController
                                                                .getBillRequstesModel!
                                                                .data[index]
                                                                .remarks),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child:
                                                                Text('Close'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  billDetailsController
                                                      .getBillDetailsById(
                                                          billListController
                                                              .getBillRequstesModel!
                                                              .data[index]
                                                              .reqId);
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13,
                                                    left: 12,
                                                    right: 12),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        ColorConstant.greyType,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: TransactionWidget(
                                                      context,
                                                      billListController
                                                          .getBillRequstesModel!
                                                          .data[index],
                                                      billListController),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }
}
