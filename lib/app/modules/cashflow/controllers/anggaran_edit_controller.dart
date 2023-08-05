import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/home/controllers/home_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class AnggaranEditController extends GetxController {
  final con = Get.find<CashflowController>();
  final co = Get.find<HomeController>();

  RxBool isLoading = false.obs;
  TextEditingController nomAnggaranC = TextEditingController();
  var kategoriC = "Pilih Kategori".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  DialogMessage dialogMessage = DialogMessage();

  Future<Map<String, dynamic>?> getAnggaranById(String docId) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .get();
      // sisaTransAnggaran(doc.data()?["kategori"], doc.data()?["nominal"], docId);
      con.countAnggaranDetail(doc.data()?["kategori"]);

      return doc.data();
    } catch (e) {
      dialogMessage.errMsg("Coba lagi nanti!");
    }
    return null;
  }

  void updateAnggaranById(context, String docId) async {
    if (nomAnggaranC.text.isNotEmpty && nomAnggaranC.text != "0") {
      isLoading.value = true;
      try {
        String uid = auth.currentUser!.uid;
        DocumentSnapshot<Map<String, dynamic>> doc = await firestore
            .collection("users")
            .doc(uid)
            .collection("anggaran")
            .doc(docId)
            .get();

        con.countAnggaranDetail(doc.data()?["kategori"]);

        await firestore
            .collection("users")
            .doc(uid)
            .collection("anggaran")
            .doc(docId)
            .update({
          "nominal": int.parse(nomAnggaranC.text.replaceAll('.', '')),
          "updatedAt": DateTime.now().toIso8601String(),
        });

        isLoading.value = false;
        con.totalNominalKategori();
        dialogMessage.successMsg("Data berhasil diubah!");

        Navigator.pop(context);
      } catch (e) {
        // print(e);
        isLoading.value = false;
        dialogMessage.errMsg("Data gagal diubah, coba lagi nanti!");
      }
    } else {
      dialogMessage.errMsg("Kategori dan nominal wajib diisi.");
    }
  }

  void deleteAnggaranById(context, String docId) async {
    isLoading.value = true;
    try {
      String uid = auth.currentUser!.uid;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .delete();
      isLoading.value = false;
      con.totalNominalKategori();
      con.countAnggaranTerpakai();
      co.checkAnggaranCollectionExist();

      // Get.to(() => AnggaranView());

      Get.back();
      Navigator.pop(context);

      dialogMessage.successMsg("Data berhasil kami hapus dari database.");
    } catch (e) {
      isLoading.value = false;
      dialogMessage.errMsg("Tidak dapat menghapus data, coba lagi nanti!");
    }
  }
}
