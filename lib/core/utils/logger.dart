/// @file logger.dart
/// @date 2024/12/19
/// @author zhuxianwen
/// @brief [支持日志等级、文件保存、调试模式打印，优化打印格式]

import 'dart:io';
import 'package:flutter/foundation.dart'; // 用于检测调试模式
import 'package:path_provider/path_provider.dart'; // 用于获取文件存储路径
import '../config/environment.dart'; // 引入配置

/// 日志等级
enum LogLevel { debug, info, warn, error }

class Logger {
  // 私有构造函数
  Logger._internal();

  // 单例实例
  static final Logger _instance = Logger._internal();

  factory Logger() => _instance;

  static Logger get instance => _instance;

  late File _logFile;
  bool _isInitialized = false;
  bool _enableFileLogging = false;
  LogLevel _logLevel = LogLevel.debug;

  /// 初始化日志系统
  static Future<void> init({
    bool enableFileLogging = false,
    LogLevel logLevel = LogLevel.debug,
  }) async {
    _instance._enableFileLogging = enableFileLogging;
    _instance._logLevel = logLevel;

    if (enableFileLogging) {
      final directory = await getApplicationDocumentsDirectory();
      _instance._logFile = File('${directory.path}/app_logs.txt');

      if (!await _instance._logFile.exists()) {
        await _instance._logFile.create();
      }

      _instance._isInitialized = true;
    }
  }

  /// 通用日志方法
  void _log(LogLevel level, String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    // 检查日志是否启用
    final bool enableLogging = EnvironmentConfig.config['enableLogging'] ?? false;
    if (!enableLogging) return; // 如果配置文件中未启用日志，直接返回

    if (level.index < _logLevel.index) return;

    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '''
    ======================================
    🕒 Timestamp: $timestamp
    🏷️ Tag: ${tag ?? "GENERAL"}
    🔹 Level: ${level.name.toUpperCase()}
    💬 Message: $message
    ${error != null ? '❌ Error: $error' : ''}
    ${stackTrace != null ? '🔍 StackTrace:\n$stackTrace' : ''}
    ======================================
    ''';

    if (kDebugMode) {
      print(logMessage);
    }

    if (_enableFileLogging && _isInitialized) {
      _writeToFile(logMessage);
    }
  }

  Future<void> _writeToFile(String message) async {
    try {
      await _logFile.writeAsString('$message\n', mode: FileMode.append);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to write log to file: $e');
      }
    }
  }

  /// Debug 日志
  static void debug(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.debug, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// Info 日志
  static void info(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.info, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// Warn 日志
  static void warn(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.warn, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// Error 日志
  static void error(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.error, message, tag: tag, error: error, stackTrace: stackTrace);
  }
}