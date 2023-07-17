import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';

class DialogMessage extends GetxController {
  void successMsg(String msg) {
    Get.snackbar(
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInOutBack,
      backgroundColor: succColor,
      colorText: backgroundColor1,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      "Berhasil",
      msg,
    );
  }

  void errMsg(String msg) {
    Get.snackbar(
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInOutBack,
      backgroundColor: errColor,
      colorText: backgroundColor1,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      "Terjadi Kesalahan",
      msg,
    );
  }

  void warnMsg(String msg) {
    Get.snackbar(
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInOutBack,
      backgroundColor: warnColor,
      colorText: backgroundColor1,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      "Peringatan",
      msg,
    );
  }
}
