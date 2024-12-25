import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_core/core/widgets/common_list_page.dart';

import '../../../../core/widgets/CustomOrderCard.dart';
import '../controllers/main_details_page_controller.dart';

class MainDetailsPageView extends GetView<MainDetailsPageController> {
  const MainDetailsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = '${Get.arguments?['module'] ?? 'Module'} - ${Get.arguments?['label'] ?? 'Label'}';
    final MainDetailsPageController controller = Get.put(MainDetailsPageController());

    return CommonListPage<String>(
      title: title,
      showDatePicker: true,
      onLoadData: () => controller.fetchLogs(),
      onRefresh: () => controller.fetchLogs(),
      onLoadMore: () => controller.loadMoreData(),
      itemBuilder: (context, item, index) {
        return CustomOrderCard(data: item);
      },
    );
  }
}