import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/image_constants.dart';

class NetworkController extends GetxController{
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();

    checkConnectivity();


    Connectivity().onConnectivityChanged.listen((result) {
      isConnected.value = (result != ConnectivityResult.none);

    });
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    isConnected.value = (connectivityResult != ConnectivityResult.none);
    print(isConnected.value);
  }

  noDataImage(context){
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.6,
                width: MediaQuery.of(context).size.height*0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImages.noData),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}