import 'package:flutter/material.dart';
import 'package:flutter_core/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/network/network_monitor.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   HomeView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() {
        return Center(
          child: controller.widgetOptions.elementAt(controller.selectedIndex.value),
        );
      }),
      // 扫一扫按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.callScanner();
        },
        elevation: 0, // 去除阴影效果
        backgroundColor: Colors.transparent, // 设置为透明
        splashColor: Colors.transparent, // 去除点击时的水波纹效果
        highlightElevation: 0, // 去除点击后的高亮阴影
        child: Container(
          width: 56.0.sp, // 圆形的宽度和高度
          height: 56.0.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // 圆形背景
            color: AppColors.primary, // 背景颜色
          ),
          child: Icon(
            Icons.qr_code_scanner,
            color: Colors.white, // 图标颜色
            size: 32.0.sp, // 图标大小
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 自定义底部导航栏
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0.sp,
        elevation: 0,
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuItem(
              index: 0,
              icon: Icons.home,
              label: 'Home',
              selectedIndex: controller.selectedIndex.value,
              onTap: () => controller.onItemTapped(0),
            ),
            _buildMenuItem(
              index: 1,
              icon: Icons.layers,
              label: 'Assets',
              selectedIndex: controller.selectedIndex.value,
              onTap: () => controller.onItemTapped(1),
            ),
             SizedBox(width: 48.sp), // 中间留空给浮动按钮
            _buildMenuItem(
              index: 2,
              icon: Icons.build,
              label: 'Operations',
              selectedIndex: controller.selectedIndex.value,
              onTap: () => controller.onItemTapped(2),
            ),
            _buildMenuItem(
              index: 3,
              icon: Icons.person,
              label: 'Profile',
              selectedIndex: controller.selectedIndex.value,
              onTap: () => controller.onItemTapped(3),
            ),
          ],
        )),
      ),
    );
  }

  /// 构建底部菜单项
  Widget _buildMenuItem({
    required int index,
    required IconData icon,
    required String label,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}