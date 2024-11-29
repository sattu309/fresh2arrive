import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/notification_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<NotificationModel> notificationRepo() async {
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
        Uri.parse(ApiUrl.notificationUrl),
        headers: headers);
    log("Notification Repository...${response.body}");
    if (response.statusCode == 200) {
      log("Notification Repository...${response.body}");
      return NotificationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
