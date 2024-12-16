import 'package:get/get.dart';

import '../controllers/maintenance_controller.dart';

class MaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceController>(
      () => MaintenanceController(),
    );
  }
}
