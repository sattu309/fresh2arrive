import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/vendor_screen/reffer_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../widgets/dimensions.dart';
import '../custum_bottom_bar.dart';
import '../homepage.dart';

class ThankuScreen extends StatefulWidget {
  static var thanku = "/thanku";

  const ThankuScreen({Key? key}) : super(key: key);

  @override
  State<ThankuScreen> createState() => _ThankuScreenState();
}

class _ThankuScreenState extends State<ThankuScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16, vertical: AddSize.padding16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .03,
                ),
                Image(
                  height: height * .25,
                  width: width,
                  image: AssetImage(AppAssets.thankYou),
                ),
                SizedBox(
                  height: height * .04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "your account has been successfully created",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        height: 1.3,

                        color: AppTheme.primaryColor),textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * .020,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12),
                  child: Text(
                    "Admin Will Verify And Update You By \n Call Or Email",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: AddSize.font16,
height: 1.5,
                        color: AppTheme.blackcolor),textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
              ])),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AddSize.padding16, vertical: AddSize.size40),
        child: ElevatedButton(
            onPressed: () {
              Get.toNamed(CustomNavigationBar.customNavigationBar);

            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 60),
                backgroundColor: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AddSize.size10)),
                textStyle: TextStyle(
                    fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
            child: Text(
              "Continue",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppTheme.backgroundcolor,
                  fontWeight: FontWeight.w500,
                  fontSize: AddSize.font18),
            )),
      ),
    );
  }
}
