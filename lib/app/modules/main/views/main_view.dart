import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/base_app_bar_page.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAppBarPage(title: 'Home', body: Text(''),showBackButton: false,);
  }
}
