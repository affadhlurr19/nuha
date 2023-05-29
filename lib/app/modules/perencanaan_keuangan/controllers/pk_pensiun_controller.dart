import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_pensiun_view.dart';

class PkPensiunController extends GetxController {
  TextEditingController umurSaatIni = TextEditingController();
  TextEditingController umurPensiun = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();
  TextEditingController biayaHidup = TextEditingController();

  RxBool isLoading = false.obs;

  double danaPensiun = 0;
  int totalBulan = 0;
  int jarakTahun = 0;
  int nomSisa = 0;
  int nomPerbulan = 0;
  var danaStat = "";
  double persentage = 0.0;

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

    if (persentage > 1.0) {
      persentage = 1.0;
    } else if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.to(() => RsPensiunView());
  }
}
