import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/colors.dart';
import 'package:flutter_core/core/theme/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
             SizedBox(height: 16.0.sp),
            _buildMenuItem(
              icon: Icons.lock,
              title: 'Change Password',
              onTap: () {
                // Get.toNamed(Routes.PASSWORD_SETTING);
              },
            ),
            _buildMenuItem(
              icon: Icons.info,
              title: 'About Us',
              onTap: () {
                // Get.toNamed(Routes.ABOUT_PAGE);
              },
            ),
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Get.toNamed(Routes.PROFILE_SETTINGS);
              },
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: AppColors.primary,
      padding:  EdgeInsets.all(16.0.sp),
      child: Row(
        children: [
           CircleAvatar(
            radius: 35.sp,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 32.sp,
              backgroundImage: AssetImage('lib/app/images/default_store.png'),
            ),
          ),
           SizedBox(width: 16.0.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "--",
                style: AppTextStyles.bodySmall
              ),
               SizedBox(height: 4.0.sp),
              Text(
                "--",
                style: AppTextStyles.bodySmall,
              ),
               SizedBox(height: 4.0.sp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}