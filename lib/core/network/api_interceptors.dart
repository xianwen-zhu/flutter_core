/// @file api_interceptors.dart.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [拦截器]

import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['firm'] = 'MDAxMA==';
    // 打印请求日志
    print('Request [${options.method}] => PATH: ${options.path}');
    print('Headers: ${options.headers}');
    print('Query Parameters: ${options.queryParameters}');
    print('Request Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 打印响应日志
    print('Response [${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('Response Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 打印错误日志
    print('Error [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('Error Message: ${err.message}');
    super.onError(err, handler);
  }
}