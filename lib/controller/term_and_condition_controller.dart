import 'package:get/get.dart';
import '../model/privacy_policy_model.dart';
import '../repositories/privacy_policy_repo.dart';

class TermAndConditionsController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<PrivacyModel> model = PrivacyModel().obs;
  RxString slug = "".obs;

  getData() async {
    isDataLoading.value = false;
    termsConditionsRepo(slug: slug).then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }
}
