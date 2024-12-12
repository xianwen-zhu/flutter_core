/// @file theme.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [全局主题色]

import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  // 通用字体
  static const String fontFamily = 'Roboto';

  // 边框样式
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
  static const BorderSide borderSide = BorderSide(color: AppColors.textSecondary, width: 1);

  // 亮色主题
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: fontFamily,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      buttonColor: AppColors.primary,
    ),
    cardTheme: const CardTheme(
      elevation: 2,
      margin: EdgeInsets.all(8),
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
    fontFamily: fontFamily,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      buttonColor: AppColors.secondary,
    ),
    cardTheme: const CardTheme(
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    ),
  );
}