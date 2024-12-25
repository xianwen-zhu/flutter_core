import 'package:flutter/material.dart';
import 'package:flutter_core/app/routes/app_pages.dart';
import 'package:flutter_core/core/services/route_manager.dart';
import 'package:flutter_core/core/theme/colors.dart';
import 'package:flutter_core/core/widgets/base_app_bar_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart'; // 引入 SmartRefresh 库

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  MainView({Key? key}) : super(key: key);

  /// 刷新控制器
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BaseAppBarPage(
      title: '',
      showBackButton: false,
      body: DefaultTabController(
        length: 3, // Tab 数量
        child: Column(
          children: [
            // 顶部 TabBar
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.black,
                indicatorColor: AppColors.primary,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(text: 'Logs'),
                  Tab(text: 'Orders'),
                  Tab(text: 'Dynamics'),
                ],
              ),
            ),
            // Tab 内容区域
            Expanded(
              child: TabBarView(
                children: [
                  _buildLogsTab(), // Logs 页面
                  _buildEmptyTab('Orders'), // 其他两个 Tab 内容
                  _buildEmptyTab('Dynamics'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建 Logs 页面内容
  Widget _buildLogsTab() {
    return Obx(() {
      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        header: const WaterDropHeader(),
        // 下拉刷新样式
        child: ListView(
          padding: EdgeInsets.all(16.sp),
          children: [
            _buildCard('Swap', controller.swapLogData),
            SizedBox(height: 12.sp),
            _buildCard('Storage', controller.registerLogData),
            SizedBox(height: 12.sp),
            _buildCard('Rental', controller.leaseLogData),
          ],
        ),
      );
    });
  }

  /// 刷新回调方法
  void _onRefresh() async {
    await controller.fetchLogs();
    _refreshController.refreshCompleted(); // 结束刷新
    debugPrint('Logs Tab Refreshed');
  }

  /// 构建单个卡片
  Widget _buildCard(String title, Map<String, int> logData) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 卡片标题
            Row(
              children: [
                Container(
                  height: 16.sp,
                  width: 4.sp,
                  color: Colors.blue,
                  margin: EdgeInsets.only(right: 8.sp),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.sp),
            // 卡片内容
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItem('Success', logData['successLog'], title),
                _buildItem('Failed', logData['failedLog'], title),
                _buildItem('Fault', logData['faultLog'], title),
                _buildItem('Warning', logData['alertLog'], title),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建日志数据项
  Widget _buildItem(String label, int? value, String module) {
    return GestureDetector(
      onTap: () {
        // 跳转到详情页面
        RouteManager.instance.navigateTo(Routes.MAIN_DETAILS_PAGE, arguments: {
          'module': module,
          'label': label,
          'value': value ?? 0,
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 8.sp), // 增加点击区域的内边距
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp), // 增加可视的点击区域样式
          color: Colors.transparent, // 透明背景，不影响视觉
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4.sp),
            Text(
              value == null || value == 0 ? '--' : value.toString(),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 其他 Tab 的空页面
  Widget _buildEmptyTab(String title) {
    return Center(
      child: Text(
        '$title Page',
        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
      ),
    );
  }
}
