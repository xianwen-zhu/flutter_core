/// @file common_list_page.dart
/// @date 2024/12/24
/// @brief [通用列表页面，支持下拉刷新、上拉加载、搜索与日期范围选择功能]

import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/base_app_bar_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonListPage<T> extends StatefulWidget {
  /// 页面标题
  final String title;

  /// 是否显示搜索框
  final bool showSearchBar;

  /// 是否显示日期选择按钮
  final bool showDatePicker;

  /// 数据加载方法
  final Future<List<Map<String, dynamic>>> Function()? onLoadData;

  /// 下拉刷新回调
  final Future<List<Map<String, dynamic>>> Function()? onRefresh;

  /// 上拉加载回调
  final Future<List<Map<String, dynamic>>> Function()? onLoadMore;

  /// 搜索回调
  final void Function(String value)? onSearch;

  /// 日期范围选择回调
  final void Function(DateTime? startDate, DateTime? endDate)? onDateRangeSelected;

  /// 列表项构建器
  final Widget Function(BuildContext context, Map<String, dynamic> item, int index) itemBuilder;

  /// 初始化数据
  final List<T> initialData;

  const CommonListPage({
    Key? key,
    required this.title,
    required this.itemBuilder,
    this.initialData = const [],
    this.showSearchBar = false,
    this.showDatePicker = false,
    this.onLoadData,
    this.onRefresh,
    this.onLoadMore,
    this.onSearch,
    this.onDateRangeSelected,
  }) : super(key: key);

  @override
  _CommonListPageState<T> createState() => _CommonListPageState<T>();
}

class _CommonListPageState<T> extends State<CommonListPage<T>> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  /// 数据列表
  final RxList<Map<String, dynamic>> _dataList = <Map<String, dynamic>>[].obs;

  /// 是否加载中
  final RxBool _isLoading = false.obs;

  /// 是否还有更多数据
  final RxBool _hasMore = true.obs;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  /// 加载初始数据
  Future<void> _loadInitialData() async {
    _isLoading.value = true;
    if (widget.onLoadData != null) {
      var newData = await widget.onLoadData!();
      if (newData is List<Map<String, dynamic>>) {
        _dataList.assignAll(newData);
        _hasMore.value = newData.isNotEmpty;
      } else {
        print('Error: onLoadData returned data of the wrong type.');
      }
      _hasMore.value = newData.isNotEmpty;
    }
    _isLoading.value = false;
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    if (widget.onRefresh != null) {
      var newData = await widget.onLoadData!();
      if (newData is List<Map<String, dynamic>>) {
        _dataList.assignAll(newData);
        _hasMore.value = newData.isNotEmpty;
      } else {
        print('Error: onLoadData returned data of the wrong type.');
      }
      _hasMore.value = newData.isNotEmpty;
    }
    _refreshController.refreshCompleted();
  }

  /// 上拉加载更多
  Future<void> _onLoading() async {
    if (!_hasMore.value || widget.onLoadMore == null) {
      _refreshController.loadComplete();
      return;
    }
    var newData = await widget.onLoadMore!();
    if (newData is List<Map<String, dynamic>>) {
      _dataList.addAll(newData);
      if (newData.length < 10) {
        _hasMore.value = false;
      }
    } else {
      print('Error: onLoadData returned data of the wrong type.');
    }
    if (newData.isEmpty) {
      _hasMore.value = false;
    }
    _refreshController.loadComplete();
  }

  /// 日期范围选择器
  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _startDate = picked.start;
      _endDate = picked.end;
      if (widget.onDateRangeSelected != null) {
        widget.onDateRangeSelected!(_startDate, _endDate);
      }
    }
  }

  /// 搜索逻辑
  void _onSearch(String value) {
    if (widget.onSearch != null) {
      widget.onSearch!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BaseAppBarPage(
        title: widget.title,
        actions: [
          if (widget.showDatePicker)
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: _pickDateRange,
            ),
        ],
        body: Column(
          children: [
            if (widget.showSearchBar)
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4.sp,
                        offset: Offset(0, 2.sp),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here...",
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.sp),
                    ),
                    onChanged: _onSearch,
                  ),
                ),
              ),
            Expanded(
              child: Obx(() {
                if (_isLoading.value && _dataList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: _hasMore.value,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: _dataList.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/assets/images/no-data.png',
                          width: 150.sp,
                          height: 150.sp,
                        ),
                        SizedBox(height: 16.sp),
                        Text(
                          "No data available",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: _dataList.length,
                    itemBuilder: (context, index) {
                      return widget.itemBuilder(context, _dataList[index], index);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}