import 'package:flutter_core/app/modules/main/controllers/main_controller.dart';
import 'package:flutter_core/app/modules/maintenance/controllers/maintenance_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MainController>(
          () => MainController(),
    );

    Get.lazyPut<MaintenanceController>(
          () => MaintenanceController(),
    );
  }
}
