import 'package:delivery_man/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseApi extends BaseApiServices {
  Future<dynamic> postApi(String url, Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed request: ${response.statusCode} - ${response.body}');
    }

    return _decodeResponse(response);
  }

  // dynamic _decodeResponse(http.Response response) {
  //   try {
  //     return json.decode(response.body);
  //   } catch (e) {
  //     throw Exception('Failed to decode JSON: $e');
  //   }
  // }
  dynamic _decodeResponse(http.Response response) {
    try {
      var decodedResponse = json.decode(response.body);
      print("Decoded Response: $decodedResponse");
      return decodedResponse;
    } catch (e) {
      throw Exception('Failed to decode JSON: $e');
    }
  }
}
