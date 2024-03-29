import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static snackBar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
    );
  }
}
