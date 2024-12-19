import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/base_button.dart';
import 'package:flutter_core/core/widgets/base_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../controllers/login_controller.dart';
import '../../../../core/widgets/base_text_field.dart';
import 'package:url_launcher/url_launcher.dart';


class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());

  /// 跳转高德地图方法
  Future<void> launchAMap({
    required double longitude, // 经度
    required double latitude, // 纬度
    String? name, // 可选的地名
  }) async {
    // 高德地图的 URL Scheme 格式
    final String aMapUrl;

    if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      // iOS 平台的 URL Scheme
      aMapUrl =
      'iosamap://path?sourceApplication=yourAppName&dlat=$latitude&dlon=$longitude&dev=0&t=0${name != null ? '&dname=$name' : ''}';
    } else if (Theme.of(Get.context!).platform == TargetPlatform.android) {
      // Android 平台的 URL Scheme
      aMapUrl =
      'amapuri://route/plan/?sourceApplication=yourAppName&dlat=$latitude&dlon=$longitude&dev=0&t=0${name != null ? '&dname=$name' : ''}';
    } else {
      // 不支持的平台
      throw UnsupportedError('Unsupported platform');
    }

    // 检查高德地图是否安装
    if (await canLaunchUrl(Uri.parse(aMapUrl))) {
      // 打开高德地图
      await launchUrl(Uri.parse(aMapUrl), mode: LaunchMode.externalApplication);
    } else {
      // 如果未安装高德地图，则提供安装地址（App Store 或应用市场）
      if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
        final fallbackUrl =
            'https://apps.apple.com/cn/app/id461703208'; // 高德地图 iOS App Store 地址
        await launchUrl(Uri.parse(fallbackUrl), mode: LaunchMode.externalApplication);
      } else if (Theme.of(Get.context!).platform == TargetPlatform.android) {
        final fallbackUrl =
            'market://details?id=com.autonavi.minimap'; // 高德地图 Android 应用市场地址
        if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
          await launchUrl(Uri.parse(fallbackUrl), mode: LaunchMode.externalApplication);
        } else {
          debugPrint('Unable to open AMap or Play Store.');
        }
      } else {
        debugPrint('AMap is not supported on this platform.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus(); // 点击空白隐藏键盘
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Login',
            style: AppTextStyles.bodyLarge,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.sp),
              child: Form(
                key: controller.formKey, // 使用控制器中的表单 key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: AppTextStyles.subModuleTitle,
                    ),
                    SizedBox(height: 8.sp),
                    Text(
                      'Please sign in to continue',
                      style: AppTextStyles.bodyMedium,
                    ),
                    SizedBox(height: 32.sp),
                    // 使用BaseTextField代替TextFormField
                    BaseTextField(
                      controller: controller.usernameController,
                      labelText: 'Username',
                      prefixIcon:  Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        } else if (value.length < 4) {
                          return 'Username must be at least 4 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.sp),
                    BaseTextField(
                      controller: controller.passwordController,
                      labelText: 'Password',
                      isPassword:true,
                      prefixIcon: Icons.lock,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.sp),
                    SizedBox(
                      width: double.infinity,
                      child: BaseButton(
                        text: 'Sign In',
                        height: 48.sp,
                        borderRadius: 24.sp,
                        horizontalMargin: 10.sp,
                        onPressed: ()=>{
                          controller.login()
                        },
                      ),
                    ),
                    SizedBox(height: 16.sp),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          launchAMap(latitude:121.433207 ,longitude:31.290457 );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.hint,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}