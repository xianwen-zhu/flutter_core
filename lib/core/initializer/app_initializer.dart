/// @file app_initializer.dart
/// @date 2024/12/13
/// @author zhuxianwen
/// @brief [初始化组件]

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_service.dart';

class AppInitializer {
  /// 静态方法，负责初始化所有依赖
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 初始化本地存储
    await _initializeStorage();

    // 初始化日志
    _initializeLogging();

    // 初始化网络服务
    _initializeNetwork();

    // 初始化全局加载框
    _initializeLoading();

    // 其他初始化任务
    _initializeOther();

    print('App initialization completed.');
  }

  /// 初始化本地存储
  static Future<void> _initializeStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('SharedPreferences initialized.');
  }

  /// 初始化日志
  static void _initializeLogging() {
    // 配置日志系统
    print('Logging system initialized.');
  }

  /// 初始化网络服务
  static void _initializeNetwork() {
    ApiService();
    print('Network service initialized.');
  }

  /// 初始化全局加载框
  static void _initializeLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.black
      ..textColor = Colors.white
      ..userInteractions = false;
    print('EasyLoading initialized.');
  }

  /// 其他初始化任务
  static void _initializeOther() {
    // 例如初始化第三方 SDK
    print('Other components initialized.');
  }
}