import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/repositories/update_location_repository.dart';
import 'package:fresh2_arrive/repositories/verify_otp_repository.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/home_page_controller.dart';
import '../controller/location_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/near_store_controller.dart';
import '../repositories/resend_otp_rtepository.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'custum_bottom_bar.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);
  static var otpScreen = "/otpScreen";
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final homeController = Get.put(HomePageController());
  final nearStoreController = Get.put(NearStoreController());
  String phoneNumber = "";
  String otp = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  RxBool hasError1 = false.obs;
  late Timer timer;
  RxInt timerSeconds = 30.obs;
  RxBool showTimer = false.obs;
  setTimer() {
    if (showTimer.value == false) {
      showTimer.value = true;
      timer = Timer.periodic(const Duration(seconds: 1), (value) {
        if (timerSeconds.value > 1) {
          timerSeconds.value--;
        } else {
          showTimer.value = false;
          timer.cancel();
          timerSeconds.value = 30;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    phoneNumber = Get.arguments[0];
    otp = Get.arguments[1];
    setTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(children: [
        SizedBox(
          height: height * .04,
        ),
        const Image(image: AssetImage(AppAssets.login)),
        SizedBox(
          height: height * .05,
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.otpcolor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      SizedBox(
                        height: height * .04,
                      ),
                      Text(
                        "Sent OTP to verify your number",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Obx(() {
                        return PinCodeTextField(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          cursorColor: AppTheme.primaryColor,
                          appContext: context,
                          textStyle: const TextStyle(
                            color: AppTheme.blackcolor,
                            fontWeight: FontWeight.w500,
                          ),
                          controller: otpController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "";
                            } else if (v.length != 4) {
                              return "";
                            } else {
                              return null;
                            }
                          },
                          length: 4,
                          pinTheme: PinTheme(
                            inactiveFillColor: AppTheme.primaryColor,
                            selectedColor: AppTheme.primaryColor,
                            disabledColor: AppTheme.primaryColor,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldWidth: AddSize.size30 * 1.6,
                            fieldHeight: AddSize.size30 * 1.6,
                            borderWidth: 1,
                            activeColor: AppTheme.primaryColor,
                            inactiveColor: !hasError1.value
                                ? AppTheme.primaryColor
                                : Colors.red.withOpacity(.8),
                            errorBorderColor: Colors.red,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            if (v.length == 4) {
                              hasError1.value = false;
                            }
                          },
                        );
                      }),
                      SizedBox(
                        height: height * .03,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() && otpController.text.isNotEmpty) {
                              verifyOtp(
                                  phoneNumber, context,
                                  otpController.text)
                                  .then((value) async {
                                showToast(value.message.toString());
                                if (value.status == true) {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString(
                                      'user_info', jsonEncode(value));
                                  Get.offAllNamed(
                                      CustomNavigationBar.customNavigationBar);
                                }
                              });
                            }
                            else{
                              if (otpController.text.isEmpty) {
                                showToast("Enter OTP");
                              }
                              else{
                                showToast("Enter Valid OTP");
                              }
                            }
                            // else {
                            //   hasError1.value = true;
                            //   showToast("Enter Valid OTP");
                            //   if (otpController.text.isEmpty) {
                            //     showToast("Enter OTP");
                            //   } else if (otp.length < 4) {
                            //     showToast("Enter Valid OTP");
                            //   }
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              minimumSize: const Size(double.maxFinite, 60),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          child: const Text("VERIFY")),
                      SizedBox(
                        height: height * .02,
                      ),
                      TextButton(onPressed: () {
                        if (showTimer.value == false) {
                          resendOtp(phoneNumber, context).then((value) async {
                            if (value.status == true) {
                              showToast("${value.message}");
                              setTimer();
                            } else {
                              showToast(value.message);
                            }
                            return;
                          });
                        }
                      }, child: Obx(() {
                        return Text(
                          !showTimer.value
                              ? "Resend OTP"
                              : "Resend OTP in 00:${timerSeconds.value > 9 ? timerSeconds.value : "0${timerSeconds.value}"}",
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppTheme.primaryColor),
                        );
                      })),
                      SizedBox(
                        height: height * .02,
                      ),
                    ]),
                  )),
            ],
          ),
        )
      ]),
    ));
  }
}
