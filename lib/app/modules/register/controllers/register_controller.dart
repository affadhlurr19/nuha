// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController konfirpassC = TextEditingController();

  RxBool isLoading = false.obs;

  void register() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      if (passC.text == konfirpassC.text) {
        try {
          isLoading.value = true;
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: emailC.text,
            password: passC.text,
          );

          print(userCredential);
          isLoading.value = false;
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else {
        print("Konfirmasi password tidak cocok!");
      }
    } else {
      print("Email dan Password tidak boleh kosong!");
    }
  }
}
