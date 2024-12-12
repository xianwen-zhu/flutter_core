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
        return _handleResponseError(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request Cancelled';
      case DioExceptionType.unknown:
      default:
        return 'Unexpected Error: ${error.message}';
    }
  }

  /// 处理 HTTP 响应错误并返回对应的错误信息
  static String _handleResponseError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Error: $statusCode';
    }
  }
}