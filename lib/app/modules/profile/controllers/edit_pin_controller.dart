import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/profile/controllers/auth_pin_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class EditPinController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingResetPIN = false.obs;
  RxBool isLoadingResetPINAuth = false.obs;

  RxBool oldPIN = true.obs;
  RxBool newPIN = true.obs;
  RxBool confirmNewPIN = true.obs;

  RxBool resetPIN = true.obs;
  RxBool conResetPIN = true.obs;

  RxBool resetPINAuth = true.obs;
  RxBool conResetPINAuth = true.obs;

  TextEditingController oldPINC = TextEditingController();
  TextEditingController newPINC = TextEditingController();
  TextEditingController conNewPINC = TextEditingController();

  TextEditingController resetPINC = TextEditingController();
  TextEditingController conResetPINC = TextEditingController();

  TextEditingController resetPINAuthC = TextEditingController();
  TextEditingController conResetAuthPINC = TextEditingController();

  DialogMessage dialogMessage = DialogMessage();
  final authC = Get.find<AuthPinController>();

  Future<void> updatePIN() async {
    if (oldPINC.text.isNotEmpty &&
        newPINC.text.isNotEmpty &&
        conNewPINC.text.isNotEmpty) {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;

      if (oldPINC.text.length == 6 &&
          newPINC.text.length == 6 &&
          conNewPINC.text.length == 6) {
        if (newPINC.text == conNewPINC.text) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .update({
            'pin': newPINC.text,
          });
          oldPINC.clear();
          newPINC.clear();
          conNewPINC.clear();

          isLoading.value = false;

          Get.back();
          dialogMessage.successMsg('Ubah PIN berhasil.');
        } else {
          isLoading.value = false;
          dialogMessage.errMsg('Konfirmasi Pin tidak cocok.');
        }
      } else {
        isLoading.value = false;
        dialogMessage.errMsg('PIN harus 6 karakter angka.');
      }
    } else {
      isLoading.value = false;
      dialogMessage.errMsg('Data tidak boleh kosong.');
    }
  }

  Future<void> forgotPIN() async {
    isLoadingResetPIN.value = true;
    final user = FirebaseAuth.instance.currentUser;

    if (resetPINC.text.isNotEmpty && conResetPINC.text.isNotEmpty) {
      if (resetPINC.text.length == 6 && conResetPINC.text.length == 6) {
        if (resetPINC.text == conResetPINC.text) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .update({
            'pin': resetPINC.text,
          });
          resetPINC.clear();
          conResetPINC.clear();

          isLoadingResetPIN.value = false;

          Get.back();
          Get.back();
          dialogMessage.successMsg('Setel Ulang PIN berhasil.');
        } else {
          isLoadingResetPIN.value = false;
          dialogMessage.errMsg('Konfirmasi Pin tidak cocok.');
        }
      } else {
        isLoadingResetPIN.value = false;
        dialogMessage.errMsg('PIN harus 6 digit angka.');
      }
    } else {
      isLoadingResetPIN.value = false;
      dialogMessage.errMsg('Semua kolom tidak boleh kosong');
    }
  }

  Future<void> forgotPINOnAuth() async {
    isLoadingResetPINAuth.value = true;
    final user = FirebaseAuth.instance.currentUser;

    if (resetPINAuthC.text.isNotEmpty && conResetAuthPINC.text.isNotEmpty) {
      if (resetPINAuthC.text.length == 6 && conResetAuthPINC.text.length == 6) {
        if (resetPINAuthC.text == conResetAuthPINC.text) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .update({
            'pin': resetPINAuthC.text,
          });
          resetPINAuthC.clear();
          conResetAuthPINC.clear();

          isLoadingResetPINAuth.value = false;

          Get.back();
          Get.back();

          dialogMessage.successMsg('Setel Ulang PIN berhasil.');
        } else {
          isLoadingResetPINAuth.value = false;
          dialogMessage.errMsg('Konfirmasi Pin tidak cocok.');
        }
      } else {
        isLoadingResetPINAuth.value = false;
        dialogMessage.errMsg('PIN harus 6 digit angka.');
      }
    } else {
      isLoadingResetPINAuth.value = false;
      dialogMessage.errMsg('DSemua kolom tidak boleh kosong');
    }
  }
}
