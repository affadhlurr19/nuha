// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool rememeberMe = false.obs;
  final box = GetStorage();

  void successMsg(String msg) {
    Get.snackbar(
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInOutBack,
      backgroundColor: buttonColor1,
      colorText: backgroundColor1,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
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
      snackPosition: SnackPosition.BOTTOM,
      "Terjadi Kesalahan",
      msg,
    );
  }

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        isLoading.value = false;

        if (userCredential.user!.emailVerified == true) {
          if (box.read("rememberMe") != null) {
            await box.remove("rememberMe");
          }
          if (rememeberMe.isTrue) {
            await box.write("rememberMe", {
              "email": emailC.text,
              "pass": passC.text,
            });
          }
          Get.offAllNamed(Routes.HOME);
        } else {
          print('User belum terverifikasi');
          Get.defaultDialog(
            title: "Belum Terverifikasi",
            middleText: "Apakah anda ingin mengirim email verifikasi?",
            middleTextStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text("Tidak"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await userCredential.user!.sendEmailVerification();
                    Get.back();
                    successMsg('Verifikasi email berhasil dikirim');
                  } catch (e) {
                    Get.back();
                    errMsg('Terlalu banyak permintaan verifikasi email');
                    print(e);
                  }
                },
                child: const Text("Kirim"),
              ),
            ],
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          errMsg('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          errMsg('Wrong password provided for that user.');
        }
      }
    } else {
      errMsg('Email dan Password tidak boleh kosong');
    }
  }
}
