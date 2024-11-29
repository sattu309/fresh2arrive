import 'dart:io';
import 'package:fresh2_arrive/model/support_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/privacy_policy_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<PrivacyModel> privacyRepo({required slug}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(
        Uri.parse("${ApiUrl.privacyUrl}?slug=privacy-policy"),
        headers: headers);

    print("Privacy Repository...${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Privacy Repository...${response.body}");
      return PrivacyModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<PrivacyModel> termsConditionsRepo({required slug}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(
        Uri.parse("${ApiUrl.privacyUrl}?slug=terms-condition"),
        headers: headers);

    print("terms-condition...${response.body}");
    print("terms-condition...${"${ApiUrl.privacyUrl}?slug=terms-condition"}");
    if (response.statusCode == 200) {
      print("terms-condition...${response.body}");
      return PrivacyModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
Future<SupportModel> supportRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(
        Uri.parse("${ApiUrl.supportUrl}"),
        headers: headers);

    print("Contact Support...${response.body}");
    if (response.statusCode == 200) {
      print("Contact Support...${response.body}");
      return SupportModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}