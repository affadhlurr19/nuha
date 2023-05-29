import 'package:get/get.dart';

import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_umroh_view.dart';

class PkUmrohController extends GetxController {
  TextEditingController nomHajiUmroh = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaSisih = TextEditingController();

  RxBool isLoading = false.obs;
  double inflasi = 0.05;
  double danaHajiUmroh = 0.0;
  int tahun = 0;
  int nomSisa = 0;
  double persentage = 0.0;
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

    Get.to(RsUmrohView());
  }
}
