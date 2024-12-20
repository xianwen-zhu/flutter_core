/// @file api_exceptions.dart
/// @date 2024/12/12
/// @autho zhuxianwen
/// @brief [异常处理]

import 'package:dio/dio.dart';

class ApiExceptions {
  /// 处理 Dio 异常并返回友好的错误信息
  static String handleError(DioException error) {
    // 增加日志记录
    print('API Exception caught: ${error.toString()}');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout: Please check your network connection.';
      case DioExceptionType.sendTimeout:
        return 'Send Timeout: Unable to send request.';
      case DioExceptionType.receiveTimeout:
        return 'Receive Timeout: Server response delayed.';
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return 'Request Cancelled: Operation aborted.';
      case DioExceptionType.unknown:
      default:
        return 'Unexpected Error: ${error.message ?? "No additional information."}';
    }
  }

  /// 处理 HTTP 响应错误并拼接错误信息
  static String _handleResponseError(Response<dynamic>? response) {
    if (response == null) {
      return 'Unknown Error: No response received.';
    }

    // 获取状态码
    final int? statusCode = response.statusCode;

    // 类型安全的响应解析
    String? errorMsg;
    if (response.data is Map) {
      final data = response.data as Map;
      errorMsg = data['error']?['msg']?.toString() ?? 'No error message provided.';
    } else {
      errorMsg = 'Unexpected response format.';
    }

    // 根据状态码提供详细信息
    if (statusCode != null) {
      if (statusCode >= 400 && statusCode < 500) {
        return 'Client Error [$statusCode]: $errorMsg';
      } else if (statusCode >= 500) {
        return 'Server Error [$statusCode]: $errorMsg';
      }
    }

    return 'Unhandled Error [$statusCode]: $errorMsg';
  }

  /// 提取通用错误信息
  static String extractErrorMessage(Response<dynamic>? response) {
    if (response == null) return 'No response data available.';
    if (response.data is Map) {
      final data = response.data as Map<String, dynamic>;
      return data['message'] ?? 'No detailed error message found.';
    }
    return 'Response data is not in expected format.';
  }
}