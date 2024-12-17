import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/base_app_bar_page.dart';
import '../../../../core/widgets/base_button.dart';
import '../controllers/profile_settings_controller.dart';

class ProfileSettingsView extends GetView<ProfileSettingsController> {
  const ProfileSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAppBarPage(
      title: 'Settings', // 页面标题
      showBackButton: true, // 显示返回按钮
      onBackPressed: () => Get.back(), // 自定义返回逻辑
      body: Column(
        children: [
          // 菜单项
          _buildMenuItem(
            icon: Icons.exit_to_app,
            title: 'Deactivate Account',
            onTap: () {
              // controller.signOUT();
            },
          ),
          const Divider(height: 1),
          _buildMenuItem(
            icon: Icons.info,
            title: 'About Us',
            onTap: () {
              // Get.toNamed(Routes.ABOUT_PAGE);
            },
          ),
          Divider(height: 1.sp),
          const Spacer(),
          // 登出按钮
          _buildLogoutButton(
            context: context,
            content: 'Are you sure you want to log out?',
          ),
          SizedBox(height: 40.0.sp),
        ],
      ),
    );
  }

  /// 构建菜单项
  Widget _buildMenuItem(
      {required IconData icon,
        required String title,
        required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: AppTextStyles.bodyPrimary,
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  /// 构建登出按钮
  Widget _buildLogoutButton({
    required BuildContext context,
    required String content,
  }) {
    return BaseButton(
      text: 'Logout',
      type: ButtonType.elevated, // 填充按钮
      backgroundColor: Colors.red,
      textColor: Colors.white,
      borderRadius: 24.0.sp, // 圆角
      height: 48.0.sp, // 按钮高度
      isLoading: false, // 非加载状态
      onPressed: () {
        controller.logout(context);
      },
    );
  }
}