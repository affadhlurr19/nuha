import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/fincheck/controllers/fincheck_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class FincheckResultView extends GetView<FincheckController> {
  FincheckResultView({Key? key}) : super(key: key);

  final currencyFormat = NumberFormat.currency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: titleColor,
            size: 18.sp,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 7.778.w,
          ),
          children: [
            GradientText(
              "Hasil Analisa",
              style: Theme.of(context).textTheme.displaySmall!,
              colors: const [
                buttonColor1,
                buttonColor2,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Total Pemasukan: ${currencyFormat.format(controller.totalPemasukan.toString())}",
                //   style: const TextStyle(fontSize: 20),
                // ),
                Text(
                  "Total Pengeluaran: ${controller.totalPemasukan.toString()}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Total Pengeluaran: ${controller.totalPengeluaran.toString()}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Total Seluruh Tabungan: ${controller.totalSemuaTabungan.toString()}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Total Investasi: ${controller.totalnvestasi.toString()}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  controller.nilaiKekayaan.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
