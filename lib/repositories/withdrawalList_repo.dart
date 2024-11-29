import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/WithdrawalListModel..dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';

Future<WithdrawalListModel> myWithdrawalListRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  try {
    final response =
        await http.get(Uri.parse("${ApiUrl.withdrawalListUrl}?is_marketing_partner=$id"), headers: headers);
    print("Withdrawal List Repository...${response.body}");

    if (response.statusCode == 200) {
      print("Withdrawal List Repository...${response.body}");
      return WithdrawalListModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
