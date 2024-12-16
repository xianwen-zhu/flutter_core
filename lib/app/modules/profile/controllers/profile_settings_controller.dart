import 'package:flutter_core/core/services/user_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../routes/app_pages.dart';

class ProfileSettingsController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Confirm and handle logout using AwesomeDialog
  void logout(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Logout Confirmation',
      desc: 'Are you sure you want to log out?',
      btnCancelOnPress: () {
        // Show cancellation toast
        Fluttertoast.showToast(
          msg: "Logout cancelled",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      btnOkOnPress: () {
        // Show logging out toast and perform logout
        Fluttertoast.showToast(
          msg: "Logging out...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _performLogout();
      },
      btnCancelText: "Cancel",
      btnOkText: "Confirm",
    ).show();
  }

  /// Perform the actual logout operation
  void _performLogout() {
    UserManager().clearUserData(); // Clear user data

    // Show logout success toast
    Fluttertoast.showToast(
      msg: "You have been logged out.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Navigate to the login page
    Get.offAllNamed(Routes.LOGIN);
  }
}