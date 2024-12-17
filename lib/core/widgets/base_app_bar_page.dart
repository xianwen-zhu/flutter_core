/// @file base_app_bar_page.dart
/// @date 2024/12/16
/// @author zhuxianwen
/// @brief [基础Page类]
/// 功能说明:
/// 1. 提供通用的导航栏功能（可自定义标题、右侧按钮、返回逻辑、背景色等）
/// 2. 支持显示/隐藏导航栏
/// 3. 支持加载状态展示（isLoading）
/// 4. 支持错误提示展示（errorMessage）
/// 5. 支持可选底部区域（footer）

import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/colors.dart';
import 'package:flutter_core/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseAppBarPage extends StatelessWidget {
  /// 页面标题
  final String title;

  /// 页面主体
  final Widget body;

  /// 右侧按钮
  final List<Widget>? actions;

  /// 是否显示返回按钮
  final bool showBackButton;

  /// 自定义返回按钮逻辑
  final VoidCallback? onBackPressed;

  /// 自定义导航栏背景颜色
  final Color? appBarBackgroundColor;

  /// 自定义底部区域（可选）
  final Widget? footer;

  /// 加载状态
  final bool isLoading;

  /// 错误消息（如果有错误显示此消息）
  final String? errorMessage;

  /// 错误处理逻辑
  final VoidCallback? onRetry;

  /// 是否隐藏导航栏
  final bool hideAppBar;

  const BaseAppBarPage({
    Key? key,
    required this.title,
    required this.body,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.appBarBackgroundColor,
    this.footer,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.hideAppBar = false, // 默认不隐藏导航栏
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hideAppBar
          ? null // 如果隐藏导航栏，则返回 null
          : AppBar(
        automaticallyImplyLeading: showBackButton,
        title: Text(
          title,
          style: AppTextStyles.appBarTitle,
        ),
        centerTitle: true,
        actions: actions,
        backgroundColor: appBarBackgroundColor ?? AppColors.primary,
        leading: showBackButton
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        )
            : null,
      ),
      body: Stack(
        children: [
          if (errorMessage == null && !isLoading) ...[
            body, // 正常内容
          ],
          if (isLoading) ...[
            _buildLoadingWidget(), // 加载状态
          ],
          if (errorMessage != null) ...[
            _buildErrorWidget(), // 错误状态
          ],
        ],
      ),
      bottomNavigationBar: footer,
    );
  }

  /// 加载状态组件
  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// 错误状态组件
  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage ?? 'Something went wrong.',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.sp),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}