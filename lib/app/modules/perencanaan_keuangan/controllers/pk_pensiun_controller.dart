import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class PkPensiunController extends GetxController {
  TextEditingController umurSaatIni = TextEditingController();
  TextEditingController umurPensiun = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();
  TextEditingController biayaHidup = TextEditingController();

  RxBool isLoading = false.obs;

  final co = Get.find<TransaksiController>();
  final c = Get.find<CashflowController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  DialogMessage dialogMessage = DialogMessage();

  double danaPensiun = 0;
  int totalBulan = 0;
  int jarakTahun = 0;
  int nomSisa = 0;
  int nomPerbulan = 0;
  var danaStat = "";
  double persentage = 0.0;
  double realPersentage = 0.0;

  void countDana(context) async {
    totalBulan =
        (int.parse(umurPensiun.text) - int.parse(umurSaatIni.text)) * 12;

    jarakTahun = 80 - int.parse(umurPensiun.text);

    danaPensiun =
        double.parse(biayaHidup.text.replaceAll(".", "")) * 12 * jarakTahun;

    for (int i = 1; i < jarakTahun; i++) {
      danaPensiun += danaPensiun * 0.05;
    }

    nomSisa = danaPensiun.toInt() -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    nomPerbulan = (nomSisa / totalBulan).round();

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaPensiun);

    realPersentage = persentage;
    if (persentage > 1.0) {
      persentage = 1.0;
    } else if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.toNamed('/rs-pensiun');
  }

  void saveData(context) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: "Dana Pensiun")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        dialogMessage.errMsg("Anda sudah pernah membuat perencanaan ini.");
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
                "kategori": "Dana Pensiun",
                "imgKategori": "Dana Pensiun",
                "nominal": int.parse(nomDanaTersedia.text.replaceAll(".", "")),
                "tanggalTransaksi": Timestamp.now(),
                "deskripsi": "Penyesuaian dana pensiun",
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
              "image": "Dana Pensiun",
              "kategori": "Dana Pensiun",
              "nominal": danaPensiun.toInt(),
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
