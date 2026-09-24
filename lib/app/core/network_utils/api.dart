import 'dart:async';
import 'dart:convert';
// ignore: unused_import
import 'dart:developer' as developer;

import 'package:boobook_admin/app/core/local_storage/app_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';

import '../../../generated/l10n.dart';
import '../constants.dart/app_config.dart';

class Network {
  Network._();

  /// the one and only instance of this singleton
  static final instance = Network._();
  final String _url = const String.fromEnvironment(AppConfig.apiUrl,
      defaultValue: 'https://boobook.company/api/v1');
  final bool debug =
      const String.fromEnvironment(AppConfig.debug, defaultValue: 'false') ==
          'true';

  String? token;
  Map<String, Object>? result;

  final Dio _dio = Dio(
    BaseOptions(
        // connectTimeout: 10000,
        // receiveTimeout: 10000,
        ),
  );

  _getToken() async {
    /// TODO modify user login
    token ??= AppStorage().getToken();
  }

  removeToken() {
    token = null;
  }

  Future<bool> checkToken() async {
    await _getToken();
    return (token != null && token != '');
  }

  Future<dynamic> authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    _checkSSl();
    _setDioHeaders(needToken: false);
    try {
      var response = await _dio.post(fullUrl, data: jsonEncode(data));
      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);

