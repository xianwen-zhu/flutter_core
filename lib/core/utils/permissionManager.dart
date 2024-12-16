import 'package:permission_handler/permission_handler.dart';

/// @file permissionManager.dart
/// @date 2024/12/16
/// @author zhuxianwen
/// @brief [权限请求管理]


class PermissionManager {
  /// 检查并请求单个权限
  /// [permission] 权限类型，例如 Permission.camera
  /// [onDenied] 权限被拒绝时的回调
  /// [onPermanentlyDenied] 权限被永久拒绝时的回调
  static Future<bool> requestPermission({
    required Permission permission,
    Function? onDenied,
    Function? onPermanentlyDenied,
  }) async {
    // 检查当前权限状态
    final status = await permission.status;

    if (status.isGranted) {
      _logPermission(permission, "Permission already granted");
      return true;
    }

    // 请求权限
    final result = await permission.request();

    if (result.isGranted) {
      _logPermission(permission, "Permission granted after request");
      return true;
    } else if (result.isDenied) {
      _logPermission(permission, "Permission denied");
      onDenied?.call();
      return false;
    } else if (result.isPermanentlyDenied) {
      _logPermission(permission, "Permission permanently denied");
      onPermanentlyDenied?.call();
      _redirectToAppSettings();
      return false;
    }

    return false;
  }

  /// 检查并请求多个权限
  /// 返回一个 Map，标识每个权限是否被授予
  static Future<Map<Permission, bool>> requestMultiplePermissions({
    required List<Permission> permissions,
    Function? onAnyDenied,
    Function? onAnyPermanentlyDenied,
  }) async {
    final results = await permissions.request();

    bool hasDenied = false;
    bool hasPermanentlyDenied = false;

    results.forEach((permission, status) {
      if (status.isDenied) {
        hasDenied = true;
      } else if (status.isPermanentlyDenied) {
        hasPermanentlyDenied = true;
      }
    });

    if (hasDenied) {
      onAnyDenied?.call();
    }

    if (hasPermanentlyDenied) {
      onAnyPermanentlyDenied?.call();
      _redirectToAppSettings();
    }

    return results.map((permission, status) => MapEntry(permission, status.isGranted));
  }

  /// 打开系统设置
  static Future<void> _redirectToAppSettings() async {
    final opened = await openAppSettings();
    if (!opened) {
      print("Failed to open app settings");
    }
  }

  /// 打印权限状态日志（便于调试）
  static void _logPermission(Permission permission, String message) {
    print("[PermissionManager] ${permission.value}: $message");
  }
}