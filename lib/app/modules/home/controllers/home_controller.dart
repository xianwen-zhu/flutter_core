import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/permissionManager.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> widgetOptions = [
    // 页面内容示例
    Center(child: Text('Home')),
    Center(child: Text('Assets')),
    Center(child: Text('Operations')),
    Center(child: Text('Profile')),
  ];

  /// 切换页面方法
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  /// 检查相机权限并调用扫一扫功能
  Future<void> callScanner() async {
    // 使用 PermissionManager 检查和请求相机权限
    bool isPermissionGranted = await PermissionManager.requestPermission(
      permission: Permission.camera,
      onDenied: () {
        // 权限被拒绝时的逻辑
        Get.snackbar(
          "Permission Denied",
          "Camera permission is required to use the scanner.",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onPermanentlyDenied: () {
        // 权限被永久拒绝时的逻辑
        Get.snackbar(
          "Permission Permanently Denied",
          "Please enable camera permission in system settings.",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );

    if (isPermissionGranted) {
      // 执行扫一扫功能
      _startScanner();
    }
  }

  /// 执行扫一扫功能
  void _startScanner() {
    // 这里添加扫一扫页面的逻辑，例如跳转到扫描页面
    print("Camera permission granted. Starting scanner...");
    Get.snackbar(
      "Scanner",
      "Scanner functionality started!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}