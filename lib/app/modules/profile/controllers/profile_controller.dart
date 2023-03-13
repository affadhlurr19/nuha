import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

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

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection("users").doc(uid).get();

      return docUser.data();
    } catch (e) {
      errMsg('Tidak dapat get data user');
      return null;
    }
  }

  void updateProfile() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        phoneC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String uid = auth.currentUser!.uid;
        await firestore.collection("users").doc(uid).update({
          "name": nameC.text,
          "phone": phoneC.text,
        });

        if (passC.text.isNotEmpty) {
          await auth.currentUser!.updatePassword(passC.text);
          await auth.signOut();
          isLoading.value = false;
          
          Get.offAllNamed(Routes.LOGIN);
        } else {
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        errMsg('Tidak dapat edit data user');
      }
    } else {
      errMsg('Semua data tidak boleh kosong');
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LANDING);
    } catch (e) {
      errMsg('Gagal Logout. $e');
    }
  }
}
