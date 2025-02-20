import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/verify_otp_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:fresh2_arrive/screens/loginScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_common_ressponse.dart';
import '../model/user_profile_model.dart';

Future<ProfileModel> userProfileData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  print(user.authToken);
  http.Response response =
      await http.get(Uri.parse(ApiUrl.userProfileUrl), headers: headers);
  if (response.statusCode == 200 ||response.statusCode == 400) {
    print("<<<<<<<UserProfileData from repository=======>${response.body}");
    return ProfileModel.fromJson(json.decode(response.body));
  }
  else if (response.statusCode == 401) {
    print(response.statusCode);
    logOutUser();
    throw Exception(response.body);
  }
  else {
    throw Exception(response.body);
  }
}


logOutUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.clear();
  Get.offAllNamed(LoginScreen.loginScreen);
}

Future<ModelCommonResponse> deleteUser(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  http.Response response = await http.post(Uri.parse(ApiUrl.userSoftDelete),
      headers: headers);

  if (response.statusCode == 200  || response.statusCode == 400) {
    log("::::::::::Delete user:::::::::::${response.body}");
    return ModelCommonResponse.fromJson(json.decode(response.body));
  }  else if (response.statusCode == 401) {
    print(response.statusCode);
    logOutUser();
    throw Exception(response.body);
  } else {
    throw Exception(response.body);
  }
}
