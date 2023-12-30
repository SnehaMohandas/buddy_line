import 'package:buddy_line/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../consts/color_constants.dart';
import '../../consts/user_data.dart';
import 'bill_status_model.dart';
import 'delete_request_model.dart';
import 'get_all_bill_requests.dart';

class BillListController extends GetxController {
  var fDate = DateFormat('dd-MM-yyyy')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1))
      .obs;
  var tDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  BillStatusModel? billStatusModel;
  var selectSatus = 'all'.obs;
  GetBillRequstesModel? getBillRequstesModel;
  DeletetransactionModel? deletetransactionModel;

  RxBool isLoading = true.obs;

  getStatus() async {
    isLoading.value = true;
    var data = await HttpServices.getBillStatus(token);
    if (data != null) {
      billStatusModel = data;
      await getAllBillrequstesByDate();
    }
  }

  getAllBillrequstesByDate() async {
    isLoading.value = true;
    var data = await HttpServices.getBillRequests(
        token, fDate.value, tDate.value, selectSatus.value);
    if (data != null) {
      getBillRequstesModel = data;
      isLoading.value = false;
    }
  }

  deleteRequestById(id) async {
    isLoading.value = true;
    var data = await HttpServices.deleteRequest(token, id);
    if (data != null) {
      deletetransactionModel = data;
      if (deletetransactionModel!.status == true) {
        getAllBillrequstesByDate();
        Fluttertoast.showToast(
          msg: deletetransactionModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: deletetransactionModel!.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    }
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    getAllBillrequstesByDate();
  }

  @override
  void onInit() {
    getStatus();
    super.onInit();
  }
}
