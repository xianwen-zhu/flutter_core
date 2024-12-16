import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/colors.dart';
import 'package:flutter_core/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/profile_settings_controller.dart';

class ProfileSettingsView extends GetView<ProfileSettingsController> {
  const ProfileSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTextStyles.appBarTitle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
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
          _buildLogoutButton(context: context,
            content: 'Are you sure you want to log out?',),
           SizedBox(height: 40.0.sp),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(
      {required BuildContext context, required String content}) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
               EdgeInsets.symmetric(horizontal: 100.0.sp, vertical: 12.0.sp),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0.sp),
          ),
        ),
        onPressed: () {
          controller.logout(context);
        },
        child: const Text('Logout', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
