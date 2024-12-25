/// @file eventManager.dart
/// @date 2024/12/19
/// @author zhuxianwen
/// @brief [管理全局订阅事件]
import 'dart:async';

class EventManager {
  // 单例模式
  EventManager._privateConstructor();
  static final EventManager instance = EventManager._privateConstructor();

  // 维护所有订阅的事件
  final Map<String, StreamSubscription> _subscriptions = {};
  final Map<String, StreamController> _eventControllers = {};

  /// 订阅事件
  void subscribe(String key, Function(dynamic) onData, {Function(dynamic)? onError}) {
    if (!_eventControllers.containsKey(key)) {
      _eventControllers[key] = StreamController.broadcast();
    }
    // 如果已存在同名的订阅，先取消
    _subscriptions[key]?.cancel();

    // 新增订阅
    final subscription = _eventControllers[key]!.stream.listen(
      onData,
      onError: onError ?? (error) => print('Error in stream $key: $error'),
    );

    _subscriptions[key] = subscription;
  }

  /// 发布事件
  void publish(String key, dynamic data) {
    if (_eventControllers.containsKey(key)) {
      _eventControllers[key]?.add(data);
    } else {
      print('No event controller found for key: $key');
    }
  }

  /// 取消单个订阅
  void unsubscribe(String key) {
    _subscriptions[key]?.cancel();
    _subscriptions.remove(key);
  }

  /// 取消所有订阅
  void unsubscribeAll() {
    _subscriptions.forEach((key, subscription) {
      subscription.cancel();
    });
    _subscriptions.clear();
  }

  /// 检查是否存在某个订阅
  bool isSubscribed(String key) {
    return _subscriptions.containsKey(key);
  }

  /// 销毁所有事件流
  void dispose() {
    _eventControllers.forEach((key, controller) {
      try {
        controller.close();
      } catch (e) {
        print('Error while disposing controller $key: $e');
      }
    });
    _eventControllers.clear();
  }

  /// 打印当前所有事件和订阅的状态
  void printStatus() {
    print('Active Subscriptions: ${_subscriptions.keys}');
    print('Active Event Controllers: ${_eventControllers.keys}');
  }
}

