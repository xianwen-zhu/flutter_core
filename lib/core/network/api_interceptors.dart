/// @file api_interceptors.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [拦截器]

import 'package:dio/dio.dart';
import 'package:flutter_core/core/services/route_manager.dart';
import '../../app/routes/app_pages.dart';
import '../services/user_manager.dart';
import '../utils/eventManager.dart';
import '../utils/logger.dart';


class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.info(_formatLog('Request', options: options), tag: 'API');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.info(_formatLog('Response', response: response), tag: 'API');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // 处理 401 登录超时
      final success = await _handle401Error(err);
      if (success) {
        return; // 重试成功后直接返回，避免继续向下传递错误
      }
    }

    Logger.error(_formatLog('Error', error: err), tag: 'API');
    handler.next(err);
  }

  /// 处理 401 错误
  Future<bool> _handle401Error(DioException err) async {
    final dio = err.requestOptions.extra['dio'] as Dio? ?? Dio();

    try {
      // 尝试刷新 Token
      final newToken = await _refreshToken(dio);
      if (newToken != null) {
        // 更新原始请求的 Token
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        // 重试原始请求
        final response = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        // 打印重试成功的日志
        Logger.info(_formatLog('Retry Response', response: response), tag: 'API');
        return true;
      } else {
        // 发送通知，跳转到登录页
        EventManager.instance.publish('sessionExpired', null);
        return false;
      }
    } catch (e) {
      Logger.error('Error during refresh token or retry: $e', tag: 'API');
      EventManager.instance.publish('sessionExpired', null);
      return false;
    }
  }

  /// 刷新 Token
  Future<String?> _refreshToken(Dio dio) async {
    final refreshToken = await UserManager().refreshToken;

    if (refreshToken == null) {
      Logger.warn('No refresh token available', tag: 'API');
      return null;
    }

    try {
      final response = await dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        final newToken = response.data['token'];
        await UserManager().setToken(newToken); // 保存新的 Token
        Logger.info('Token refreshed successfully', tag: 'API');
        return newToken;
      } else {
        Logger.warn('Failed to refresh token', tag: 'API');
        return null;
      }
    } catch (e) {
      Logger.error('Refresh token request failed: $e', tag: 'API');
      return null;
    }
  }

  /// 格式化日志
  String _formatLog(String type,
      {RequestOptions? options, Response? response, DioException? error}) {
    final buffer = StringBuffer();
    buffer.writeln('==================== API $type ====================');

    // 请求信息
    if (options != null) {
      buffer.writeln('🔹 Request Method: [${options.method}]');
      buffer.writeln('🔹 Request URL: ${options.uri}');
      buffer.writeln('🔹 Request Headers: ${_formatJson(options.headers)}');
      buffer.writeln('🔹 Request Query Parameters: ${_formatJson(options.queryParameters)}');
      buffer.writeln('🔹 Request Body: ${_formatBody(options.data)}');
    }

    // 响应信息
    if (response != null) {
      buffer.writeln('🟢 Response Status Code: [${response.statusCode}]');
      buffer.writeln('🔹 Response Headers: ${_formatJson(response.headers.map)}');
      buffer.writeln('🔹 Response Data: ${_formatBody(response.data)}');
    }

    // 错误信息
    if (error != null) {
      buffer.writeln('🔴 Error Status Code: [${error.response?.statusCode ?? 'N/A'}]');
      buffer.writeln('🔴 Error Message: ${error.message}');
      if (error.response != null) {
        buffer.writeln('🔹 Response Data: ${_formatBody(error.response?.data)}');
      }
    }

    buffer.writeln('==================================================');
    return buffer.toString();
  }

  /// 格式化 JSON
  String _formatJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) return 'N/A';
    return json.entries.map((entry) => '  ${entry.key}: ${entry.value}').join('\n');
  }

  /// 格式化 Body
  String _formatBody(dynamic body) {
    if (body == null) return 'N/A';
    String bodyString = body.toString();
    if (bodyString.length > 500) {
      return '${bodyString.substring(0, 500)}...\n[Body Truncated]';
    }
    return bodyString;
  }
}