/// @file base_dialog.dart
/// @date 2024/12/17
/// @author zhuxianwen
/// @brief [全局Dialog弹窗]
///
/// 功能说明:
/// 1. 基于单例模式，提供全局弹窗管理。
/// 2. 支持多种弹窗类型（纯文本、成功、失败、警告、确认、自定义内容等）。
/// 3. 支持弹窗大小自适应内容。
/// 4. 提供便捷的显示和隐藏方法。
/// 5. 确保同一时间只显示一个弹窗。

import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


enum DialogType {
  text, // 纯文本
  success, // 成功
  error, // 失败
  warning, // 警告
  confirmation, // 确认弹窗
  custom, // 自定义内容
}

enum DialogPosition {
  top, // 顶部
  center, // 中间
  bottom, // 底部
}

class BaseDialogManager {
  static final BaseDialogManager _instance = BaseDialogManager._internal();

  factory BaseDialogManager() => _instance;

  BaseDialogManager._internal();

  bool _isDialogVisible = false; // 标志当前是否有弹窗显示

  /// 显示弹窗
  void show({
    required BuildContext context,
    required DialogType type,
    String? title,
    String? content,
    Widget? customContent,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
    bool barrierDismissible = true,
    Color? backgroundColor,
    DialogPosition position = DialogPosition.center,
  }) {
    if (_isDialogVisible) return; // 防止重复弹出
    _isDialogVisible = true;

    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'CustomDialog',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _buildDialogContent(
          context: context,
          type: type,
          title: title,
          content: content,
          customContent: customContent,
          onConfirm: onConfirm,
          onCancel: onCancel,
          confirmText: confirmText,
          cancelText: cancelText,
          backgroundColor: backgroundColor,
          position: position,
        );
      },
    ).then((_) {
      _isDialogVisible = false; // 弹窗关闭后重置标志
    });
  }

  /// 构建弹窗内容
  Widget _buildDialogContent({
    required BuildContext context,
    required DialogType type,
    String? title,
    String? content,
    Widget? customContent,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
    Color? backgroundColor,
    DialogPosition position = DialogPosition.center,
  }) {
    // 当类型为 confirm 时，固定宽高
    final bool isFixedSize = type == DialogType.confirmation;
    final double fixedWidth = 280.sp;
    final double fixedHeight = 150.sp;

    return SafeArea(
      child: Align(
        alignment: _getAlignment(position),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16.sp),
            width: isFixedSize ? fixedWidth : _calculateTextWidth(content ?? '', 14.sp).clamp(150.sp, 400.sp),
            height: isFixedSize ? fixedHeight : null,
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(12.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.sp,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 图标
                if (type == DialogType.success) ...[
                  Icon(Icons.check_circle, color: Colors.green, size: 40.sp),
                  SizedBox(height: 12.sp),
                ] else if (type == DialogType.error) ...[
                  Icon(Icons.error, color: Colors.red, size: 40.sp),
                  SizedBox(height: 12.sp),
                ] else if (type == DialogType.warning) ...[
                  Icon(Icons.warning, color: Colors.orange, size: 40.sp),
                  SizedBox(height: 12.sp),
                ],

                // 标题
                if (title != null)
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (title != null) SizedBox(height: 8.sp),

                // 内容
                if (type != DialogType.custom && content != null)
                  Text(
                    content,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),

                if (type == DialogType.custom && customContent != null)
                  customContent, // 自定义内容

                SizedBox(height: 16.sp),

                // 按钮
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildButtons(
                    onConfirm: onConfirm,
                    onCancel: onCancel,
                    confirmText: confirmText,
                    cancelText: cancelText,
                    fixedButtonWidth: 100.sp, // 固定按钮宽度
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 动态设置弹窗位置
  Alignment _getAlignment(DialogPosition position) {
    switch (position) {
      case DialogPosition.top:
        return Alignment.topCenter;
      case DialogPosition.bottom:
        return Alignment.bottomCenter;
      case DialogPosition.center:
      default:
        return Alignment.center;
    }
  }

  /// 构建按钮
  List<Widget> _buildButtons({
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
    double fixedButtonWidth = 120.0, // 默认固定按钮宽度
  }) {
    final List<Widget> buttons = [];
    if (onCancel != null) {
      buttons.add(SizedBox(
        width: fixedButtonWidth,
        child: _buildButton(
          text: cancelText ?? 'Cancel',
          color: Colors.grey,
          onTap: onCancel,
        ),
      ));
    }
    if (onConfirm != null) {
      buttons.add(SizedBox(
        width: fixedButtonWidth,
        child: _buildButton(
          text: confirmText ?? 'OK',
          color: AppColors.primary,
          onTap: onConfirm,
        ),
      ));
    }
    return buttons;
  }


  /// 构建单个按钮
  Widget _buildButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.sp),
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: Colors.white),
      ),
    );
  }

  /// 动态计算文本宽度
  double _calculateTextWidth(String text, double fontSize) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width + 32.sp; // 添加内边距
  }
}


// BaseDialogManager().show(
//   context: context,
//   type: DialogType.confirmation,
//   onCancel: ()=>{
//   Navigator.of(context, rootNavigator: true).pop()
//   },
//   onConfirm:()=>{
//
//   } ,
//   title: '提示',
//   content: 'ThisThis',
// );

// BaseDialogManager().show(
//   context: context,
//   type: DialogType.success,
//   title: 'Success',
//   content: 'Operation completed successfully!',
// );
// BaseDialogManager().show(
//   context: context,
//   type: DialogType.error,
//   title: 'Error',
//   content: 'Something went wrong!',
// );

// BaseDialogManager().show(
//   context: context,
//   type: DialogType.text,
//   // title: 'Error',
//   content: 'Something went wrong!',
// );