// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:nuha/app/utility/dialog_message.dart';
import 'package:sizer/sizer.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool rememeberMe = false.obs;
  final box = GetStorage();
  RxBool isLoadingG = false.obs;
  DialogMessage dialogMessage = DialogMessage();

  //Google Sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

          final DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .get();
          var pinCheck = userDoc.data()!['pin'];

          if (pinCheck == '') {
            Get.toNamed(Routes.CREATE_PIN);
          } else {
            Get.toNamed(Routes.AUTH_PIN, arguments: Routes.NAVBAR);
          }
        } else {
          print('User belum terverifikasi');
          Get.defaultDialog(
            title: "Perhatian",
            titleStyle: Theme.of(Get.context!)
                .textTheme
                .headlineMedium!
                .copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    color: grey900),
            middleText:
                "Akun kamu belum aktif. Apakah kamu ingin mengirim ulang email verifikasi?",
            middleTextStyle: Theme.of(Get.context!)
                .textTheme
                .bodyMedium!
                .copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                    color: grey900),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: buttonColor2,
                        backgroundColor: backgroundColor1,
                        side: const BorderSide(color: buttonColor2, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          'Tidak',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                  color: buttonColor2),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await userCredential.user!.sendEmailVerification();
                          Get.back();
                          dialogMessage
                              .successMsg('Verifikasi email berhasil dikirim');
                        } catch (e) {
                          Get.back();
                          dialogMessage.errMsg(
                              'Terlalu banyak permintaan verifikasi email');
                          print(e);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor2,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          'Setuju',
                          style: Theme.of(Get.context!)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                  color: backgroundColor1),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          dialogMessage.errMsg('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          dialogMessage.errMsg('Wrong password provided for that user.');
        }
      }
    } else {
      dialogMessage.errMsg('Email dan Password tidak boleh kosong');
    }
  }

  void registerWithGoogle() async {
    try {
      isLoadingG.value = true;
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      isLoadingG.value = false;
      await auth.signInWithCredential(credential);
      DocumentSnapshot<Map<String, dynamic>> query =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();

      if (!query.exists) {
        await firestore.collection("users").doc(auth.currentUser!.uid).set({
          "name": auth.currentUser!.displayName,
          "email": auth.currentUser!.email,
          "uid": auth.currentUser!.uid,
          "phone": "",
          "tgl_lahir": "",
          "pekerjaan": "",
          "pin": "",
          "created_at": DateTime.now().toIso8601String(),
        });
      }
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      var pinCheck = userDoc.data()!['pin'];

      if (pinCheck == '') {
        Get.toNamed(Routes.CREATE_PIN);
      } else {
        Get.toNamed(Routes.AUTH_PIN, arguments: Routes.NAVBAR);
      }
    } on FirebaseAuthException catch (e) {
      isLoadingG.value = false;
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        dialogMessage.errMsg('This account exists with different credential.');
      }
    } catch (e) {
      isLoadingG.value = false;
      print(e);
    }
  }
}
