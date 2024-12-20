/// @file logger.dart
/// @date 2024/12/19
/// @author zhuxianwen
/// @brief [支持日志等级、文件保存、调试模式打印，优化打印格式]

import 'dart:io';
import 'package:flutter/foundation.dart'; // 用于检测调试模式
import 'package:path_provider/path_provider.dart'; // 用于获取文件存储路径

/// 日志等级
enum LogLevel { debug, info, warn, error }

class Logger {
  // 私有构造函数
  Logger._internal();

  // 单例实例
  static final Logger _instance = Logger._internal();

  // 获取单例实例
  factory Logger() => _instance;

  // 静态调用方式的支持
  static Logger get instance => _instance;

  late File _logFile; // 日志文件
  bool _isInitialized = false;
  bool _enableFileLogging = false; // 是否启用文件日志
  LogLevel _logLevel = LogLevel.debug; // 默认日志等级

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

      // 如果日志文件不存在，则创建
      if (!await _instance._logFile.exists()) {
        await _instance._logFile.create();
      }

      _instance._isInitialized = true;
    }
  }

  /// 打印 debug 日志
  static void debug(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.debug, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 打印 info 日志
  static void info(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.info, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 打印 warn 日志
  static void warn(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.warn, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 打印 error 日志
  static void error(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _instance._log(LogLevel.error, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// 通用日志方法
  void _log(LogLevel level, String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    // 检查日志等级
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

    // 在调试模式下打印到控制台
    if (kDebugMode) {
      print(logMessage);
    }

    // 如果启用了文件日志，则写入文件
    if (_enableFileLogging && _isInitialized) {
      _writeToFile(logMessage);
    }
  }

  /// 写入日志文件
  Future<void> _writeToFile(String message) async {
    try {
      await _logFile.writeAsString('$message\n', mode: FileMode.append);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to write log to file: $e');
      }
    }
  }

  /// 清空日志文件
  static Future<void> clearLogs() async {
    if (_instance._enableFileLogging && _instance._isInitialized) {
      await _instance._logFile.writeAsString('');
    }
  }

  /// 读取日志文件内容
  static Future<String> readLogs() async {
    if (_instance._enableFileLogging && _instance._isInitialized) {
      return await _instance._logFile.readAsString();
    }
    return '';
  }
}