      return result;
    }
  }

  Future<dynamic> getData(apiUrl, {bool removeUser = true}) async {
    var fullUrl = _url + apiUrl;
    debugPrint('get api: $fullUrl');
    _checkSSl();
    _getToken();
    _setDioHeaders();
    try {
      final response = await _dio.get(fullUrl);
      debugLog(response);
      showMessage(response);
      checkAuth(response, removeUser: removeUser);

      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);
      return result;
    }
  }

  Future<dynamic> getChangeTokenData(apiUrl,
      {bool removeUser = true, String? changeToken}) async {
    var fullUrl = _url + apiUrl;
    debugPrint('get api: $fullUrl');
    _checkSSl();
    _setDioHeaders(changeToken: changeToken);
    try {
      final response = await _dio.get(fullUrl);
      debugLog(response);
      showMessage(response);
      checkAuth(response, removeUser: removeUser);

      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);
      return result;
    }
  }

  Future<dynamic> getUnData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    debugPrint('get api: $fullUrl');
    _checkSSl();
    _setDioHeaders(needToken: false);

    try {
      final response = await _dio.get(fullUrl);
      debugLog(response);
      showMessage(response);
      checkAuth(response);

      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);
      return result;
    }
  }

  Future<dynamic> deleData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    debugPrint('get delete: $fullUrl');
    _checkSSl();
    _getToken();
    _setDioHeaders();
    try {
      final response = await _dio.delete(fullUrl);
      debugLog(response);
      showMessage(response);
      checkAuth(response);

      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);
      return result;
    }
  }

  Future<dynamic> postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    debugPrint('post post: $fullUrl');
    _checkSSl();
    _getToken();
    _setDioHeaders();
    try {
      final response = await _dio.post(fullUrl, data: jsonEncode(data));
      debugLog(response);
      showMessage(response);
      checkAuth(response);

      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);
      return result;
    }
  }

  Future<dynamic> postFormData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    debugPrint('post postForm: $fullUrl');
    _checkSSl();
    _getToken();
    _setDioHeaders();
    try {
      final response = await _dio.post(fullUrl, data: data);
      debugLog(response);
      showMessage(response);
      checkAuth(response);
      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);

      return result;
    }
  }

  Future<dynamic> putFormData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    debugPrint('putFormData api: $fullUrl');
    _checkSSl();
    _getToken();
    _setDioHeaders();
    try {
      final response = await _dio.put(fullUrl, data: data);
      debugLog(response);
      showMessage(response);
      checkAuth(response);

      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);

      return result;
    }
  }

  Future<dynamic> putData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    debugPrint('put api: $fullUrl');
    _checkSSl();
    _getToken();
    _setDioHeaders();
    try {
      final response = await _dio.put(fullUrl, data: jsonEncode(data));
      debugLog(response);
      showMessage(response);
      checkAuth(response);

      return json.decode(response.toString());
    } on DioException catch (e) {
      errorHandle(e);

      return result;
    }
  }

  postUnData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    _checkSSl();
    _setDioHeaders(needToken: false);
    try {
      final response = await _dio.post(fullUrl, data: jsonEncode(data));
      debugLog(response);
      return json.decode(response.toString());
    } on DioException catch (e) {
      result = {
        ApiConstants.success: false,
        // ApiConstants.message: e.message,
      };
      if (e.response != null) {
        debugPrint('response:${e.response}');
      }
      if (e.response?.statusCode == ResCode.authFalse) {}
      return result;
    }
  }

  _setDioHeaders({bool needToken = true, String? changeToken}) {
    if (needToken) {
      if (changeToken != null) {
        _dio.options.headers["Authorization"] = "Bearer $changeToken";
      } else {
        _dio.options.headers["Authorization"] = "Bearer $token";
      }
    } else {
      _dio.options.headers.remove("Authorization");
    }
    _dio.options.headers['timeZoneOffset'] =
        DateTime.now().timeZoneOffset.inSeconds;
    _dio.options.headers['X-Origin'] = _url;
    _dio.options.headers['Access-Control-Allow-Origin'] = '*';
    _dio.options.headers['Access-Control-Allow-Headers'] = '*';
    _dio.options.headers['Access-Control-Allow-Methods'] =
        'POST,GET,DELETE,PUT,OPTIONS';
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
  }

  _checkSSl() {
    // if (!kIsWeb) {
    //   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (HttpClient client) {
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   };
    // } else if (_url == 'https://dev-aifuu.aisda.com.tw:8000') {
    //   (_dio.httpClientAdapter as BrowserHttpClientAdapter).withCredentials =
    //       true;
    // }
  }

  void errorHandle(DioException e) {
    if (e.response != null) {
      Logger().d(e.response);
      Logger().d(e.message);
    }
    result = {
      ApiConstants.success: false,
      ApiConstants.message: e.message ?? '',
    };
    if (e.type == DioExceptionType.connectionTimeout) {
      EasyLoading.showError(S.current.network_error2,
          duration: const Duration(seconds: 2), dismissOnTap: true);
      result = {'success': false, 'message': S.current.network_error2};
    }
    if (e.type == DioExceptionType.unknown) {
      EasyLoading.showError(S().network_error_no,
          duration: const Duration(seconds: 4), dismissOnTap: true);
      result = {'success': false, 'message': S.current.network_error2};
    }

    if (e.response?.statusCode == ResCode.authFalse) {
      removeToken();
      AppStorage().clearAllData();
    }
  }

  Future<bool> checkAuth(Response<dynamic> response,
      {bool removeUser = true}) async {
    bool result = true;
    if (json.decode(response.toString())[ApiConstants.code] ==
        ResCode.authFalse) {
      EasyLoading.showError(S.current.auth_out_date,
          duration: const Duration(seconds: 2), dismissOnTap: true);

      /// TODO modify user login
      // if (removeUser) {
      //   AuthServices().removeToken();
      //   navService.pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const LoginPage()),
      //   );
      // }
      result = false;
    }
    return result;
  }

  void showMessage(Response<dynamic> response) {
    if (json.decode(response.toString())[ApiConstants.code] ==
        ResCode.showMessage) {
      Logger().d(json.decode(response.toString()));
      EasyLoading.showInfo(
          json.decode(response.toString())[ApiConstants.message],
          duration: const Duration(seconds: 2),
          dismissOnTap: true);
    } else if (json.decode(response.toString())[ApiConstants.code] !=
            ResCode.success &&
        json.decode(response.toString())[ApiConstants.code] !=
            ResCode.authFalse) {
      // Logger().d(json.decode(response.toString()));
    }
  }

  Future<bool> refreshToken() async {
    bool result = false;
    final Map<String, dynamic> loginData = {};
    var response =
        await Network.instance.postData(loginData, '/auth/refresh_token');
    Logger().d(response);
    if (response[ApiConstants.code] == ResCode.success) {
      String refreshtoken = response[ApiConstants.data][ApiConstants.token];
      token = refreshtoken;

      /// TODO modify user login
      // PreferenceService.setString(ApiConstants.token, refreshtoken);
      // await updateLogginUserToken(token);
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  /// TODO modify user login
  // Future<void> updateLogginUserToken(String? token) async {
  //   String loggingUserListString =
  //       PreferenceService.getString(ApiConstants.loggingUserList);
  //   List<User> loggingUserList = [];
  //   if (loggingUserListString.isNotEmpty) {
  //     loggingUserList = (jsonDecode(loggingUserListString) as List)
  //         .map((e) => User.fromJson(e as Map<String, dynamic>))
  //         .toList();
  //   }

  //   int index = loggingUserList.indexWhere((element) => element.token == token);

  //   if (index != -1) {
  //     loggingUserList[index].token = token;
  //   }
  //   await PreferenceService.setString(ApiConstants.loggingUserList,
  //       jsonEncode(loggingUserList.map((e) => e.toJson()).toList()));
  // }
}

void debugLog(var res) {
  if (json.decode(res.toString())[ApiConstants.success] != true) {
    Logger().d(res);
  }

  // Logger().d(json.decode(response.toString()));
}
