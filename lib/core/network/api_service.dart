/// @file api_service.dart
/// @date 2024/12/12
/// @autho zhuxianwen
/// @brief [请求框架类]

import 'package:dio/dio.dart';
import 'package:flutter_core/core/services/user_manager.dart';
import '../config/environment.dart';
import 'api_exceptions.dart';
import 'api_interceptors.dart';

typedef SuccessCallback = void Function(dynamic data);
typedef ErrorCallback = void Function(String error);

class ApiService {
  static final ApiService _instance = ApiService._internal();

  late final Dio _dio;

  // 私有构造方法
  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentConfig.baseUrl, // 基础接口地址
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
        headers: {
          'Content-Type': 'application/json',
          'firm':'MDAxMA=='
        },
      ),
    );

    // 添加自定义拦截器
    _dio.interceptors.add(ApiInterceptors());
  }

  // 获取单例实例
  factory ApiService() => _instance;

  /// 处理请求头
  Future<void> _prepareHeaders(bool requiresToken) async {
    if (requiresToken) {
      final token = await UserManager().token; // 获取 Token
      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  /// 统一处理请求逻辑
  Future<void> _handleRequest(
      Future<Response> Function() requestFunction, // 执行具体请求的方法
      SuccessCallback onSuccess,
      ErrorCallback onError,
      ) async {
    try {
      final response = await requestFunction();

      // 处理状态码
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        onSuccess(response.data); // 成功回调
      } else {
        onError('Unexpected response status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMessage = ApiExceptions.handleError(e); // 捕获异常并处理
      onError(errorMessage);
    }
  }

  /// GET 请求
  Future<void> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        bool requiresToken = false,
        required SuccessCallback onSuccess,
        required ErrorCallback onError,
      }) async {
    await _prepareHeaders(requiresToken);
    await _handleRequest(
          () => _dio.get(path, queryParameters: queryParameters), // 具体的 GET 请求
      onSuccess,
      onError,
    );
  }

  /// POST 请求
  Future<void> post(
      String path, {
        Map<String, dynamic>? data,
        bool requiresToken = false,
        required SuccessCallback onSuccess,
        required ErrorCallback onError,
      }) async {
    await _prepareHeaders(requiresToken);
    await _handleRequest(
          () => _dio.post(path, data: data), // 具体的 POST 请求
      onSuccess,
      onError,
    );
  }

  /// PUT 请求
  Future<void> put(
      String path, {
        Map<String, dynamic>? data,
        bool requiresToken = false,
        required SuccessCallback onSuccess,
        required ErrorCallback onError,
      }) async {
    await _prepareHeaders(requiresToken);
    await _handleRequest(
          () => _dio.put(path, data: data), // 具体的 PUT 请求
      onSuccess,
      onError,
    );
  }

  /// DELETE 请求
  Future<void> delete(
      String path, {
        Map<String, dynamic>? data,
        bool requiresToken = false,
        required SuccessCallback onSuccess,
        required ErrorCallback onError,
      }) async {
    await _prepareHeaders(requiresToken);
    await _handleRequest(
          () => _dio.delete(path, data: data), // 具体的 DELETE 请求
      onSuccess,
      onError,
    );
  }

  /// 文件上传
  Future<void> uploadFile(
      String path,
      String filePath, {
        Map<String, dynamic>? data,
        bool requiresToken = false,
        required SuccessCallback onSuccess,
        required ErrorCallback onError,
      }) async {
    await _prepareHeaders(requiresToken);
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      ...?data,
    });
    await _handleRequest(
          () => _dio.post(path, data: formData), // 文件上传 POST 请求
      onSuccess,
      onError,
    );
  }

  /// 文件下载
  Future<void> downloadFile(
      String url,
      String savePath, {
        bool requiresToken = false,
        required SuccessCallback onSuccess,
        required ErrorCallback onError,
      }) async {
    await _prepareHeaders(requiresToken);
    try {
      await _dio.download(url, savePath);
      onSuccess('File downloaded successfully'); // 成功回调
    } on DioException catch (e) {
      final errorMessage = ApiExceptions.handleError(e);
      onError(errorMessage);
    }
  }
}