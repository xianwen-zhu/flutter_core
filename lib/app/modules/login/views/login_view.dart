import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../controllers/login_controller.dart';

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
                    _buildTextField(
                      controller: controller.usernameController,
                      label: 'Username',
                      prefixIcon: const Icon(Icons.person),
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
                    _buildTextField(
                      controller: controller.passwordController,
                      label: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: true,
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 14.sp),
                          textStyle: AppTextStyles.button,
                        ),
                        onPressed: controller.login, // 调用控制器中的登录逻辑
                        child: const Text('Sign In'),
                      ),
                    ),
                    SizedBox(height: 16.sp),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.snackbar('Notice', 'Forgot Password Clicked');
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    Icon? prefixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.placeholder,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => controller.clear(),
              )
            : null,
      ),
      style: AppTextStyles.input,
      validator: validator,
    );
  }
}
