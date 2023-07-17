import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class PkDaruratController extends GetxController {
  TextEditingController namaDana = TextEditingController();
  TextEditingController nomPengeluaran = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();

  final co = Get.find<TransaksiController>();
  final c = Get.find<CashflowController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  DialogMessage dialogMessage = DialogMessage();

  final textValidation = TextEditingController();
  RxBool isLoading = false.obs;

  var statusPernikahan = "Pilih Status Pernikahan".obs;
  var statusStat = "".obs;
  var danaStat = "";
  var danaInfo = "";
  int danaDarurat = 0;
  int nomSisa = 0;
  double nomPerbulan = 0.0;
  double totalDanaSisihkan = 0.0;
  double persentage = 0.0;
  double realPersentage = 0.0;

  void updateStatus(value) {
    statusPernikahan.value = value;
    statusStat.value = "choosen";
  }

  void countDana(context) async {
    if (statusPernikahan.value == "Belum Menikah") {
      danaDarurat = 3 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
      danaInfo =
          "Jumlah dana darurat dengan status belum menikah adalah 3 kali dari total pengeluaran perbulannya.";
    } else if (statusPernikahan.value == "Sudah Menikah") {
      danaDarurat = 6 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
      danaInfo =
          "Jumlah dana darurat dengan status sudah menikah adalah 6 kali dari total pengeluaran perbulannya.";
    } else if (statusPernikahan.value == "Sudah Menikah dan Memiliki Anak") {
      danaDarurat = 12 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
      danaInfo =
          "Jumlah dana darurat dengan status sudah menikah dan memiliki anak adalah 12 kali dari total pengeluaran perbulannya.";
    } else {
      danaDarurat = 0;
    }

    nomSisa = danaDarurat - int.parse(nomDanaTersedia.text.replaceAll(".", ""));
    nomPerbulan = nomSisa / int.parse(bulanTercapai.text);

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaDarurat);

    realPersentage = persentage;

    if (persentage > 1.0) {
      persentage = 1.0;
    } else if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.toNamed('/rs-darurat');
  }

  void saveData(context) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: "Dana ${namaDana.text}")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        dialogMessage.errMsg(
            "Anda sudah pernah membuat perencanaan ini. Silahkan buat dengan nama lain.");
      } else {
        if (nomDanaTersedia.text.isNotEmpty) {
          isLoading.value = true;
          try {
            String id = firestore.collection("users").doc().id;

            if (nomDanaTersedia.text != "0") {
              firestore
                  .collection("users")
                  .doc(uid)
                  .collection("transaksi")
                  .doc(id)
                  .set({
                "id": id,
                "jenisTransaksi": "Pengeluaran",
                "namaTransaksi": "Penyesuaian Dana",
                "kategori": "Dana ${namaDana.text}",
                "imgKategori": "Dana Darurat",
                "nominal": int.parse(nomDanaTersedia.text.replaceAll(".", "")),
                "tanggalTransaksi": Timestamp.now(),
                "deskripsi": "Penyesuaian dana darurat ${namaDana.text}",
                "foto": "",
                "createdAt": DateTime.now().toIso8601String(),
                "updatedAt": DateTime.now().toIso8601String(),
              });

              co.totalTransPengeluaran();
            }

            firestore
                .collection("users")
                .doc(uid)
                .collection("anggaran")
                .doc(id)
                .set({
              "id": id,
              "image": "Dana Darurat",
              "kategori": "Dana ${namaDana.text}",
              "nominal": danaDarurat.toInt(),
              "jenisAnggaran": "Lainnya",
              "nominalTerpakai":
                  int.parse(nomDanaTersedia.text.replaceAll(".", "")),
              "persentase":
                  double.parse(realPersentage.toStringAsFixed(2)).toString(),
              "sisaLimit": nomSisa,
              "createdAt": DateTime.now().toIso8601String(),
              "updatedAt": DateTime.now().toIso8601String(),
            });

            c.totalNominalKategori();

            isLoading.value = false;

            Get.offAllNamed("/perencanaan-keuangan");
          } catch (e) {
            isLoading.value = false;
            // print(e);
            dialogMessage.errMsg("Tidak dapat menambahkan data!");
          }
        } else {
          dialogMessage.errMsg("Seluruh data wajib diisi");
        }
      }
    });
  }
}
