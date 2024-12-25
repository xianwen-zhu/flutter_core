import 'package:get/get.dart';

import '../controllers/main_details_page_controller.dart';


class MainDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainDetailsPageController>(
      () => MainDetailsPageController(),
    );
  }
}
