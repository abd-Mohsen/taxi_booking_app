import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class Api {
  var client = http.Client();
  String get _hostIP => "$kHostIP/";
  final _getStorage = GetStorage();
  String get accessToken => _getStorage.read("token");

  Map<String, String> headers = {
    "Accept": "Application/json",
    "Content-Type": "application/json",
  };

  Future<String?> getRequest(
    String endPoint, {
    bool auth = false,
    bool canRefresh = true,
    bool showTimeout = true,
    bool toMyServer = true,
    bool utf8Decode = true,
    Map<String, String>? customHeaders,
  }) async {
    try {
      var response = await client
          .get(
            Uri.parse("${toMyServer ? "$_hostIP/" : ""}$endPoint"),
            headers: customHeaders ?? (!auth ? headers : {...headers, "Authorization": "Token $accessToken"}),
          )
          .timeout(kTimeOutDuration);

      String responseBody = utf8Decode ? utf8.decode(latin1.encode(response.body)) : response.body;
      // print("$responseBody =========== ${response.statusCode}");
      if (response.statusCode >= 500) kServerErrorSnackBar();
      return response.statusCode == 200 ? responseBody : null;
    } on TimeoutException {
      if (showTimeout) kTimeOutSnackBar();
      return null;
    } on SocketException {
      if (showTimeout) kTimeOutSnackBar();
      return null;
    } catch (e) {
      return null;
    }
  }
}
