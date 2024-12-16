/// @file api_endpoints.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [接口地址管理]


class ApiEndpoints {
  static const String login = '/auth/token';
  static const String register = '/auth/register';
  static const String getUserProfile = '/user/profile';
  static const String updateUserProfile = '/user/update';
  static const String uploadFile = '/file/upload';
  static const String downloadFile = '/file/download';
}