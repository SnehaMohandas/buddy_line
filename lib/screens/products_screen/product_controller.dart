import 'package:buddy_line/services/services.dart';
import 'package:get/get.dart';

import '../../consts/user_data.dart';
import 'all_products_model.dart';

class ProductController extends GetxController {
  RxBool isLoading = true.obs;
  AllProductsModel? allProductsModel;

  getAllproducts() async {
    isLoading.value = true;
    var data = await HttpServices.allProducts(token);
    if (data != null) {
      allProductsModel = data;
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getAllproducts();
    super.onInit();
  }
}
