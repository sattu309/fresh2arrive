import 'package:get/get.dart';

import '../model/VendorBankLIst_Model.dart';
import '../repositories/Vendor_BankList_Repo.dart';

class VendorBankListController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<VendorBankListModel> bankListModel = VendorBankListModel().obs;

  Future getVendorBankListDetails() async {
    isDataLoading.value = false;
    await vendorBankListRepo().then((value) {
      isDataLoading.value = true;
      bankListModel.value = value;
    });
  }
}
