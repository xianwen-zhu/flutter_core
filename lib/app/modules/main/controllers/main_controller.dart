import 'package:get/get.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';

class MainController extends GetxController {
  // 日志数据状态
  late RxMap<String, int> swapLogData;
  late RxMap<String, int> registerLogData;
  late RxMap<String, int> leaseLogData;

  // 加载状态
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化日志数据
    swapLogData = _initLogData();
    registerLogData = _initLogData();
    leaseLogData = _initLogData();

    // 获取所有日志数据
    fetchLogs();
  }

  /// 初始化日志数据
  RxMap<String, int> _initLogData() {
    return <String, int>{
      'successLog': 0,
      'failedLog': 0,
      'faultLog': 0,
      'alertLog': 0,
    }.obs;
  }

  /// 获取所有日志数据
  Future<void> fetchLogs() async {
    _setLoadingState(true);
    try {
      final requests = [
        {'path': ApiEndpoints.getLogs, 'query': {'action': '5'}, 'target': swapLogData},
        {'path': ApiEndpoints.getLogs, 'query': {'action': '12,13'}, 'target': registerLogData},
        {'path': ApiEndpoints.getLogs, 'query': {'action': '8,9'}, 'target': leaseLogData},
        {'path': ApiEndpoints.getFaultLogs, 'query': {'optionType': '5'}, 'target': swapLogData, 'key': 'faultLog'},
        {'path': ApiEndpoints.getFaultLogs, 'query': {'optionType': '12,13'}, 'target': registerLogData, 'key': 'faultLog'},
        {'path': ApiEndpoints.getFaultLogs, 'query': {'optionType': '8,9'}, 'target': leaseLogData, 'key': 'faultLog'},
      ];

      for (final request in requests) {
        final data = await _apiRequest(request['path'] as String, request['query'] as Map<String, dynamic>);
        _updateLogData(
          request['target'] as RxMap<String, int>,
          data,
          key: request['key'] as String?,
        );
      }
    } catch (e) {
      print("Error fetching logs: $e");
    } finally {
      _setLoadingState(false);
    }
  }

  /// 统一 API 请求方法
  Future<Map<String, dynamic>> _apiRequest(String path, Map<String, dynamic> queryParams) async {
    late Map<String, dynamic> responseData;
    await ApiService().get(
      path,
      queryParameters: queryParams,
      requiresToken: true,
      onSuccess: (data) {
        responseData = data;
      },
      onError: (error) {
        throw Exception("API request failed: $error");
      },
    );
    return responseData;
  }

  /// 转换日志数据并更新状态
  void _updateLogData(RxMap<String, int> logData, Map<String, dynamic> data, {String? key}) {
    if (key != null) {
      logData[key] = data[key.toUpperCase()]?['count'] ?? 0;
    } else {
      logData.value = {
        'successLog': data['TODAY_HANDLE_SUCCESS']?['count'] ?? 0,
        'failedLog': data['TODAY_HANDLE_FAIL']?['count'] ?? 0,
        'faultLog': data['FAULT_LOG']?['count'] ?? 0,
        'alertLog': data['WARNING_LOG']?['count'] ?? 0,
      };
    }

  }

  /// 设置加载状态
  void _setLoadingState(bool state) {
    isLoading.value = state;
  }
}