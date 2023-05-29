import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_pendidikan_view.dart';

class PkPendidikanController extends GetxController {
  TextEditingController namaAnak = TextEditingController();
  TextEditingController umurAnak = TextEditingController();
  TextEditingController umurAnakMasuk = TextEditingController();
  TextEditingController uangPangkal = TextEditingController();
  TextEditingController uangSPP = TextEditingController();
  TextEditingController nomDanaSisih = TextEditingController();
  TextEditingController lamaPendidikan = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();

  RxBool isLoading = false.obs;

  int totalDana = 0;
  double margin = 0.1;
  int jarakTahun = 0;
  int totalSPP = 0;
  double danaSekolah = 0.0;
  double persentage = 0.0;
  double nomSisa = 0.0;
  double nomPerbulan = 0.0;
  double bulanTercapai = 0;
  var danaStat = "";

  void countDana(context) async {
    jarakTahun = int.parse(umurAnakMasuk.text) - int.parse(umurAnak.text);

    totalSPP = jarakTahun * 12 * int.parse(uangSPP.text.replaceAll(".", ""));

    danaSekolah = totalSPP + double.parse(uangPangkal.text.replaceAll(".", ""));

    for (int i = 1; i < jarakTahun; i++) {
      danaSekolah += danaSekolah * margin;
    }

    persentage =
        double.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaSekolah;

    nomSisa =
        danaSekolah - double.parse(nomDanaTersedia.text.replaceAll(".", ""));

    bulanTercapai = jarakTahun * 12;
    nomPerbulan = nomSisa / bulanTercapai;

    if (double.parse(nomDanaSisih.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak dapat dicapai";
    }

    if (persentage > 1.0) {
      persentage = 1.0;
    }

    Get.to(RsPendidikanView());
  }
}
