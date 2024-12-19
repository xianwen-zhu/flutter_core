/// @file dateUtils.dart
/// @date 2024/12/19
/// @author zhuxianwen
/// @brief [日期获取工具类]


import 'package:intl/intl.dart';

class DateUtils {
  /// 获取当前日期，默认格式为 'yyyy-MM-dd'
  static String getCurrentDate({String format = 'yyyy-MM-dd'}) {
    final now = DateTime.now();
    return _formatDate(now, format);
  }

  /// 获取前一天的日期，默认格式为 'yyyy-MM-dd'
  static String getPreviousDate({String format = 'yyyy-MM-dd'}) {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return _formatDate(yesterday, format);
  }

  /// 获取指定天数前的日期，默认格式为 'yyyy-MM-dd'
  static String getDateDaysAgo(int daysAgo, {String format = 'yyyy-MM-dd'}) {
    final targetDate = DateTime.now().subtract(Duration(days: daysAgo));
    return _formatDate(targetDate, format);
  }

  /// 获取指定天数后的日期，默认格式为 'yyyy-MM-dd'
  static String getDateDaysFromNow(int days, {String format = 'yyyy-MM-dd'}) {
    final targetDate = DateTime.now().add(Duration(days: days));
    return _formatDate(targetDate, format);
  }

  /// 获取当天的开始时间，返回 DateTime 对象
  static DateTime getStartOfDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// 获取当天的结束时间，返回 DateTime 对象
  static DateTime getEndOfDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
  }

  /// 获取本周的起始和结束日期范围
  /// 返回 Map，包含 'start' 和 'end' 两个键，对应的值为 DateTime 对象
  static Map<String, DateTime> getCurrentWeekRange() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
    return {
      'start': DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      'end': DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59, 999),
    };
  }

  /// 获取本月的起始和结束日期范围
  /// 返回 Map，包含 'start' 和 'end' 两个键，对应的值为 DateTime 对象
  static Map<String, DateTime> getCurrentMonthRange() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59, 999);
    return {
      'start': startOfMonth,
      'end': endOfMonth,
    };
  }

  /// 格式化指定的 DateTime 对象为字符串，默认格式为 'yyyy-MM-dd'
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return _formatDate(date, format);
  }

  /// 将日期字符串解析为 DateTime 对象，默认格式为 'yyyy-MM-dd'
  static DateTime parseDate(String dateString, {String format = 'yyyy-MM-dd'}) {
    final formatter = DateFormat(format);
    return formatter.parse(dateString);
  }

  /// 私有辅助方法，用于格式化 DateTime 对象
  static String _formatDate(DateTime date, String format) {
    final formatter = DateFormat(format);
    return formatter.format(date);
  }
}