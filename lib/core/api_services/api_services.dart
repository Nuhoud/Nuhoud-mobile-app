import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/cache_helper.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio) {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        request: true,
        compact: true,
        maxWidth: 10000));
  }

  Map<String, String> _headers() {
    return {
      'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json",
    };
  }

  Future<Response> get({required String endPoint, Map<String, dynamic>? queryParameters}) {
    return _dio.get(endPoint, queryParameters: queryParameters, options: Options(headers: _headers()));
  }

  Future<Response> post({required String endPoint, required dynamic data, Map<String, dynamic>? queryParameters}) {
    return _dio.post(endPoint, queryParameters: queryParameters, data: data, options: Options(headers: _headers()));
  }

  Future<Response> put({required String endPoint, required dynamic data, Map<String, dynamic>? queryParameters}) {
    return _dio.put(endPoint, queryParameters: queryParameters, data: data, options: Options(headers: _headers()));
  }

  Future<Response> delete({required String endPoint, Map<String, dynamic>? queryParameters}) {
    return _dio.delete(endPoint, queryParameters: queryParameters, options: Options(headers: _headers()));
  }
}
