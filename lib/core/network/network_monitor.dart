/// @file network_monitor.dart
/// @date 2024/12/19
/// @author zhuxianwen
/// @brief [网络状态监听]

import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../utils/eventManager.dart';

enum NetworkStatus {
  connectedWifi, // 连接到 Wi-Fi
  connectedMobile, // 连接到移动数据
  disconnected, // 无网络连接
}

class NetworkMonitor {
  static final NetworkMonitor _instance = NetworkMonitor._internal();

  factory NetworkMonitor() => _instance;

  NetworkStatus _currentStatus = NetworkStatus.disconnected;

  NetworkStatus get currentStatus => _currentStatus;

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  NetworkMonitor._internal();

  /// 初始化网络监听
  void initialize() {
    final connectivity = Connectivity();

    // 监听网络变化
    _connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateStatus);

    // 检查初始网络状态
    _checkInitialStatus();
  }

  /// 检查初始网络状态
  Future<void> _checkInitialStatus() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _updateStatus(connectivityResult);
  }

  /// 更新网络状态
  void _updateStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _currentStatus = NetworkStatus.connectedWifi;
        break;
      case ConnectivityResult.mobile:
        _currentStatus = NetworkStatus.connectedMobile;
        break;
      case ConnectivityResult.none:
      // 进一步验证网络连接状态
        final isConnected = await hasInternetConnection();
        _currentStatus = isConnected
            ? NetworkStatus.connectedMobile
            : NetworkStatus.disconnected;
        break;
      default:
        _currentStatus = NetworkStatus.disconnected;
        break;
    }

    // 发布网络状态事件
    EventManager.instance.publish('networkStatus', _currentStatus);
  }

  Future<bool> hasInternetConnection({Duration timeout = const Duration(seconds: 5)}) async {
    try {
      final result = await InternetAddress.lookup('baidu.com').timeout(timeout);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    }
    return false;
  }

  /// 订阅网络状态变化
  void subscribeToNetworkStatus(Function(NetworkStatus) onStatusChange) {
    EventManager.instance.subscribe(
      'networkStatus',
          (status) => onStatusChange(status as NetworkStatus),
    );
  }

  /// 销毁资源
  void dispose() {
    _connectivitySubscription.cancel();
    EventManager.instance.unsubscribe('networkStatus');
  }
}