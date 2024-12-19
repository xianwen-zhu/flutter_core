import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @file base_card.dart
/// @date 2024/12/18
/// @author zhuxianwen
/// @brief [通用卡片组件]
/// 功能说明:
/// 1. 支持自定义标题、子标题、内容、尾部。
/// 2. 支持设置卡片背景颜色、阴影、圆角大小。
/// 3. 支持点击事件和长按事件。
/// 4. 支持头部图标或图片。
/// 5. 提供默认的内边距和间距设置。

class BaseCard extends StatelessWidget {
  /// 标题文字
  final String? title;

  /// 子标题文字
  final String? subtitle;

  /// 内容区域
  final Widget? content;

  /// 尾部区域
  final Widget? footer;

  /// 点击事件回调
  final VoidCallback? onTap;

  /// 长按事件回调
  final VoidCallback? onLongPress;

  /// 卡片背景颜色
  final Color? backgroundColor;

  /// 卡片圆角大小
  final double borderRadius;

  /// 卡片阴影大小
  final double elevation;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 头部图标或图片
  final Widget? leading;

  /// 标题文字样式
  final TextStyle? titleStyle;

  /// 子标题文字样式
  final TextStyle? subtitleStyle;

  /// 内容区域样式
  final TextStyle? contentStyle;

  const BaseCard({
    Key? key,
    this.title,
    this.subtitle,
    this.content,
    this.footer,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(8.0),
    this.leading,
    this.titleStyle,
    this.subtitleStyle,
    this.contentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Colors.white,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius.sp),
      ),
      margin: margin,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(borderRadius.sp),
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null || title != null || subtitle != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (leading != null) ...[
                      leading!,
                      SizedBox(width: 8.sp),
                    ],
                    if (title != null)
                      Expanded(
                        child: Text(
                          title!,
                          style: titleStyle ??
                              TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                  ],
                ),
              if (subtitle != null)
                Padding(
                  padding: EdgeInsets.only(top: 4.sp),
                  child: Text(
                    subtitle!,
                    style: subtitleStyle ??
                        TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                  ),
                ),
              if (content != null)
                Padding(
                  padding: EdgeInsets.only(top: 8.sp),
                  child: DefaultTextStyle(
                    style: contentStyle ??
                        TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                    child: content!,
                  ),
                ),
              if (footer != null)
                Padding(
                  padding: EdgeInsets.only(top: 8.sp),
                  child: footer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
