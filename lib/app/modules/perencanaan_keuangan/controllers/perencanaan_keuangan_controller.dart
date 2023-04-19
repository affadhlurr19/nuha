import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PerencanaanKeuanganController extends GetxController {
  TextEditingController namaDana = TextEditingController();
  TextEditingController nomPengeluaran = TextEditingController();
  TextEditingController bulanTercapai = TextEditingController();
  TextEditingController nomDanaTersedia = TextEditingController();

  TextEditingController namaAnak = TextEditingController();
  TextEditingController umurAnak = TextEditingController();
  TextEditingController umurAnakMasuk = TextEditingController();
  TextEditingController nomBiayaPendidikan = TextEditingController();

  TextEditingController nomHajiUmroh = TextEditingController();

  TextEditingController namaPasangan = TextEditingController();

  TextEditingController nomRumah = TextEditingController();

  TextEditingController namaKendaraan = TextEditingController();
  TextEditingController nomKendaraan = TextEditingController();

  TextEditingController umurSaatIni = TextEditingController();
  TextEditingController umurHarapan = TextEditingController();

  var statusPernikahan = "".obs;
  //TODO: Implement PerencanaanKeuanganController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
