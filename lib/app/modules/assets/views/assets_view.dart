import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/assets_controller.dart';

class AssetsView extends GetView<AssetsController> {
  const AssetsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AssetsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AssetsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
