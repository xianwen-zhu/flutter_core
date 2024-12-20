/// @file environment.dart
/// @date 2024/12/20
/// @author zhuxianwen
/// @brief [环境选择入口文件]

import 'env_preprod.dart' as preprod;
import 'env_prod.dart' as prod;

enum Environment { preprod, prod }

class EnvironmentConfig {
  static const Environment currentEnvironment = Environment.preprod; // 当前环境，可切换为 `Environment.prod`

  // 根据当前环境获取配置
  static Map<String, dynamic> get config {
    switch (currentEnvironment) {
      case Environment.prod:
        return prod.config;
      case Environment.preprod:
      default:
        return preprod.config;
    }
  }

  static String get baseUrl => config['baseUrl'];
  static bool get enableLogging => config['enableLogging'];
}
