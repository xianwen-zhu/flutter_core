import 'package:flutter/material.dart';
import 'package:flutter_core/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/network/network_monitor.dart';
import '../../../../core/services/route_manager.dart';
import '../../../../core/services/user_manager.dart';
import '../../../../core/utils/eventManager.dart';
import '../../../../core/utils/permissionManager.dart';
import '../../../routes/app_pages.dart';
import '../../main/views/main_view.dart';
import '../../maintenance/views/maintenance_view.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;


  var isNetworkConnected = true.obs; // 网络状态观察变量

  @override
  void onInit() {
    super.onInit();
    _subscribeToUnauthorized();
    _subscribeToNetworkStatus();
  }

  /// 订阅 401 错误事件
  void _subscribeToUnauthorized() {
    EventManager.instance.subscribe('sessionExpired', (data) {
      _showUnauthorizedDialog();
    });
  }

  /// 显示未授权提示框
  void _showUnauthorizedDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Session Expired'),
        content: Text('Your session has expired. Please log in again.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // 关闭弹窗
              _redirectToLogin();
            },
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false, // 禁止点击外部关闭
    );
  }

  /// 跳转到登录页
  void _redirectToLogin() {
    UserManager().clearUserData(); // 清除用户会话
    RouteManager.instance.navigateToAndClearStack(Routes.LOGIN); // 跳转到登录页
  }



  void _subscribeToNetworkStatus() {
    NetworkMonitor().subscribeToNetworkStatus((status) {
      if (status == NetworkStatus.disconnected) {
        isNetworkConnected.value = false; // 无网络连接
        _showNetworkErrorDialog();
      } else {
        isNetworkConnected.value = true; // 恢复网络连接
      }
    });
  }

  void _showNetworkErrorDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Network Error'),
        content: Text('No internet connection. Please check your network.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // 关闭弹窗
            },
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false, // 禁止点击外部关闭
    );
  }

  @override
  void onClose() {
    NetworkMonitor().dispose(); // 释放监听资源
    EventManager.instance.unsubscribeAll(); //取消所有的订阅事件
    super.onClose();
  }


  final List<Widget> widgetOptions = [
    // 页面内容示例
    MainView(),
    Center(child: Text('Assets')),
    MaintenanceView(),
    ProfileView()
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