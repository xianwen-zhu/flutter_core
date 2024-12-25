/// @file text_styles.dart
/// @date 2024/12/12
/// @author zh
/// @brief [全局文本样式]

import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 全局文本样式管理类
/// 包含页面标题、模块标题、正文文本、按钮文字、提示文本、标签文本等
/// 支持动态字体大小和国际化
class AppTextStyles {
  // 页面标题样式
  static final TextStyle pageTitle = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // 模块标题样式
  static final TextStyle moduleTitle = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // 子模块标题样式
  static final TextStyle subModuleTitle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // 大文本样式：适用于大号正文内容
  static final TextStyle bodyLarge = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // 中等文本样式：适用于中等正文内容
  static final TextStyle bodyMedium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // 小文本样式：适用于小号正文内容
  static final TextStyle bodySmall = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // 极小文本样式：适用于辅助文字、时间戳等
  static final TextStyle bodyExtraSmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // 按钮文字样式
  static final TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // 占位文本样式
  static final TextStyle placeholder = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPlaceholder,
  );

  // 提示文本样式
  static final TextStyle hint = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
  );

  // 警告文本样式
  static final TextStyle warning = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.error,
  );

  // 链接文本样式
  static final TextStyle link = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  // 标签文本样式：适用于小标签文字
  static final TextStyle labelSmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  // 大标签文本样式
  static final TextStyle labelLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  // 图标说明文字样式：适用于图标下的说明文字
  static final TextStyle iconLabel = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // 导航栏标题样式
  static final TextStyle appBarTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.surface,
  );

  // 输入框文本样式
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
        bodyMedium;
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

  // 表格标题样式：适用于表格中的标题
  static final TextStyle tableHeader = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // 表格内容样式
  static final TextStyle tableContent = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // 报表数字样式：适用于数据报表的数字显示
  static final TextStyle reportNumber = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // 表单错误提示样式
  static final TextStyle formError = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
  );
}