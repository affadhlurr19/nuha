import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';

class CashflowController extends GetxController {
  TextEditingController nominalC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();
  TextEditingController nomAnggaranC = TextEditingController();
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var jenisC = "Pengeluaran".obs;
  var kategoriC = "Pilih Kategori".obs;
  var kategoriStat = "".obs;
  var selectDate = DateTime.now().obs;

  String jenisKategori = "";

  void updateToPendapatan() {
    jenisC.value = "Pendapatan";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";

    Get.back();
  }

  void updateToPengeluaran() {
    jenisC.value = "Pengeluaran";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";

    Get.back();
  }

  void updateKategori(text) {
    kategoriC.value = text;
    kategoriStat.value = "choosen";
    Get.back();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      cancelText: "BATAL",
      confirmText: "OK",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: buttonColor1,
              onPrimary: backgroundColor1,
              onSurface: grey900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: grey900,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectDate.value) {
      selectDate.value = pickedDate;
      Get.back();
    }
  }

  void kategoriCheck() {
    if (kategoriC.value == "Asuransi" ||
        kategoriC.value == "Pendidikan" ||
        kategoriC.value == "Transportasi" ||
        kategoriC.value == "Sosial") {
      jenisKategori = "Umum";
    } else if (kategoriC.value == "Makan" ||
        kategoriC.value == "Belanja" ||
        kategoriC.value == "Hiburan" ||
        kategoriC.value == "Tagihan" ||
        kategoriC.value == "Kesehatan") {
      jenisKategori = "Biaya Hidup";
    } else {
      jenisKategori = "Lainnya";
    }
  }

  void addAnggaran() async {
    if (nomAnggaranC.text.isNotEmpty && kategoriC.isNotEmpty) {
      isLoading.value = true;
      try {
        String uid = auth.currentUser!.uid;
        kategoriCheck();
        await firestore
            .collection("users")
            .doc(uid)
            .collection("anggaran")
            .add({
          "kategori": kategoriC.value,
          "nominal": int.parse(nomAnggaranC.text.replaceAll('.', '')),
          "jenisAnggaran": jenisKategori,
          "createdAt": DateTime.now().toIso8601String(),
        });
        isLoading.value = false;
        Get.back();
      } catch (e) {
        isLoading.value = false;
        // print(e);
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat menambahkan data");
      }
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Kategori dan nominal wajib diisi");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAnggaran() async* {
    String uid = auth.currentUser!.uid;
    yield* await firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .snapshots();
  }
}
