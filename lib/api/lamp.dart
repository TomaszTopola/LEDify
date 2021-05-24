import 'dart:convert';
import 'package:http/http.dart';

class Lamp {
  static final String apiUrl = 'http://192.168.2.1:80/multiple-set-color';
  static final Map<String, String> headers = {"content-type": "application/json"};

  static Future<Response> fill({Map<String, dynamic> data}) async{
    Response res = await post(apiUrl,
      headers: headers,
      body: jsonEncode(data),
    );
    return res;
  }
}