import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freshmarket/config/api/base_api.impl.dart';
import 'package:freshmarket/injection.dart';
import 'package:freshmarket/config/api/api.dart';
import 'package:freshmarket/models/api/api_response.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/providers/connection_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseAPI implements BaseAPIImpl {
  Dio? _dio;
  final endpoint = locator<Api>();

  /// Initialize constructors
  BaseAPI({Dio? dio}) {
    _dio = dio ?? Dio();
  }

  Options getHeaders({bool? useToken, String? token}) {
    var header = <String, dynamic>{};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/json';
    if (useToken == true) {
      header['Authorization'] = token;
    }
    return Options(
        headers: header,
        sendTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000 // 60 seconds
        );
  }

  @override
  Future<APIResponse> delete(String url,
      {Map<String, dynamic>? param, bool? useToken}) async {
    try {
      final result = await _dio?.delete(url,
          options: getHeaders(useToken: useToken), queryParameters: param);
      return _parseResponse(result);
    } on DioError catch (e) {
     return APIResponse.failure(
          e.response?.data['meta']['code'],
          e.response?.data['meta']['message'],
          e.response?.data['meta']['status']);
    }
  }

  @override
  Future<APIResponse> get(String url,
      {Map<String, dynamic>? param, bool? useToken, String? token}) async {
    try {
      final result = await _dio?.get(url,
          options: getHeaders(useToken: useToken,token: token), queryParameters: param );
      print(result);
      return _parseResponse(result);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        ConnectionProvider.instance(navigate.navigatorKey.currentContext!)
            .setConnection(false);
      } else {
        if (Platform.environment.containsKey('FLUTTER_TEST') == false) {
          ConnectionProvider.instance(navigate.navigatorKey.currentContext!)
              .setConnection(true);
        }
      }
       return APIResponse.failure(
          e.response?.data['meta']['code'],
          e.response?.data['meta']['message'],
          e.response?.data['meta']['status']);
    }
  }

  @override
  Future<APIResponse> post(String url,
      {Map<String, dynamic>? param,
      data,
      bool? useToken,
      String? token}) async {
    try {
      final result = await _dio?.post(url,
          options: getHeaders(useToken: useToken, token: token),
          data: data,
          queryParameters: param);
      print('result: $result');
      return _parseResponse(result);
    } on DioError catch (e) {
      return APIResponse.failure(e.response?.data['meta']['code'],
          e.response?.data['meta']['message'],
          e.response?.data['meta']['status']);
    }
  }

  @override
  Future<APIResponse> put(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) async {
    try {
      final result = await _dio?.put(url,
          options: getHeaders(useToken: useToken),
          data: data,
          queryParameters: param);
      return _parseResponse(result);
    } on DioError catch (e) {
      return APIResponse.failure(
          e.response?.data['meta']['code'],
          e.response?.data['meta']['message'],
          e.response?.data['meta']['status']);
    }
  }

  Future<APIResponse> _parseResponse(Response? response) async {
    return APIResponse.fromJson({
      'meta': {
        'code': response?.statusCode ?? 500,
        'message': response?.statusMessage ?? 'Unknown error',
        'status': response?.statusMessage ?? 'error'
      },
      'data': response?.data,
    });
  }
}
