import 'dart:convert';
import 'package:api_flutter/shared/model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ApiModel> getRequest(Uri url) async {
    ApiModel finalResponse;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      finalResponse = ApiModel(
        statusCode: response.statusCode,
        body: decodeData,
      );
    } else {
      finalResponse = ApiModel(statusCode: response.statusCode, body: null);
    }
    return finalResponse;
  }

  Future<ApiModel> postRequest(
      {required Uri url,
      required dynamic body,
      Map<String, String>? headers}) async {
    ApiModel finalResponse;
    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      finalResponse = ApiModel(
        statusCode: response.statusCode,
        body: decodeData,
      );
    } else {
      finalResponse = ApiModel(statusCode: response.statusCode, body: null);
    }
    return finalResponse;
  }
}
