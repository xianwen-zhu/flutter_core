import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/services/user_manager.dart'; // 引入 UserManager

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// 登录逻辑
  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      // 隐藏键盘
      Get.focusScope?.unfocus();

      final username = usernameController.text.trim();
      final password = passwordController.text.trim();

      // 显示 EasyLoading 的加载框
      EasyLoading.show(status: 'Logging in...');

      try {
        await ApiService.post(
          ApiEndpoints.login,
          data: {
            'phoneNumber': username,
            'password': password,
            'thirdPartyType': null,
          },
          requiresToken: false,
          onSuccess: (data) async {
            // 假设接口返回的结构中包含 token 信息
            final token = data['token'];

            // 隐藏加载框
            EasyLoading.dismiss();

            // 存储登录状态和 Token 信息
            await UserManager().setLoggedIn(true);
            await UserManager().setToken(token);

            // 显示成功提示
            EasyLoading.showSuccess('Login Successful! Welcome, $username!');

            // 跳转到主页
            Get.offAllNamed('/home'); // 替换为你的主页路由
          },
          onError: (error) {
            // 隐藏加载框
            EasyLoading.dismiss();

            // 显示错误提示
            EasyLoading.showError('Login Failed: $error');
          },
        );
      } catch (e) {
        // 隐藏加载框
        EasyLoading.dismiss();

        // 显示异常提示
        EasyLoading.showError('An unexpected error occurred!');
      }
    }
  }
}