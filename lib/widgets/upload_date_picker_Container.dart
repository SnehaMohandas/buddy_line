import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../consts/color_constants.dart';
import '../consts/text_styles.dart';

Widget SelectDateContainer(context, payoutRequestController) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.88,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
              () => GestureDetector(
            onTap: () async {
              final selctedDatetimetemp = await showDatePicker(
                context: context,
                initialDate:
                DateTime(DateTime.now().year, DateTime.now().month, 1),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              payoutRequestController.fDate.value =
                  DateFormat('dd-MM-yyyy').format(selctedDatetimetemp!);
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.37,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: ColorConstant.greyType,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      payoutRequestController.fDate.value,
                      style: TextingStyle.font14NormalBlack,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: ColorConstant.logoblue,
                    ),
                    child: const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(
              () => GestureDetector(
            onTap: () async {
              final toDateSelectTemp = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              payoutRequestController.tDate.value =
                  DateFormat('dd-MM-yyyy').format(toDateSelectTemp!);
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.37,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: ColorConstant.greyType,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      payoutRequestController.tDate.value,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: ColorConstant.logoblue,
                    ),
                    child: const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
