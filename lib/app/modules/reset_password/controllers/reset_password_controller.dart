import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  DialogMessage dialogMessage = DialogMessage();

  void resetPassword() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        isLoading.value = false;
        Get.back();
        dialogMessage
            .successMsg('Kami telah kirim link reset password ke email anda.');
        // ignore: unused_catch_clause
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        dialogMessage.errMsg('Email yang kamu masukkan tidak terdaftar');
      } catch (e) {
        isLoading.value = false;
        dialogMessage.errMsg('Email tidak tersedia.');
      }
    } else {
      isLoading.value = false;
      dialogMessage.errMsg('Email harus diisi');
    }
  }
}
