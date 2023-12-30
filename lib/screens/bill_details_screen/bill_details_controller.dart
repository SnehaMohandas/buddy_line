import 'package:buddy_line/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import 'bill_details_screen.dart';
import 'get_bill_details_model.dart';

class BillDetailsController extends GetxController {
  BillDetailsModel? billDetailsModel;
  RxBool isLoading = true.obs;

  getBillDetailsById(reqstId) async {
    isLoading.value = true;
    var data = await HttpServices.getBillDetails(token, reqstId);
    if (data != null) {
      billDetailsModel = data;
      isLoading.value = false;
      if (billDetailsModel!.status == true) {
        Get.to(
          BillDetailsScreen(),
          transition: Transition.leftToRight,
        );
      } else {}
    }
  }
}
