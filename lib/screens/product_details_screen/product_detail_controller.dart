import 'dart:async';

import 'package:buddy_line/screens/product_details_screen/product_detail_model.dart';
import 'package:buddy_line/services/services.dart';
import 'package:get/get.dart';

import '../../consts/user_data.dart';

class ProductDetailController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isimageChange = true.obs;
  ProductsDetailByIdModel? productsDetailByIdModel;
  var indexImage = ''.obs;
  RxBool isVisible = true.obs;

  GetprodctDetailById(productId) async {
    isLoading.value = true;
    var data = await HttpServices.productDetailById(token, productId);
    if (data != null) {
      productsDetailByIdModel = data;
      indexImage.value = productsDetailByIdModel!.data.images[0].imgPath;
      isLoading.value = false;
    }
  }

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(milliseconds: 500), (_) {
      toggleVisibility();
    });
  }
}
