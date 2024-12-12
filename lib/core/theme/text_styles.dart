/// @file text_styles.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [全局文本样式]

import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 全局文本样式管理类
/// 包含标题、正文、按钮、警告文本、链接样式等
/// 支持动态字体大小和国际化
class AppTextStyles {
  // 标题样式：适用于大标题、重要页面标题
  static final TextStyle headline1 = TextStyle(
    fontSize: 32.sp, // 动态字体大小
    fontWeight: FontWeight.bold, // 字体加粗
    color: AppColors.textPrimary, // 使用主文本颜色
  );

  // 副标题样式：适用于次级标题
  static final TextStyle headline2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // 小标题样式：适用于卡片标题、小模块标题
  static final TextStyle headline3 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600, // 半粗字体
    color: AppColors.textPrimary,
  );

  // 正文样式1：适用于主要内容文本
  static final TextStyle bodyText1 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // 正文样式2：适用于次要内容文本
  static final TextStyle bodyText2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // 按钮文本样式：适用于按钮上的文字
  static final TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white, // 默认按钮文字颜色为白色
  );

  // 警告文本样式：适用于错误提示、警告信息
  static final TextStyle warning = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.error, // 使用错误颜色
  );

  // 链接文本样式：适用于可点击的链接
  static final TextStyle link = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.primary, // 使用主色
    decoration: TextDecoration.underline, // 添加下划线
  );

  // 标签文本样式：适用于小标签
  static final TextStyle label = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary, // 使用辅助色
  );

  // 输入框文本样式：适用于输入框内容
  static final TextStyle input = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary, // 使用主文本颜色
  );

  // 自适应文本样式：根据上下文动态调整
  /// `adaptiveTextStyle` 会根据当前主题或上下文动态设置字体颜色
  static TextStyle adaptiveTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ) ??
        bodyText1;
  }

  // 国际化支持的文本样式
  /// `getLocalizedText` 根据文本方向（LTR/RTL）设置不同的基线
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
