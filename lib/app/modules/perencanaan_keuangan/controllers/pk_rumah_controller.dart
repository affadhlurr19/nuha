import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class PkRumahController extends GetxController {
  TextEditingController nomRumah = TextEditingController();
  TextEditingController tahunTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();
  TextEditingController margin = TextEditingController();

  final co = Get.find<TransaksiController>();
  final c = Get.find<CashflowController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  DialogMessage dialogMessage = DialogMessage();

  var caraPembayaran = "Pilih Cara Pembayaran".obs;
  var statusStat = "".obs;

  double persentage = 0.0;
  double realPersentage = 0.0;
  double perkiraanHarga = 0; //nomRumah*0.05
  int nomSisa = 0;
  double bulan = 0.0;
  double tabunganPerbulan = 0.0;
  var danaStat = "";

  double bungaTahunan = 0.0;
  int angsuranBulanan = 0;
  double biayaLain = 0;

  int penghasilan30 = 0;
  int penghasilan40 = 0;

  RxBool isLoading = false.obs;

  void updateStatus(value) {
    caraPembayaran.value = value;
    statusStat.value = "choosen";
  }

  void countCash(context) async {
    perkiraanHarga = double.parse(nomRumah.text.replaceAll(".", ""));

    for (int i = 1; i < double.parse(tahunTercapai.text); i++) {
      perkiraanHarga += perkiraanHarga * 0.05;
    }

    nomSisa = perkiraanHarga.toInt() -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    bulan = double.parse(tahunTercapai.text) * 12;

    tabunganPerbulan = perkiraanHarga.toDouble() / bulan;

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) >
        tabunganPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / perkiraanHarga);

    realPersentage = persentage;
    if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.toNamed('/rs-rumah');
  }

  void countKPRMurabahah(context) async {
    nomSisa = int.parse(nomRumah.text.replaceAll(".", "")) -
        int.parse(nomDanaTersedia.text.replaceAll(".", ""));

    persentage = (int.parse(nomDanaTersedia.text.replaceAll(".", "")) /
        int.parse(nomRumah.text.replaceAll(".", "")));

    bungaTahunan = double.parse(margin.text) / 100;

    bulan = double.parse(tahunTercapai.text) * 12;

    angsuranBulanan =
        ((nomSisa * (bungaTahunan * int.parse(tahunTercapai.text)) + nomSisa) /
                bulan)
            .round();

    penghasilan30 = angsuranBulanan * (100 ~/ 30).toInt();

    penghasilan40 = angsuranBulanan * (100 ~/ 40).toInt();

    realPersentage = persentage;
    if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.toNamed('/rs-rumah');
  }

  void saveData(context) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: "Dana Rumah Impian")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        dialogMessage
            .errMsg("Anda sudah pernah membuat perencanaan rumah impian.");
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
                "kategori": "Dana Rumah Impian",
                "imgKategori": "Dana Rumah Impian",
                "nominal": int.parse(nomDanaTersedia.text.replaceAll(".", "")),
                "tanggalTransaksi": Timestamp.now(),
                "deskripsi": "Penyesuaian dana rumah impian.",
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
              "image": "Dana Rumah Impian",
              "kategori": "Dana Rumah Impian",
              "nominal": perkiraanHarga != 0
                  ? perkiraanHarga.toInt()
                  : int.parse(nomRumah.text.replaceAll(".", "")),
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
