import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class PkUmrohController extends GetxController {
  TextEditingController nomHajiUmroh = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaSisih = TextEditingController();

  final co = Get.find<TransaksiController>();
  final c = Get.find<CashflowController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  DialogMessage dialogMessage = DialogMessage();

  RxBool isLoading = false.obs;
  double inflasi = 0.05;
  double danaHajiUmroh = 0.0;
  int tahun = 0;
  int nomSisa = 0;
  double persentage = 0.0;
  double realPersentage = 0.0;
  double nomPerbulan = 0;
  var danaStat = "";

  void countDana(context) async {
    danaHajiUmroh = double.parse(nomHajiUmroh.text.replaceAll(".", ""));

    tahun = (int.parse(bulanTercapai.text) / 12).ceil();

    for (int i = 1; i < tahun; i++) {
      danaHajiUmroh += danaHajiUmroh * inflasi;
    }

    nomSisa = danaHajiUmroh.toInt() -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    persentage =
        double.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaHajiUmroh;

    realPersentage = persentage;
    if (persentage < 0.1) {
      persentage = 0.1;
    } else if (persentage > 1.0) {
      persentage = 1;
    }

    nomPerbulan = nomSisa / int.parse(bulanTercapai.text);

    if (int.parse(nomDanaSisih.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    Get.toNamed('/rs-umroh');
  }

  void saveData(context) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: "Dana Haji/Umroh")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        dialogMessage.errMsg("Anda sudah pernah membuat perencanaan ini.");
      } else {
        if (nomDanaTersedia.text.isNotEmpty) {
          isLoading.value = true;
          try {
            String uid = auth.currentUser!.uid;
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
                "kategori": "Dana Haji/Umroh",
                "imgKategori": "Dana Haji Umroh",
                "nominal": int.parse(nomDanaTersedia.text.replaceAll(".", "")),
                "tanggalTransaksi": Timestamp.now(),
                "deskripsi": "Penyesuaian dana haji/umroh",
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
              "image": "Dana Haji Umroh",
              "kategori": "Dana Haji/Umroh",
              "nominal": danaHajiUmroh.toInt(),
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
