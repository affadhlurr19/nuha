import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class PkKendaraanController extends GetxController {
  TextEditingController namaKendaraan = TextEditingController();
  TextEditingController nomKendaraan = TextEditingController();
  TextEditingController lamaTenor = TextEditingController();
  TextEditingController margin = TextEditingController();
  TextEditingController persenDP = TextEditingController();
  TextEditingController tahunTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();

  final co = Get.find<TransaksiController>();
  final c = Get.find<CashflowController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  DialogMessage dialogMessage = DialogMessage();

  RxBool isLoading = false.obs;

  var caraPembayaran = "Pilih Cara Pembayaran".obs;
  var statusStat = "".obs;

  double perkiraanHarga = 0.0;
  double persenMargin = 0.0;
  int nomSisa = 0;
  int bulan = 0;
  double persentage = 0.0;
  double realPersentage = 0.0;
  var danaStat = "";
  int tabunganPerbulan = 0;

  int penghasilan30 = 0;
  int penghasilan40 = 0;
  int angsuranBulanan = 0;
  int uangMuka = 0;
  int pokokPinjaman = 0;
  int tahunTenor = 0;

  void updateStatus(value) {
    caraPembayaran.value = value;
    statusStat.value = "choosen";
  }

  void countDana(context) async {
    persenMargin = int.parse(margin.text) / 100;

    perkiraanHarga = double.parse(nomKendaraan.text.replaceAll(".", ""));

    if (caraPembayaran.value == "Cash") {
      for (int i = 1; i < double.parse(tahunTercapai.text); i++) {
        perkiraanHarga += perkiraanHarga * persenMargin;
      }

      nomSisa = perkiraanHarga.toInt() -
          int.parse(nomDanaTersedia.text.replaceAll(".", ""));

      persentage = int.parse(nomDanaTersedia.text.replaceAll(".", "")) /
          perkiraanHarga.toInt();

      realPersentage = persentage;

      if (persentage < 0.1) {
        persentage = 0.1;
      }

      bulan = (int.parse(tahunTercapai.text) * 12).ceil();

      // ignore: division_optimization
      tabunganPerbulan = (perkiraanHarga / bulan).toInt();

      if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) >
          tabunganPerbulan) {
        danaStat = "dapat tercapai";
      } else {
        danaStat = "tidak akan tercapai";
      }
    } else {
      uangMuka = (int.parse(nomKendaraan.text.replaceAll(".", "")) *
              int.parse(persenDP.text) /
              100)
          .ceil();

      tahunTenor = (int.parse(lamaTenor.text) / 12).round();

      for (int i = 1; i < tahunTenor; i++) {
        perkiraanHarga += perkiraanHarga * persenMargin;
      }

      pokokPinjaman = perkiraanHarga.toInt() - uangMuka;

      angsuranBulanan = (pokokPinjaman / int.parse(lamaTenor.text)).round();

      penghasilan30 = angsuranBulanan * (100 ~/ 30).toInt();

      penghasilan40 = angsuranBulanan * (100 ~/ 40).toInt();

      nomDanaTersedia.text = "0";

      nomSisa = int.parse(nomKendaraan.text.replaceAll(".", ""));
    }

    Get.toNamed('/rs-kendaraan');
  }

  void saveData(context) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: "Dana ${namaKendaraan.text}")
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
                "kategori": "Dana ${namaKendaraan.text}",
                "imgKategori": "Dana Beli Kendaraan",
                "nominal": int.parse(nomDanaTersedia.text.replaceAll(".", "")),
                "tanggalTransaksi": Timestamp.now(),
                "deskripsi": "Penyesuaian dana kendaraan ${namaKendaraan.text}",
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
              "image": "Dana Beli Kendaraan",
              "kategori": "Dana ${namaKendaraan.text}",
              "nominal": int.parse(nomKendaraan.text.replaceAll(".", "")),
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
