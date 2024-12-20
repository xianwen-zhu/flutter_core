/// @file route_manager.dart
/// @date 2024/12/20
/// @author zhuxianwen
/// @brief [Description]

/// 	1.	基础路由跳转：支持普通跳转、带参数跳转等。
/// 	2.	路由拦截：支持访问权限拦截。
/// 	3.	路由日志：支持记录和调试路由访问日志。
/// 	4.	全局页面返回：支持自定义返回逻辑。
/// 	5.	页面堆栈管理：提供对页面历史堆栈的操作。


import 'package:flutter/material.dart';
import 'package:flutter_core/core/services/user_manager.dart';
import 'package:flutter_core/core/utils/logger.dart';
import 'package:get/get.dart';

class RouteManager {
  // 单例
  RouteManager._internal();
  static final RouteManager instance = RouteManager._internal();

  /// 路由日志开关
  final bool _enableLogging = true;

  /// 路由跳转
  Future<T?>? navigateTo<T>(
      String routeName, {
        dynamic arguments,
      }) {
    _logRoute('Navigate to: $routeName, Arguments: $arguments');
    return Get.toNamed<T>(routeName, arguments: arguments);
  }

  /// 替换路由（跳转后清除当前页面）
  Future<T?>? navigateToAndReplace<T>(
      String routeName, {
        dynamic arguments,
      }) {
    _logRoute('Navigate to and replace: $routeName, Arguments: $arguments');
    return Get.offNamed<T>(routeName, arguments: arguments);
  }

  /// 清空所有页面并跳转
  Future<T?>? navigateToAndClearStack<T>(
      String routeName, {
        dynamic arguments,
      }) {
    _logRoute('Navigate to and clear stack: $routeName, Arguments: $arguments');
    return Get.offAllNamed<T>(routeName, arguments: arguments);
  }

  /// 返回到上一页
  void goBack<T>({
    T? result,
  }) {
    if (Get.key?.currentState?.canPop() ?? false) {
      _logRoute('Go back with result: $result');
      Get.back<T>(result: result);
    } else {
      _logRoute('No route to go back');
    }
  }

  /// 返回到指定页面
  void goBackTo(String routeName) {
    _logRoute('Go back to: $routeName');
    Get.until((route) => Get.currentRoute == routeName);
  }

  /// 获取当前路由名称
  String getCurrentRoute() {
    return Get.currentRoute;
  }

  /// 检查当前是否可以返回
  bool canGoBack() {
    return Get.key?.currentState?.canPop() ?? false;
  }



  /// 路由日志
  void _logRoute(String message) {
    if (_enableLogging) {
      Logger.debug(message);
    }
  }
}




// // 跳转到 Home 页面
// RouteManager.instance.navigateTo('/home');
//
// // 带参数跳转到 Profile 页面
// RouteManager.instance.navigateTo('/profile', arguments: {"userId": 123});
//
// // 替换当前页面为 Home
// RouteManager.instance.navigateToAndReplace('/home');
//
// // 清空页面栈并跳转到 Home
// RouteManager.instance.navigateToAndClearStack('/home');
//
// // 返回到上一页
// RouteManager.instance.goBack();
//
// // 返回到 Login 页面
// RouteManager.instance.goBackTo('/login');
//
// // 获取当前路由
// print(RouteManager.instance.getCurrentRoute());