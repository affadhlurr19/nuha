import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';

class CashflowController extends GetxController {
  TextEditingController nominalC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();
  TextEditingController nomAnggaranC = TextEditingController();

  var jenisC = "Pengeluaran".obs;
  var kategoriC = "Pilih Kategori".obs;
  var kategoriStat = "".obs;
  var selectDate = DateTime.now().obs;

  void updateToPendapatan() {
    jenisC.value = "Pendapatan";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";
    Get.back();
  }

  void updateToPengeluaran() {
    jenisC.value = "Pengeluaran";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";
    Get.back();
  }

  void updateKategori(text) {
    kategoriC.value = text;
    kategoriStat.value = "choosen";
    Get.back();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      cancelText: "BATAL",
      confirmText: "OK",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: buttonColor1,
              onPrimary: backgroundColor1,
              onSurface: grey900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: grey900,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != selectDate.value) {
      selectDate.value = pickedDate;
      Get.back();
    }
  }
}
