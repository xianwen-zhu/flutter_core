import 'dart:async';

/// @file task_scheduler.dart
/// @date 2024/12/19
/// @author zhuxianwen
/// @brief [任务调度器类，支持定时任务、延迟任务和周期性任务]

class TaskScheduler {
  // 单例模式
  TaskScheduler._privateConstructor();
  static final TaskScheduler instance = TaskScheduler._privateConstructor();

  // 保存所有的定时任务
  final Map<String, Timer> _timers = {};

  /// 添加一个一次性任务
  /// [taskName] 任务名称
  /// [duration] 延迟时间
  /// [callback] 回调函数
  void addOneTimeTask(String taskName, Duration duration, Function callback) {
    // 如果任务已存在，先移除
    cancelTask(taskName);

    // 添加新任务
    final timer = Timer(duration, () {
      callback();
      _timers.remove(taskName); // 任务完成后移除
    });

    _timers[taskName] = timer;
  }

  /// 添加一个周期性任务
  /// [taskName] 任务名称
  /// [interval] 执行间隔时间
  /// [callback] 回调函数
  void addPeriodicTask(String taskName, Duration interval, Function callback) {
    // 如果任务已存在，先移除
    cancelTask(taskName);

    // 添加新任务
    final timer = Timer.periodic(interval, (timer) {
      callback();
    });

    _timers[taskName] = timer;
  }

  /// 取消任务
  /// [taskName] 任务名称
  void cancelTask(String taskName) {
    if (_timers.containsKey(taskName)) {
      _timers[taskName]?.cancel();
      _timers.remove(taskName);
    }
  }

  /// 取消所有任务
  void cancelAllTasks() {
    _timers.forEach((key, timer) {
      timer.cancel();
    });
    _timers.clear();
  }

  /// 检查任务是否存在
  /// [taskName] 任务名称
  bool hasTask(String taskName) {
    return _timers.containsKey(taskName);
  }

  /// 打印当前任务状态
  void printStatus() {
    print('Active Tasks: ${_timers.keys.toList()}');
  }

  /// 销毁所有任务资源
  void dispose() {
    cancelAllTasks();
  }
}

// // 示例使用
// void main() {
//   final scheduler = TaskScheduler.instance;
//
//   // 添加一个一次性任务
//   scheduler.addOneTimeTask('oneTimeTask', Duration(seconds: 5), () {
//     print('One-time task executed.');
//   });
//
//   // 添加一个周期性任务
//   scheduler.addPeriodicTask('periodicTask', Duration(seconds: 2), () {
//     print('Periodic task executed.');
//   });
//
//   // 打印当前任务状态
//   scheduler.printStatus();
//
//   // 延迟10秒后取消所有任务
//   Timer(Duration(seconds: 10), () {
//     scheduler.cancelAllTasks();
//     scheduler.printStatus();
//   });
// }
