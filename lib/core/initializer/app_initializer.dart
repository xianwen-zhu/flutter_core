/// @file app_initializer.dart
/// @date 2024/12/13
/// @author zhuxianwen
/// @brief [初始化组件]

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/network_monitor.dart';
import '../utils/logger.dart';

class AppInitializer {
  /// 静态方法，负责初始化所有依赖
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 初始化日志
    await _initializeLogging();

    // 初始化本地存储
    await _initializeStorage();

    // 初始化网络服务
    _initializeNetwork();

    // 初始化全局加载框
    _initializeLoading();

    // 其他初始化任务
    _initializeOther();

  }

  /// 初始化本地存储
  static Future<void> _initializeStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Logger.debug('SharedPreferences initialized.');
  }

  /// 初始化日志
  static Future<void> _initializeLogging() async {
    // 配置日志系统
    Logger.init(enableFileLogging: true, logLevel: LogLevel.debug);
    Logger.debug('Logging system initialized.');
  }

  /// 初始化网络服务
  static void _initializeNetwork() {
    NetworkMonitor().initialize();
    Logger.debug('NetworkMonitor service initialized.');
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
    Logger.debug('EasyLoading initialized.');
  }

  /// 其他初始化任务
  static void _initializeOther() {
    // 初始化第三方 SDK
    Logger.debug('Other components initialized.');
  }
}