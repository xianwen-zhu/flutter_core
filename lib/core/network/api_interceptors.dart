/// @file api_interceptors.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [拦截器]

import 'package:dio/dio.dart';
import '../utils/logger.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logError(err);
    super.onError(err, handler);
  }

  /// 打印请求日志
  void _logRequest(RequestOptions options) {
    final logMessage = '''
==================== API Request ====================
🟢 Method: [${options.method}]
🟢 URL: ${options.uri}
🔹 Headers:
${_formatJson(options.headers)}
🔹 Query Parameters:
${_formatJson(options.queryParameters)}
🔹 Body:
${_formatBody(options.data)}
====================================================
''';
    Logger.info(logMessage, tag: 'API');
  }

  /// 打印响应日志
  void _logResponse(Response response) {
    final logMessage = '''
==================== API Response ====================
🟢 Status Code: [${response.statusCode}]
🟢 URL: ${response.requestOptions.uri}
🔹 Headers:
${_formatJson(response.headers.map)}
🔹 Data:
${_formatBody(response.data)}
====================================================
''';
    Logger.info(logMessage, tag: 'API');
  }

  /// 打印错误日志
  void _logError(DioException err) {
    final responseDetails = err.response != null
        ? '''
🔹 Response Data:
${_formatBody(err.response?.data)}
'''
        : '';

    final logMessage = '''
==================== API Error ====================
🔴 Status Code: [${err.response?.statusCode ?? 'N/A'}]
🔴 URL: ${err.requestOptions.uri}
🔴 Error Message: ${err.message}
$responseDetails
==================================================
''';
    Logger.error(logMessage, tag: 'API');
  }

  /// 格式化JSON
  String _formatJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) return 'N/A';
    return json.entries.map((entry) => '  ${entry.key}: ${entry.value}').join('\n');
  }

  /// 格式化Body
  String _formatBody(dynamic body) {
    if (body == null) return 'N/A';
    String bodyString = body.toString();
    if (bodyString.length > 500) {
      return '${bodyString.substring(0, 500)}...\n[Body Truncated]';
    }
    return bodyString;
  }
}