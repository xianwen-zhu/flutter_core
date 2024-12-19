/// @file api_endpoints.dart
/// @date 2024/12/12
/// @author zhuxianwen
/// @brief [接口地址管理]


class ApiEndpoints {
  static const String login = '/auth/token';
  static const String getLogs = '/api-ebike/v3.1/cabinet-tasks/queryCabinetTaskStatisticDtoMap';
  static const String getFaultLogs = '/api-ebike/cabinetLog/queryFaultCabinetTaskLogsCount';
}