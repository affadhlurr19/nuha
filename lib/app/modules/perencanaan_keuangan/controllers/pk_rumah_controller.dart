import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_rumah_view.dart';

class PkRumahController extends GetxController {
  TextEditingController nomRumah = TextEditingController();
  TextEditingController tahunTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();
  TextEditingController margin = TextEditingController();
  TextEditingController uangMuka = TextEditingController();

  var caraPembayaran = "Pilih Cara Pembayaran".obs;
  var statusStat = "".obs;

  double persentage = 0.0;
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

    if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.to(RsRumahView());
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

    Get.to(RsRumahView());
  }
}
