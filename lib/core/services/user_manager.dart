import '../utils/storage.dart';

/// @file user_manager.dart
/// @brief UserManager: A singleton class for managing and storing user information persistently.
/// @date 2024/12/12
/// @author zhuxianwen


class UserManager {
  // 单例实例
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;

  // 私有构造函数
  UserManager._internal();

  // 用户信息字段
  bool _isLoggedIn = false;
  String? _token;
  String? _username;

  /// 获取是否登录（从内存或持久化存储）
  Future<bool> get isLoggedIn async {
    _isLoggedIn = await Storage.getBool('is_logged_in') ?? false;
    return _isLoggedIn;
  }

  /// 设置登录状态并持久化
  Future<void> setLoggedIn(bool value) async {
    _isLoggedIn = value;
    await Storage.saveBool('is_logged_in', value);
  }

  /// 获取当前 Token
  Future<String?> get token async {
    _token = await Storage.getString('user_token');
    return _token;
  }

  /// 设置 Token 并持久化
  Future<void> setToken(String? token) async {
    _token = token;
    if (token != null) {
      await Storage.saveString('user_token', token);
    } else {
      await Storage.remove('user_token');
    }
  }

  /// 获取用户名
  Future<String?> get username async {
    _username = await Storage.getString('username');
    return _username;
  }

  /// 设置用户名并持久化
  Future<void> setUsername(String? name) async {
    _username = name;
    if (name != null) {
      await Storage.saveString('username', name);
    } else {
      await Storage.remove('username');
    }
  }

  /// 清除所有用户数据
  Future<void> clearUserData() async {
    _isLoggedIn = false;
    _token = null;
    _username = null;
    await Storage.clear(); // 清空所有存储数据
  }
}
