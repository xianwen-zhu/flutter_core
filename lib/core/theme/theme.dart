/// @file theme.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [全局主题色]

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class AppTheme {
  // 通用字体
  static const String fontFamily = 'Roboto';

  // 边框样式
  static BorderRadius borderRadius = BorderRadius.all(Radius.circular(8.sp));
  static BorderSide borderSide = BorderSide(color: AppColors.textSecondary, width: 1.sp);

  // 亮色主题
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    fontFamily: fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      buttonColor: AppColors.primary,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      margin: EdgeInsets.all(8.sp),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    ),
  );

  // 暗色主题
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    fontFamily: fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.grey),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      buttonColor: AppColors.secondary,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      margin: EdgeInsets.all(8.sp),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    ),
  );
}