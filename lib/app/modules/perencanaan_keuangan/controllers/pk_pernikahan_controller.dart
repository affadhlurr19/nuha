import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class PkPernikahanController extends GetxController {
  TextEditingController namaPasangan = TextEditingController();
  TextEditingController nomBiaya = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();

  final co = Get.find<TransaksiController>();
  final c = Get.find<CashflowController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  DialogMessage dialogMessage = DialogMessage();

  double danaPernikahan = 0.0;
  int nomSisa = 0;
  double nomPerbulan = 0.0;
  double persentage = 0.0;
  double tahun = 0.0;
  var danaStat = "";
  double realPersentage = 0.0;

  RxBool isLoading = false.obs;

  void countDana(context) async {
    tahun = int.parse(bulanTercapai.text) / 12;

    danaPernikahan = double.parse(nomBiaya.text.replaceAll(".", ""));

    for (int i = 1; i < tahun; i++) {
      danaPernikahan += danaPernikahan * 0.1;
    }

    nomSisa = danaPernikahan.toInt() -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    nomPerbulan = danaPernikahan.toInt() / int.parse(bulanTercapai.text);

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaPernikahan);

    realPersentage = persentage;
    if (persentage < 0.1) {
      persentage = 0.1;
    } else if (persentage > 1.0) {
      persentage = 1.0;
    }

    Get.toNamed('/rs-pernikahan');
  }

  void saveData(context) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: "Dana Pernikahan")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        dialogMessage
            .errMsg("Anda sudah pernah membuat perencanaan pernikahan.");
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
                "kategori": "Dana Pernikahan",
                "imgKategori": "Dana Pernikahan",
                "nominal": int.parse(nomDanaTersedia.text.replaceAll(".", "")),
                "tanggalTransaksi": Timestamp.now(),
                "deskripsi":
                    "Penyesuaian dana pernikahan bersama pasangan ${namaPasangan.text}",
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
              "kategori": "Dana Pernikahan",
              "image": "Dana Pernikahan",
              "nominal": danaPernikahan.toInt(),
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
