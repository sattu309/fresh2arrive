import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../controller/term_and_condition_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);
  static var termAndConditionScreen = "/termAndConditionScreen";
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final controller = Get.put(TermAndConditionsController());
  @override
  void initState() {
    super.initState();
    controller.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: backAppBar(title: "Terms & Condition", context: context),
          body: controller.isDataLoading.value
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
                                controller.model.value.data!.title
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: AddSize.font16),
                              ),
                              Html(data:controller.model.value.data!.content!.toString(),
                              ),
                            ],
                          ),
                        )
                      ]))))
              : const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor,)));
    });
  }
}
