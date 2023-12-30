import 'package:buddy_line/consts/color_constants.dart';
import 'package:buddy_line/consts/text_styles.dart';
import 'package:buddy_line/screens/bill_details_screen/bill_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/network_controller.dart';

class BillDetailsScreen extends StatelessWidget {
  BillDetailsScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final BillDetailsController billDetailsController =
            Get.find<BillDetailsController>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Bill Details'),
          ),
          body: billDetailsController.isLoading.value == true
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text('Request Number'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text('Dealer Name '),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text('Date '),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    billDetailsController
                                        .billDetailsModel!.data.reqNumber,
                                    style: TextingStyle.font14BoldBlack,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    billDetailsController
                                        .billDetailsModel!.data.dealer,
                                    style: TextingStyle.font14BoldBlack,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    billDetailsController
                                        .billDetailsModel!.data.billDate,
                                    style: TextingStyle.font14BoldBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Product List',
                              style: TextingStyle.font14BoldSlate,
                            ),
                            Text(
                              'Total : ${billDetailsController.billDetailsModel!.data.billAmount}',
                              style: TextingStyle.font14BoldBlack,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Table(
                              columnWidths: {
                                0: FixedColumnWidth(
                                    MediaQuery.of(context).size.width *
                                        0.10), // Using 10%
                                1: FixedColumnWidth(
                                    MediaQuery.of(context).size.width *
                                        0.23), //
                                2: FixedColumnWidth(
                                    MediaQuery.of(context).size.width *
                                        0.12), // Using 30%
                                3: FixedColumnWidth(
                                    MediaQuery.of(context).size.width * 0.13),
                                4: FixedColumnWidth(
                                    MediaQuery.of(context).size.width *
                                        0.18), // Using 20%
                                5: FixedColumnWidth(
                                    MediaQuery.of(context).size.width * 0.19),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: ColorConstant.blueLiteTouch,
                                  ),
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Sl no.',
                                          style: TextingStyle.font12BoldBlack,
                                          textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Product',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextingStyle.font12BoldBlack,
                                          textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Qty',
                                          style: TextingStyle.font12BoldBlack,
                                          textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Unit',
                                          style: TextingStyle.font12BoldBlack,
                                          textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                        8.0,
                                      ),
                                      child: Text('Scheme\namount',
                                          style: TextingStyle.font12BoldBlack,
                                          textAlign: TextAlign.center),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Total\nAmount',
                                        style: TextingStyle.font12BoldBlack,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: billDetailsController
                              .billDetailsModel!.data.lists.length,
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
                                          0.10), // Using 10%
                                  1: FixedColumnWidth(
                                      MediaQuery.of(context).size.width *
                                          0.23), //
                                  2: FixedColumnWidth(
                                      MediaQuery.of(context).size.width *
                                          0.12), // Using 30%
                                  3: FixedColumnWidth(
                                      MediaQuery.of(context).size.width * 0.13),
                                  4: FixedColumnWidth(
                                      MediaQuery.of(context).size.width *
                                          0.18), // Using 20%
                                  5: FixedColumnWidth(
                                      MediaQuery.of(context).size.width * 0.19),
                                },
                                children: [
                                  // Each TableRow represents a row in the Table
                                  TableRow(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color: color,
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          count.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextingStyle.font12NormalBlack,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billDetailsController
                                              .billDetailsModel!
                                              .data
                                              .lists[index]
                                              .productName,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextingStyle.font12NormalBlack,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billDetailsController
                                              .billDetailsModel!
                                              .data
                                              .lists[index]
                                              .qty,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextingStyle.font12NormalBlack,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billDetailsController
                                              .billDetailsModel!
                                              .data
                                              .lists[index]
                                              .unit,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextingStyle.font12NormalBlack,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billDetailsController
                                              .billDetailsModel!
                                              .data
                                              .lists[index]
                                              .amount,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextingStyle.font12NormalBlack,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          billDetailsController
                                              .billDetailsModel!
                                              .data
                                              .lists[index]
                                              .totalAmount,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextingStyle.font12NormalBlack,
                                          textAlign: TextAlign.center,
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
