/// @file base_text_field.dart
/// @date 2024/12/16
/// @author zhuxianwen
/// @brief [通用TextFlield]
/// @file base_text_field.dart
/// @date 2024/12/16
/// @author zhuxianwen
/// @brief [通用 TextField 组件]
///
/// 功能描述:
/// 1. 提供一个可复用的输入框组件，适配多种场景和需求。
/// 2. 支持以下功能:
///    - **基本属性**: 占位符、标签文字、错误提示等。
///    - **状态控制**: 是否禁用、是否只读、是否为密码输入框、多行输入支持等。
///    - **自定义样式**: 支持边框样式、输入内容格式、左右图标、圆角大小等配置。
///    - **事件回调**: 输入内容变化、提交回调、焦点变化事件。
///    - **输入限制**: 可设置输入格式、最大长度、最大行数等。
/// 3. 提高开发效率，减少重复代码，满足项目中大多数输入框的使用需求。

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseTextField extends StatelessWidget {
  /// 控制器
  final TextEditingController? controller;

  /// 占位符文字
  final String? hintText;

  /// 标签文字
  final String? labelText;

  /// 错误提示信息
  final String? errorText;

  /// 验证器
  final String? Function(String?)? validator;

  /// 是否为密码输入框
  final bool isPassword;

  /// 是否为多行输入
  final bool isMultiline;

  /// 最大输入长度
  final int? maxLength;

  /// 最大行数
  final int? maxLines;

  /// 键盘类型
  final TextInputType keyboardType;

  /// 输入格式限制
  final List<TextInputFormatter>? inputFormatters;

  /// 自定义边框样式
  final OutlineInputBorder? border;

  /// 是否禁用
  final bool isDisabled;

  /// 是否只读
  final bool isReadOnly;

  /// 左侧图标/图片 (支持IconData或路径)
  final dynamic prefixIcon;

  /// 右侧图标/图片 (支持IconData或路径)
  final dynamic suffixIcon;

  /// 右侧图标点击事件
  final VoidCallback? onSuffixIconTap;

  /// 焦点变化回调
  final FocusNode? focusNode;

  /// 输入内容变化回调
  final ValueChanged<String>? onChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmitted;

  const BaseTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.validator,
    this.isPassword = false,
    this.isMultiline = false,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.border,
    this.isDisabled = false,
    this.isReadOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword, // 密码模式
      maxLength: maxLength,
      maxLines: isMultiline ? null : maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      readOnly: isReadOnly,
      enabled: !isDisabled,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        counterText: '', // 隐藏计数字符
        prefixIcon: _buildIcon(prefixIcon),
        suffixIcon: _buildIcon(suffixIcon, onTap: onSuffixIconTap),
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
              borderSide: BorderSide(color: Colors.grey, width: 1.sp),
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.sp),
            ),
        disabledBorder: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.sp),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1.sp),
            ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 14.sp),
      ),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }

  /// 构建图标（支持IconData或图片路径）
  Widget? _buildIcon(dynamic icon, {VoidCallback? onTap}) {
    if (icon == null) return null;

    // 如果传入的是 IconData 类型
    if (icon is IconData) {
      return Icon(icon, size: 20.sp);
    }

    // 如果传入的是 String 类型（图片路径）
    if (icon is String) {
      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8.sp), // 确保图片大小适配
          child: Image.asset(
            icon,
            width: 24.sp,
            height: 24.sp,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return null;
  }
}



///
/// 使用示例:
/// ```dart
/// BaseTextField(
///   controller: TextEditingController(),
///   hintText: '请输入用户名',
///   labelText: '用户名',
///   isPassword: false,
///   prefixIcon: Icons.person,
///   suffixIcon: Icons.clear,
///   onSuffixIconTap: () {
///     print('清除按钮被点击');
///   },
///   onChanged: (value) {
///     print('输入内容: $value');
///   },
///   onSubmitted: (value) {
///     print('提交内容: $value');
///   },
/// )
/// ```