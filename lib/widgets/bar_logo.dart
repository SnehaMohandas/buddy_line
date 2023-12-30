import 'package:flutter/material.dart';

import '../consts/image_constants.dart';

Widget BarLogo(context){
  return  Container(
    height: 100,
    width: MediaQuery.of(context).size.width*0.70,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(AssetImages.splashImg),),
    ),
  );
}