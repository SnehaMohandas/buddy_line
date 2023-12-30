import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/color_constants.dart';
import '../consts/image_constants.dart';
import '../consts/text_styles.dart';

Widget WalletContainer(context, width, imageview,controller ) {
  return Container(
    width: MediaQuery.of(context).size.width * width,
    height: 90,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 1),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
        color: ColorConstant.walletContainer),
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetImages.wallet),
                    ),
                  ),
                ),
              ),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Account Balance',
                  ),
                  Text(
                    '₹${controller.walletAmount}',
                    style: TextingStyle.font20boldlogoblue,
                  )
                ],
              ),
            ],
          ),
          imageview == false ?
          const SizedBox():
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetImages.diamond),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
