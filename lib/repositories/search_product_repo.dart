import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Home_Search_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<HomeSerachModel> homeSearchRepo(String keyword) async {
  var map = <String, dynamic>{};
  if (keyword != "") {
    map['keyword'] = keyword;
  }
  log(map.toString());
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response = await http.get(Uri.parse("${ApiUrl.homeSearchUrl}?keyword=$keyword"),headers: headers);
    log(response.body.toString());
    if (response.statusCode == 200) {
      //Helpers.hideShimmer(loader);
      log("Homepage Search Data...${response.body}");
      return HomeSerachModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
