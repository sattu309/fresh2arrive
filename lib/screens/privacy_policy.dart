import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/privacy_policy_controller.dart';
import '../widgets/dimensions.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);
  static var privacyPolicyScreen = "/privacyPolicyScreen";

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final privacyController = Get.put(PrivacyController());

  @override
  void initState() {
    super.initState();
    privacyController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: backAppBar(title: "Privacy Policy", context: context),
          body: privacyController.isDataLoading.value
              ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16,
                    vertical: AddSize.padding10,
                  ),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: AppTheme.backgroundcolor),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.padding16,
                              vertical: AddSize.padding10),
                          child: Column(
                            children: [
                              Text(
                                privacyController.model.value.data!.title
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AddSize.font16),
                              ),
                              Html(data:privacyController.model.value.data!.content!.toString(),
                              ),
                            ],
                          ),
                        )
                      ]))))
              : const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,)));
    });
  }
}
