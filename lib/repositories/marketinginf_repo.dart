import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/marketing_manager_model.dart';
import '../model/marketinginf_model.dart';
import '../resources/api_url.dart';



Future<MarketingInfModel> ManagerInfRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.marketingInf),
      headers: await getHeaders(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return MarketingInfModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return MarketingInfModel(
        message: jsonDecode(response.body)["message"],
        status: false,
      );
    }
  } catch (e) {
    return MarketingInfModel(message: e.toString(), status: false,);
  }
}
