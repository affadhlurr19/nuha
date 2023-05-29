import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/rs_darurat_view.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:nuha/mobile.dart';

class PkDaruratController extends GetxController {
  TextEditingController namaDana = TextEditingController();
  TextEditingController nomPengeluaran = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();
  TextEditingController nomDanaDisisihkan = TextEditingController();
  RxBool isLoading = false.obs;

  var statusPernikahan = "Pilih Status Pernikahan".obs;
  var statusStat = "".obs;
  var danaStat = "";
  int danaDarurat = 0;
  int nomSisa = 0;
  double nomPerbulan = 0.0;
  double totalDanaSisihkan = 0.0;
  double persentage = 0.0;

  void updateStatus(value) {
    statusPernikahan.value = value;
    statusStat.value = "choosen";
  }

  void countDana(context) async {
    if (statusPernikahan.value == "Belum Menikah") {
      danaDarurat = 3 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
    } else if (statusPernikahan.value == "Sudah Menikah") {
      danaDarurat = 6 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
    } else if (statusPernikahan.value == "Sudah Menikah dan Memiliki Anak") {
      danaDarurat = 12 * int.parse(nomPengeluaran.text.replaceAll(".", ""));
    } else {
      danaDarurat = 0;
    }

    nomSisa = danaDarurat - int.parse(nomDanaTersedia.text.replaceAll(".", ""));
    nomPerbulan = nomSisa / int.parse(bulanTercapai.text);

    if (int.parse(nomDanaDisisihkan.text.replaceAll(".", "")) > nomPerbulan) {
      danaStat = "dapat tercapai";
    } else {
      danaStat = "tidak akan tercapai";
    }

    persentage =
        (int.parse(nomDanaTersedia.text.replaceAll(".", "")) / danaDarurat);

    if (persentage > 1.0) {
      persentage = 1.0;
    } else if (persentage < 0.1) {
      persentage = 0.1;
    }

    Get.to(RsDaruratView());
  }

  Future<void> getPdf() async {
    PdfDocument documents = PdfDocument();
    documents.pages.add();

    List<int> bytes = await documents.save();
    documents.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }
}
