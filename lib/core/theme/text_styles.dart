/// @file text_styles.dart
/// @date 2024/12/12
/// @author zh
/// @brief [全局文本样式]

import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 全局文本样式管理类
/// 包含页面标题、模块标题、按钮文字、占位文本、提示文本、警告文本、链接文本等
/// 支持动态字体大小和国际化
class AppTextStyles {
  // 页面标题样式：用于主要页面的大标题
  static final TextStyle pageTitle = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // 模块标题样式：用于页面中分块的模块标题
  static final TextStyle moduleTitle = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // 子模块标题样式：用于小模块的标题
  static final TextStyle subModuleTitle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // 正文主要样式：用于主要内容的文本
  static final TextStyle bodyPrimary = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // 正文次要样式：用于次级内容的文本
  static final TextStyle bodySecondary = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // 按钮文字样式：适用于普通按钮的文字
  static final TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 禁用按钮文字样式：适用于禁用状态的按钮文字
  static final TextStyle buttonDisabled = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textDisabled,
  );

  // 占位文本样式：用于输入框的占位文字
  static final TextStyle placeholder = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPlaceholder,
  );

  // 提示文本样式：用于辅助说明的提示文字
  static final TextStyle hint = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
  );

  // 警告文本样式：用于错误提示或警告信息
  static final TextStyle warning = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.error,
  );

  // 链接文本样式：适用于可点击的链接
  static final TextStyle link = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // 禁用文本样式：用于不可点击的文字
  static final TextStyle disabled = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textDisabled,
  );

  // 标签文本样式：适用于小标签文字
  static final TextStyle label = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  // 导航栏标题样式：适用于 AppBar 的标题
  static final TextStyle appBarTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // 输入框文本样式：用于输入框中的文字
  static final TextStyle input = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // 自适应文本样式：根据上下文动态调整
  static TextStyle adaptiveTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 14.sp,
      color: AppColors.textSecondary,
    ) ??
        bodyPrimary;
  }

  // 国际化支持的文本样式
  static TextStyle getLocalizedText(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
      textBaseline: isRtl ? TextBaseline.alphabetic : TextBaseline.ideographic,
    );
  }
}