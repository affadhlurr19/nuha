import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_pernikahan_view.dart';

class PkPernikahanController extends GetxController {
  TextEditingController namaPasangan = TextEditingController();
  TextEditingController nomBiaya = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();

  double danaPernikahan = 0.0;
  int nomSisa = 0;
  double nomPerbulan = 0.0;
  double persentage = 0.0;
  double tahun = 0.0;
  var danaStat = "";

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

    Get.to(RsPernikahanView());
  }
}
