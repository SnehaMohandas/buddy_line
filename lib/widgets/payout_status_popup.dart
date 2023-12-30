
import 'package:flutter/material.dart';

import '../consts/color_constants.dart';
import '../consts/text_styles.dart';

Future PayoutStatusPopUp(context,controller){
  return showDialog(
    barrierColor: Colors.white.withOpacity(.2),
    context: context,
    builder: (BuildContext context) {
      return Material(

        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Center(
            child: Container(

              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  )
                ],
                color: ColorConstant.white,
              ),
              width: MediaQuery.of(context).size.width*0.85,
              height: 230,
              child:  SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const Text('Payout Status',style: TextingStyle.headFont24bold,),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Text('Request Date'),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child:controller.sts == 'rejected' ? Text('Rejected Date'): Text('Payment Date')
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Text('Payment Method'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  controller.reqDate,
                                  style: TextingStyle.font14BoldBlack,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  controller.createdDate,
                                  style: TextingStyle.font14BoldBlack,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  controller.paymentMethod,
                                  style: TextingStyle.font14BoldBlack,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),
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