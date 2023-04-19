import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/perencanaan_keuangan_controller.dart';
import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:nuha/app/widgets/field_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class PkPendidikanView extends GetView<PerencanaanKeuanganController> {
  const PkPendidikanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.875.h),
        child: AppBar(
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
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 7.778.w,
          ),
          children: [
            GradientText(
              "Dana Pendidikan",
              style: Theme.of(context).textTheme.headline3!,
              colors: const [
                buttonColor1,
                buttonColor2,
              ],
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              "(Jika tidak ada, ketika 0)",
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: grey400,
                  ),
            ),
            SizedBox(
              height: 3.125.h,
            ),
            FieldText(
                labelText: "Nama Anak",
                contr: controller.namaAnak,
                hintText: "Masukkan nama anak"),
            FieldNumber(
                labelText: "Umur Anak",
                contr: controller.umurAnak,
                hintText: "Masukkan umur anak"),
            FieldNumber(
                labelText: "Umur Anak Masuk Sekolah",
                contr: controller.umurAnakMasuk,
                hintText: "Masukkan umur anak saat masuk sekolah"),
            FieldCurrency(
                labelText: "Total Biaya Pendidikan",
                contr: controller.nomBiayaPendidikan,
                infoText: "infoText"),
            FieldCurrency(
                labelText: "Dana Yang Sudah Ada",
                contr: controller.nomDanaTersedia,
                infoText: "infoText")
          ],
        ),
      ),
    );
  }
}
