import 'package:get/get.dart';

import '../controllers/assets_controller.dart';

class AssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsController>(
      () => AssetsController(),
    );
  }
}
