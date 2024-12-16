/// @file api_exceptions.dart
/// @date 2024/12/12
/// @autho zhuxianwen
/// @brief [异常处理]

import 'package:dio/dio.dart';

class ApiExceptions {
  /// 处理 Dio 异常并返回友好的错误信息
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout';
      case DioExceptionType.sendTimeout:
        return 'Send Timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive Timeout';
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return 'Request Cancelled';
      case DioExceptionType.unknown:
      default:
        return 'Unexpected Error: ${error.message}';
    }
  }

  /// 处理 HTTP 响应错误并拼接错误信息
  static String _handleResponseError(Response<dynamic>? response) {
    if (response == null) {
      return 'Unknown Error';
    }

    // 获取状态码
    final int? statusCode = response.statusCode;

    // 尝试从响应中提取 `msg` 字段
    String? errorMsg;
    if (response.data is Map<String, dynamic>) {
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      errorMsg = data['error']?['msg'] ?? 'Unknown error occurred';
    }

    // 拼接状态码和错误消息
    switch (statusCode) {
      case 400:
        return 'Bad Request: $errorMsg';
      case 401:
        return 'Unauthorized: $errorMsg';
      case 403:
        return 'Forbidden: $errorMsg';
      case 404:
        return 'Not Found: $errorMsg';
      case 500:
        return 'Internal Server Error: $errorMsg';
      default:
        return 'Error $statusCode: $errorMsg';
    }
  }
}