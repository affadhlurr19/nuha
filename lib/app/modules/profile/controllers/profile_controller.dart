import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //update profile
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController bdayC = TextEditingController();
  TextEditingController workC = TextEditingController();
  var selectedDate = DateTime.now().obs;

  //update password
  TextEditingController oldpassC = TextEditingController();
  TextEditingController newpassC = TextEditingController();
  TextEditingController connewpassC = TextEditingController();
  RxBool oldpassHidden = true.obs;
  RxBool newpassHidden = true.obs;
  RxBool connewpassHidden = true.obs;

  RxBool isLoading = false.obs;

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

  chooseDate() async {
    DateTime? pickerDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(1924),
      lastDate: DateTime(2024),
      helpText: 'Masukkan Tanggal Lahir Anda',
      errorFormatText: 'Masukkan tanggal lahir sesuai dengan format',
      errorInvalidText: 'Masukkan tanggal lahir yang valid',
      fieldHintText: 'MM/dd/yyyy',
      fieldLabelText: 'Tanggal Lahir',
      cancelText: 'Tutup',
      confirmText: 'Ok',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  surface: buttonColor1,
                  primary: buttonColor1,
                  onSurface: Colors.black,
                  onPrimary: Colors.white,
                ),
            textTheme: TextTheme(
              headline5: GoogleFonts.jost(),
              headline6: GoogleFonts.jost(),
              overline: GoogleFonts.jost(),
              bodyText1: GoogleFonts.jost(),
              subtitle1: GoogleFonts.jost(color: Colors.black),
              subtitle2: GoogleFonts.jost(),
              headline3: GoogleFonts.jost(),
              headline4: GoogleFonts.jost(),
              caption: GoogleFonts.jost(),
            ),
            inputDecorationTheme:
                InputDecorationTheme(labelStyle: GoogleFonts.jost()),
          ),
          child: child!,
        );
      },
    );
    if (pickerDate != null && pickerDate != selectedDate.value) {
      bdayC.text = DateFormat('dd/MM/yyyy').format(pickerDate);
    }
  }

  void updateProfile() async {
    if (emailC.text.isNotEmpty && nameC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        String uid = auth.currentUser!.uid;
        await firestore.collection("users").doc(uid).update({
          "name": nameC.text,
          "phone": phoneC.text,
          "tgl_lahir": bdayC.text,
          "pekerjaan": workC.text,
        });
        successMsg('Berhasil memperbarui data');
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        errMsg('Tidak dapat edit data user');
      }
    } else {
      errMsg('Semua data tidak boleh kosong');
    }
  }

  void updatePassword() async {
    if (oldpassC.text.isNotEmpty &&
        newpassC.text.isNotEmpty &&
        connewpassC.text.isNotEmpty) {
      try {
        isLoading.value = true;
        // autentikasi kembali untuk mengecek password user
        final user = FirebaseAuth.instance.currentUser;
        final credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: oldpassC.text,
        );
        await user.reauthenticateWithCredential(credential);
        if (newpassC.text == connewpassC.text) {
          await auth.currentUser!.updatePassword(newpassC.text);
          await auth.signOut();
          isLoading.value = false;
          successMsg('Berhasil memperbarui kata sandi. Silahkan login kembali');
          Get.offAllNamed(Routes.LOGIN);
        } else {
          isLoading.value = false;
          errMsg('Konfirmasi kata sandi tidak cocok');
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          errMsg('Informasi pengguna tidak ditemukan');
        } else if (e.code == 'wrong-password') {
          errMsg('Kata sandi saat ini yang diinputkan salah');
        } else {
          errMsg('Gagal mengubah kata sandi');
        }
      }
    } else {
      isLoading.value = false;
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

  Future<void> logoutGoogle() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      Get.offAllNamed(Routes.LANDING);
    } catch (e) {
      print(e);
    }
  }
}
