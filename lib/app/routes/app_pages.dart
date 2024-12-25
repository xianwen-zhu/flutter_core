import 'package:get/get.dart';

import '../modules/assets/bindings/assets_binding.dart';
import '../modules/assets/views/assets_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/bindings/main_details_page_binding.dart';
import '../modules/main/views/main_details_page_view.dart';
import '../modules/main/views/main_view.dart';
import '../modules/maintenance/bindings/maintenance_binding.dart';
import '../modules/maintenance/views/maintenance_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/bindings/profile_settings_binding.dart';
import '../modules/profile/views/profile_settings_view.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ASSETS,
      page: () => AssetsView(),
      binding: AssetsBinding(),
    ),
    GetPage(
      name: _Paths.MAINTENANCE,
      page: () => MaintenanceView(),
      binding: MaintenanceBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETTINGS,
      page: () => ProfileSettingsView(),
      binding: ProfileSettingsBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_DETAILS_PAGE,
      page: () => const MainDetailsPageView(),
      binding: MainDetailsPageBinding(),
    ),
  ];
}
