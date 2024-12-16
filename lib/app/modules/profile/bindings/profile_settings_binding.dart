import 'package:get/get.dart';

import '../controllers/profile_settings_controller.dart';

class ProfileSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSettingsController>(
      () => ProfileSettingsController(),
    );
  }
}
