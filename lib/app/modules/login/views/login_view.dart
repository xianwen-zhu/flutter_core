import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/base_button.dart';
import 'package:flutter_core/core/widgets/base_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../controllers/login_controller.dart';
import '../../../../core/widgets/base_text_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());

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
            style: AppTextStyles.bodyPrimary,
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
                      style: AppTextStyles.bodyPrimary,
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