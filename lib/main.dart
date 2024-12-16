import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/modules/login/views/login_view.dart';
import 'app/routes/app_pages.dart';
import 'core/initializer/app_initializer.dart';
import 'app/modules/home/views/home_view.dart';
import 'core/services/user_manager.dart';
import 'core/theme/theme.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await AppInitializer.initialize(); // 初始化应用

  // 检查用户登录状态
  final isLoggedIn = await UserManager().isLoggedIn;

  // 设置初始路由
  runApp(MyApp(initialRoute: isLoggedIn ? Routes.HOME : Routes.LOGIN));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true, // 适配最小字体
      splitScreenMode: true, // 支持多窗口
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ops App',
          theme: AppTheme.lightTheme,
          builder: EasyLoading.init(), // 初始化 EasyLoading
          initialRoute: initialRoute, // 动态设置初始路由
          getPages: AppPages.routes
        );
      },
    );
  }
}