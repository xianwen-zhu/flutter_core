/// @file colors.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [全局颜色管理]

import 'package:flutter/material.dart';

class AppColors {
  // 主色调
  static const Color primary = Color(0xFF03A9F4); // 主色
  static const Color secondary = Color(0xFF03DAC6); // 次级色

  // 辅助色
  static const Color success = Color(0xFF4CAF50); // 成功提示色
  static const Color warning = Color(0xFFFFC107); // 警告提示色
  static const Color error = Color(0xFFF44336); // 错误提示色

  // 文本颜色
  static const Color textPrimary = Color(0xFF212121); // 主文本颜色
  static const Color textSecondary = Color(0xFF757575); // 次文本颜色
  static const Color textPlaceholder = Color(0xFFBDBDBD); // 占位符颜色，用于输入框的占位文本
  static const Color textHint = Color(0xFF9E9E9E); // 提示文本颜色，用于提示或辅助信息
  static const Color textDisabled = Color(0xFF9E9E9E); // 禁用状态下的文本颜色

  // 背景色
  static const Color background = Color(0xFFF5F5F5); // 背景颜色
  static const Color surface = Color(0xFFFFFFFF); // 表面颜色
}