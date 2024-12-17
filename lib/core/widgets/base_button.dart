/// @file base_button.dart
/// @date 2024/12/16
/// @author zhuxianwen
/// @brief [通用按钮]

/// 功能描述:
/// 1. 提供一个通用的按钮组件，支持多种状态和样式。
/// 2. 状态支持：正常、加载中、禁用。
/// 3. 样式支持：填充按钮（elevated）、边框按钮（outlined）、文本按钮（text）。
/// 4. 支持图标与文字组合，支持图标位置灵活配置（图标在左侧或右侧）。
/// 5. 支持自定义尺寸、圆角、背景颜色、文字颜色等。
/// 6. 提升组件复用性，减少项目中重复定义按钮的代码。

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
enum ButtonType {
  elevated, // 填充按钮
  outlined, // 边框按钮
  text, // 文本按钮
}
class BaseButton extends StatelessWidget {
  /// 按钮文本
  final String text;

  /// 按钮点击事件
  final VoidCallback? onPressed;

  /// 按钮类型
  final ButtonType type;

  /// 是否禁用按钮
  final bool isDisabled;

  /// 是否加载中
  final bool isLoading;

  /// 自定义背景颜色
  final Color? backgroundColor;

  /// 自定义边框颜色（仅适用于 Outlined 按钮）
  final Color? borderColor;

  /// 自定义文字颜色
  final Color? textColor;

  /// 图标
  final IconData? icon;

  /// 图标位置
  final bool iconOnRight;

  /// 自定义宽度（优先级高）
  final double? width;

  /// 自定义高度
  final double? height;

  /// 自定义圆角
  final double borderRadius;

  /// 自定义文字大小
  final double fontSize;

  /// 按钮内容对齐方式
  final MainAxisAlignment contentAlignment;

  /// 按钮左右间距（优先级低）
  final double horizontalMargin;

  const BaseButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.elevated,
    this.isDisabled = false,
    this.isLoading = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.icon,
    this.iconOnRight = false,
    this.width, // 自定义宽度
    this.height,
    this.borderRadius = 8.0,
    this.fontSize = 14.0,
    this.contentAlignment = MainAxisAlignment.center,
    this.horizontalMargin = 20.0, // 默认左右间距
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 动态计算按钮宽度（优先使用指定宽度）
        final double buttonWidth =
            width ?? constraints.maxWidth - (horizontalMargin * 2);

        return Center(
          child: SizedBox(
            width: buttonWidth,
            height: height ?? 48.sp,
            child: ElevatedButton(
              style: _buildButtonStyle(context),
              onPressed: isDisabled || isLoading ? null : onPressed,
              child: _buildButtonContent(),
            ),
          ),
        );
      },
    );
  }

  /// 构建按钮样式
  ButtonStyle _buildButtonStyle(BuildContext context) {
    final Color primaryColor = backgroundColor ?? Theme.of(context).primaryColor;

    switch (type) {
      case ButtonType.elevated:
        return ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? Colors.grey : primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.sp),
          ),
        );
      case ButtonType.outlined:
        return OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? primaryColor, width: 1.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.sp),
          ),
        );
      case ButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: textColor ?? primaryColor,
        );
    }
  }

  /// 构建按钮内容
  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: 20.sp,
        height: 20.sp,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: textColor ?? Colors.white,
        ),
      );
    }

    final textWidget = Text(
      text,
      style: TextStyle(
        fontSize: fontSize.sp,
        color: textColor ?? Colors.white,
      ),
    );

    if (icon == null) {
      return textWidget;
    }

    final iconWidget = Icon(icon, size: 20.sp, color: textColor ?? Colors.white);

    return iconOnRight
        ? Row(
      mainAxisAlignment: contentAlignment,
      children: [
        textWidget,
        SizedBox(width: 8.sp),
        iconWidget,
      ],
    )
        : Row(
      mainAxisAlignment: contentAlignment,
      children: [
        iconWidget,
        SizedBox(width: 8.sp),
        textWidget,
      ],
    );
  }
}