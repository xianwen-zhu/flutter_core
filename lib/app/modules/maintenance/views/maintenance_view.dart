import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/maintenance_controller.dart';

class MaintenanceView extends GetView<MaintenanceController> {
  const MaintenanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaintenanceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MaintenanceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
