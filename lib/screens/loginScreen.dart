import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:client_information/client_information.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/otpscreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/login_repository.dart';
import '../routers/my_router.dart';
import '../widgets/add_text.dart';
import '../widgets/commonTextField.dart';
import '../widgets/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static var loginScreen = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ClientInformation? _clientInfo;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  bool? _isValue = false;
  final _formKey = GlobalKey<FormState>();
  bool showValidation = false;

  StreamSubscription<Map>? streamSubscription;
  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) async {
      print('listenDynamicLinks - DeepLink Data: $data');
      print('------------------------------------Link clicked----------------------------------------------');
      if (data.containsKey('+clicked_branch_link') && data['+clicked_branch_link'] == true) {
        print('------------------------------------Link clicked----------------------------------------------');
        print('referralCode: ${data['referralCode']}');
        print(
            '------------------------------------------------------------------------------------------------  $data["referralCode"]');
        if (data["referralCode"] != null) {
          print(data["referralCode"]);
          referralCodeController.text = data["referralCode"].toString();
        }
      }
    }, onError: (error) {
      print('InitSession error: ${error.toString()}');
    });
  }

  @override
  void initState() {
    super.initState();
    _getClientInformation();
    listenDynamicLinks();
    FirebaseMessaging.onMessage.listen((event) {
      log("Notification Reciebdd.....    ");
    });
  }

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      // print('Failed to get client information');
    }
    if (!mounted) return;

    setState(() {
      _clientInfo = info!;
    });
  }

  getToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      print("token....    ${value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    getToken();
    return Scaffold(
        body: Theme(
      data: ThemeData(useMaterial3: true,  dividerColor: Colors.transparent),
      child: Stack(children: [
        Form(
            key: _formKey,
            child: ListView(
              children: [
                Image(
                  image: AssetImage(AppAssets.login),
                  height: height * .50,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: AppTheme.otpcolor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(
                        height: height * .02,
                      ),
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      // CommonTextFieldWidget(
                      //     controller: phoneNumberController,
                      //     hint: "Mobile Number",
                      //     keyboardType: TextInputType.number,
                      //     validator: validateMobile,
                      //     length: 10,
                      //     prefix: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         SizedBox(
                      //           width: width * .02,
                      //         ),
                      //         Text(
                      //           "+91",
                      //           style: TextStyle(
                      //               color: AppTheme.userText,
                      //               fontSize: AddSize.font14),
                      //         ),
                      //         SizedBox(
                      //           width: width * .02,
                      //         ),
                      //         Container(
                      //           height: height * .03,
                      //           width: width * .003,
                      //           color: AppTheme.greycolor,
                      //         ),
                      //       ],
                      //     )),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: 10,
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                            border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                            hintText: "Mobile Number",
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: width * .02,
                                ),
                                Text(
                                  "+91",
                                  style: TextStyle(color: AppTheme.userText, fontSize: AddSize.font14),
                                ),
                                SizedBox(
                                  width: width * .02,
                                ),
                                Container(
                                  height: height * .03,
                                  width: width * .003,
                                  color: AppTheme.greycolor,
                                ),
                              ],
                            )),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return 'Please enter 10 digit number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      CommonTextFieldWidget(
                        controller: referralCodeController,
                        hint: "Referral Code(Optional)",
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              side: BorderSide(color: showValidation == false ? AppTheme.primaryColor : Colors.red, width: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              value: _isValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isValue = value;
                                });
                              }),
                          Expanded(
                              child: Text(
                            "By continuing, you agree to our Terms of service & Privacy policy",
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            var fcmToken = await FirebaseMessaging.instance.getToken();
                            if (_formKey.currentState!.validate() && _isValue == true) {
                              createLogin(
                                      userPoneNo: phoneNumberController.text,
                                      referalCode: referralCodeController.text,
                                      context: context,
                                      fcmToken: fcmToken!)
                                  .then((value) async {
                                showToast(value.message.toString());
                                if (value.status == true) {
                                  showToast(value.message.toString());
                                  Get.toNamed(OtpScreen.otpScreen, arguments: [phoneNumberController.text, value.data.toString()]);
                                }
                              });
                            } else {
                              showValidation = true;
                              setState(() {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            minimumSize: const Size(double.maxFinite, 60),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child:
                              const Text("LOGIN", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white))),
                      SizedBox(
                        height: height * .02,
                      ),
                    ]),
                  ),
                )
              ],
            ))
      ]),
    ));
  }
}
