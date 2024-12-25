/// @file api_interceptors.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [拦截器]

import 'package:dio/dio.dart';
import '../services/user_manager.dart';
import '../utils/eventManager.dart';
import '../utils/logger.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.info(_formatLog('Request and Response', options: response.requestOptions, response: response), tag: 'API');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final success = await _handle401Error(err);
      if (success) {
        return;
      }
    }

    Logger.error(_formatLog('Error Occurred', error: err), tag: 'API');
    handler.next(err);
  }

  /// 处理 401 错误
  Future<bool> _handle401Error(DioException err) async {
    final dio = err.requestOptions.extra['dio'] as Dio? ?? Dio();
    try {
      final newToken = await _refreshToken(dio);
      if (newToken != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final response = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        Logger.info(_formatLog('Retry Successful', options: err.requestOptions, response: response), tag: 'API');
        return true;
      } else {
        EventManager.instance.publish('sessionExpired', null);
        return false;
      }
    } catch (e) {
      Logger.error('Error during token refresh or retry: $e', tag: 'API');
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
        await UserManager().setToken(newToken);
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
  String _formatLog(String type, {RequestOptions? options, Response? response, DioException? error}) {
    final buffer = StringBuffer();

    // 标题
    buffer.writeln('\n==================== API $type ====================');

    // 请求信息
    if (options != null) {
      buffer
        ..writeln('🔹 [Request Method]: ${options.method}')
        ..writeln('🔹 [Request URL]: ${options.uri}')
        ..writeln('🔹 [Request Headers]:\n${_formatJson(options.headers)}')
        ..writeln('🔹 [Request Query Parameters]:\n${_formatJson(options.queryParameters)}')
        ..writeln('🔹 [Request Body]:\n${_formatBody(options.data)}');
    }

    // 响应信息
    if (response != null) {
      buffer
        ..writeln('\n🟢 [Response Status Code]: ${response.statusCode}')
        ..writeln('🔹 [Response Headers]:\n${_formatJson(response.headers.map)}')
        ..writeln('🔹 [Response Data]:\n${_formatBody(response.data)}');
    }

    // 错误信息
    if (error != null) {
      buffer
        ..writeln('\n🔴 [Error Status Code]: ${error.response?.statusCode ?? 'N/A'}')
        ..writeln('🔴 [Error Message]: ${error.message}')
        ..writeln('🔹 [Error Response Data]:\n${_formatBody(error.response?.data ?? 'N/A')}');
    }

    // 结束线
    buffer.writeln('==================================================\n');

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