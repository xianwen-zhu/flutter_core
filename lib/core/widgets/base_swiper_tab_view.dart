/// @file base_swiper_tab_view.dart
/// @date 2024/12/18
/// @author zhuxianwen
/// @brief [Description]
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseSwiperTabView extends StatelessWidget {
  /// Tab 列表
  final List<String> tabs;

  /// 每个 Tab 下的内容（与 tabs 一一对应）
  final List<Widget> pages;

  /// 高度
  final double height;

  /// 是否自动滚动
  final bool autoplay;

  /// 切换动画类型
  final SwiperLayout layout;

  const BaseSwiperTabView({
    Key? key,
    required this.tabs,
    required this.pages,
    this.height = 200.0,
    this.autoplay = false,
    this.layout = SwiperLayout.DEFAULT,
  })  : assert(tabs.length == pages.length, 'Tabs and Pages must have the same length'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height.sp,
          child: Swiper(
            itemCount: tabs.length,
            autoplay: autoplay,
            layout: layout,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
            onIndexChanged: (int index) {
              debugPrint('Current tab: $index');
            },
            pagination: const SwiperPagination(), // 分页指示器
          ),
        ),
        Expanded(
          child: PageView(
            children: pages,
          ),
        ),
      ],
    );
  }
}