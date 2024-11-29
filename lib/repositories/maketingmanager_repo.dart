import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/marketing_manager_model.dart';
import '../resources/api_url.dart';



Future<MarketingModel> marketManagerRepo() async {
  try {
    http.Response response = await http.get(
      Uri.parse(ApiUrl.managerNetwork),
      headers: await getHeaders(),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return MarketingModel.fromJson(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
      return MarketingModel(
          message: jsonDecode(response.body)["message"],
          status: false,
         );
    }
  } catch (e) {
    return MarketingModel(message: e.toString(), status: false,);
  }
}
