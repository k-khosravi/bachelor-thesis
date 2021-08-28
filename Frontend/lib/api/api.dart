import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'api_offline_phase.dart';
import 'api_online_phase.dart';
import 'api_result.dart';
import '../utils/api_utils.dart' as api;

class API {
  static final int timeOutDuration = api.timeOutDuration;
  static final OfflinePhaseAPI offlinePhaseAPI = OfflinePhaseAPI();
  static final OnlinePhaseAPI onlinePhaseAPI = OnlinePhaseAPI();

  static Future<APIResult> get(String partUrl) async {
    var res = await apiRequest(partUrl, 'GET');
    return res;
  }

  static Future<APIResult> post(String partUrl, dynamic body) async {
    var res = await apiRequest(partUrl, 'POST', postBody: body);
    return res;
  }

  static Future<APIResult> apiRequest(String partUrl, String method,
      {dynamic postBody, dynamic headers}) async {
    Uri url = Uri.parse(partUrl);
    print(url);
    final encodedBody = jsonEncode(postBody);
    late http.Response response;
    try {
      if (method == 'GET') {
        response =
        await http.get(url).timeout(Duration(seconds: timeOutDuration));
      }
      else if (method == 'POST') {
        response = await http
            .post(url, body: encodedBody, headers: api.headers)
            .timeout(Duration(seconds: timeOutDuration));
      }
      Map<String, dynamic> body = jsonDecode(response.body);
      var result = APIResult();
      result.code = body['code'];
      result.error = body['error'];

      if (result.code != 200) {
        _log(result.error);
        result.succeed = false;
        result.data = null;
      } else {
        result.succeed = true;
        result.data = body['data'];
      }
      return result;
    } catch (err) {
      var e = "Unable to get response: " + err.toString();
      var code = 500;
      if (err is TimeoutException) {
        e = 'TimeOut Error';
      } else if (err is IOClient || err is SocketException) {
        code = -1;
        e = 'Socket Error';
      }
      _log("Error => " + e.toString());
      var result = APIResult(
          code: code, error: e.toString(), succeed: false, data: null);
      return result;
    }
  }

  static void _log(dynamic msg) => print("API Class => " + msg);
}
