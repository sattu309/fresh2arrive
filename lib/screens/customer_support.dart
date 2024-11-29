import 'package:flutter/material.dart';
import 'package:fresh2_arrive/controller/support_controller.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({Key? key}) : super(key: key);
  static var customerSupportScreen = "/customerSupportScreen";
  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  final controller = Get.put(SupportController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }

  _makingPhoneCall(call) async {
    if (await canLaunch("tel:$call")) {
      await launch("tel:$call");
    } else {
      throw 'Could not launch';
    }
  }
  _launchEmail(email) async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Customer Support", context: context),
        body: Obx(() {
          return controller.isDataLoading.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AddSize.size50,
                      ),
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(AppTheme.primaryColor, BlendMode.color),
                        child: Container(
                          height: AddSize.size200,
                          width: AddSize.size200,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(60),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(AppAssets.customer_support))),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size50,
                      ),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            details(
                                " Mobile No :-",
                                controller.model.value.data!.mobileNumber ??
                                    "".toString(),
                                Icons.phone, () {
                              _makingPhoneCall(
                                  controller.model.value.data!.mobileNumber);
                            }),
                            SizedBox(height: AddSize.size10),
                            details(
                                " Land Line No :-",
                                controller.model.value.data!.landlineNumber ??
                                    "".toString(),
                                Icons.phone, () {
                              _makingPhoneCall(
                                  controller.model.value.data!.landlineNumber);
                            }),
                            SizedBox(height: AddSize.size10),
                            details(
                                " Email Id :-",
                                controller.model.value.data!.email ??
                                    "".toString(),
                                Icons.email_outlined, () {
                              _launchEmail(
                                  controller.model.value.data!.email);
                            }),
                            SizedBox(height: AddSize.size10),
                            details(
                                " WhatsApp No :-",
                                controller.model.value.data!.whatsappNumber ?? "".toString(),
                                Icons.chat_bubble_outline,() async {
                              var url = "https://wa.me/${controller.model.value.data!.mobileNumber}/?text=hello";
                              if (await launch(url)) {
                              await canLaunch(url);
                              } else {
                              showToast('there is no WhatsApp installed');
                              }
                            }),
                            SizedBox(height: AddSize.size10),
                          ],
                        ),
                      )),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }));
  }

  details(key, value, icon, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icon),
                Text(
                  key,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500, fontSize: AddSize.font16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500, color:AppTheme.primaryColor, fontSize: AddSize.font16),
            ),
          )
        ],
      ),
    );
  }
}
