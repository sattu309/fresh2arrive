import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/VendorProductList_Model.dart';
import '../model/VendorSearchProductsModel.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<VendorSearchProductModel> vendorSearchProductListRepo(
    {required keyword}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user;
  if(pref.getString('user_info') != null) {
    user =
    ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  }
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    if(pref.getString('user_info') != null)
    HttpHeaders.authorizationHeader: 'Bearer ${user!.authToken}'
  };

  try {
    final response = await http.get(
        Uri.parse("${ApiUrl.vendorSearchProductsUrl}?keyword=$keyword"),
        headers: headers);
    print("Vendor search Product List Repository...${response.body}");
    if (response.statusCode == 200) {
      print("Vendor search Product List Repository...${response.body}");
      return VendorSearchProductModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
