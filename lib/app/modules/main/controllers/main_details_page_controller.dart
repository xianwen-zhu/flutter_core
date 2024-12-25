import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../core/network/api_service.dart';

class MainDetailsPageController extends GetxController {

  // 当前页面的数据 (点击页面后展示的具体数据)
  var logData = <Map<String, dynamic>>[].obs;

  // 当前模块 (Swap, Storage, Rental)
  late final String module;
  late final String label;
  // 当前时间范围
  late DateTime startDate;
  late DateTime endDate;

  var currentPage = 1.obs; // 当前页码



  @override
  void onInit() {
    super.onInit();
    // 初始化模块和时间参数
    module = Get.arguments['module'] ?? 'Swap';
    label = Get.arguments?['label'] ?? 'Unknown'; // 获取标签信息
    startDate = DateTime.now();
    endDate = DateTime.now();
    fetchLogs();
  }

  /// 获取日志数据
  Future<List<Map<String, dynamic>>> fetchLogs() async {
    try {
      currentPage.value = 1; // 重置页码
      List<Map<String, dynamic>> fetchedLogs = []; // 存储返回的日志数据

      // 根据标签调用对应的接口
      switch (label.toLowerCase()) {
        case 'success':
          fetchedLogs = await _fetchLogData('success', currentPage.value);
          logData.value = fetchedLogs; // 更新本地的 logData
          break;
        case 'failed':
          fetchedLogs = await _fetchLogData('failed', currentPage.value);
          logData.value = fetchedLogs;
          break;
        case 'fault':
          fetchedLogs = await _fetchLogData('fault', currentPage.value);
          logData.value = fetchedLogs;
          break;
        case 'warning':
          fetchedLogs = await _fetchLogData('warning', currentPage.value);
          logData.value = fetchedLogs;
          break;
        default:
          print('Unknown label: $label');
          return []; // 返回空数据
      }

      return fetchedLogs; // 返回获取到的日志数据
    } catch (e) {
      EasyLoading.showError('Error fetching logs for $label: $e');
      print('Error fetching logs for $label: $e');
      return []; // 如果出现异常，返回空列表
    } finally {

    }
  }

  /// 根据状态类型获取日志数据

  Future<List<Map<String, dynamic>>> _fetchLogData(String statusType, int page) async {
    String path = '';
    Map<String, dynamic> queryParams = {
      'limit': 10, // 每页记录数
      'page': page, // 当前页码
      'startTime': '${startDate.toIso8601String().split('T').first} 00:00:00',
      'endTime': '${endDate.toIso8601String().split('T').first} 23:59:59',
    };

    switch (statusType) {
      case 'success':
        path = '/api-ebike/v3.1/cabinet-tasks/list';
        queryParams.addAll({
          'action': _getAction(module),
          'status': 3,
        });
        break;
      case 'failed':
        path = '/api-ebike/v3.1/cabinet-tasks/list';
        queryParams.addAll({
          'action': _getAction(module),
          'status': 4,
          'filterWarning': 0,
        });
        break;
      case 'fault':
        path = '/api-ebike/cabinetLog/queryFaultCabinetTaskLogs';
        queryParams.addAll({
          'optionType': _getOptionType(module),
        });
        break;
      case 'warning':
        path = '/api-ebike/cabinetLog/queryShopStatisticDtoList';
        queryParams.addAll({
          'optionType': _getOptionType(module),
          'businessType': 3,
          'optionStatus': 2,
        });
        break;
    }

    // 调用 API 并返回数据
    return await _apiRequest(path, queryParams);
  }

  /// 根据模块获取 action 参数
  String _getAction(String module) {
    switch (module) {
      case 'Swap':
        return '5';
      case 'Storage':
        return '12,13';
      case 'Rental':
        return '8,9';
      default:
        return '5';
    }
  }

  /// 根据模块获取 optionType 参数
  String _getOptionType(String module) {
    switch (module) {
      case 'Swap':
        return '5';
      case 'Storage':
        return '12,13';
      case 'Rental':
        return '8,9';
      default:
        return '5';
    }
  }

  /// 加载更多数据
  Future<List<Map<String, dynamic>>> loadMoreData() async {
    try {
      // 获取新数据
      List<Map<String, dynamic>> newLogs = [];

      // 根据标签加载对应的数据
      switch (label.toLowerCase()) {
        case 'success':
          newLogs = await _fetchLogData('success', currentPage.value + 1); // 尝试加载下一页
          break;
        case 'failed':
          newLogs = await _fetchLogData('failed', currentPage.value + 1);
          break;
        case 'fault':
          newLogs = await _fetchLogData('fault', currentPage.value + 1);
          break;
        case 'warning':
          newLogs = await _fetchLogData('warning', currentPage.value + 1);
          break;
        default:
          print('Unknown label: $label');
          return []; // 返回空数据表示未知标签
      }
      if (newLogs.isNotEmpty) {
        logData.addAll(newLogs); // 将新数据追加到已有数据中
        currentPage.value++; // 增加当前页码
      }

      return newLogs;
    } catch (e) {
      print('Error loading more data for $label: $e');
      return []; // 异常时返回空数据
    } finally {

    }
  }


  /// API 请求方法
  Future<List<Map<String, dynamic>>> _apiRequest(String path, Map<String, dynamic> queryParams) async {
    late List<Map<String, dynamic>> responseData = [];
    await ApiService().get(
      path,
      queryParameters: queryParams,
      requiresToken: true,
        onSuccess: (data) {
          if (data is Map<String, dynamic> && data.containsKey('list')) {
            responseData = List<Map<String, dynamic>>.from(data['list']);
          } else {
            responseData = [];
          }
        },
      onError: (error) {
        print('API request failed: $error');
      },
    );
    return responseData;
  }

  /// 日期范围选择回调
  void onDateRangeSelected(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    //fetchLogs(); // 更新数据
  }
}