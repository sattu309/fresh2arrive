import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/onboardingScreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/app_assets.dart';
import 'custum_bottom_bar.dart';
import 'package:client_information/client_information.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // var item = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      _getClientInformation();
      SharedPreferences pref = await SharedPreferences.getInstance();
      if(pref.getString('user_info') != null){
        Get.offAllNamed(CustomNavigationBar.customNavigationBar);
        // initDynamicLinks(context);
      }
      else{
        Get.offAllNamed(OnBoardingScreen.onBoardingScreen);
        // initDynamicLinks(context);
      }
    });
  }

//   initDynamicLinks(BuildContext context) async {
//     var data = await FirebaseDynamicLinks.instance.getInitialLink();
//     var deepLink = data?.link;
//     if(deepLink != null){
//     var queryParams = deepLink!.queryParameters['code'];
//         Get.toNamed(LoginByDeepLink.loginByDeepLink,arguments: [queryParams]);
//     }
//
//     item.onLink.listen((dynamicLink)
//     async {
//       var deepLink = dynamicLink.link;
//       debugPrint('DynamicLinks onLink $deepLink');
//     }, onError: (e) async {
//       debugPrint('DynamicLinks onError $e');
//     });
// }

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      log('Failed to get client information');
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', info!.deviceId.toString());
  }









  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            AppAssets.splash1,
            width: screenSize.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 80,
              right: 24,
              left: 24,
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.splash11,
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * .02,
                  // ),
                  // Text("Never Out Of Stock- NOOS"),
                ],
              )),
        ],
      ),
    );
  }
}
