import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/perencanaan_keuangan_controller.dart';

import 'package:nuha/app/widgets/field_currency.dart';
import 'package:nuha/app/widgets/field_number.dart';
import 'package:nuha/app/widgets/field_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class PkDaruratView extends GetView<PerencanaanKeuanganController> {
  PkDaruratView({Key? key}) : super(key: key);
  List statusItem = ["Belum Menikah", "Sudah Menikah"];
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
          Container(
            padding: EdgeInsets.only(top: 0.625.w),
            width: 100.w,
            height: 79.625.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.5.h,
                ),
                GradientText(
                  "Dana Darurat",
                  style: Theme.of(context).textTheme.displaySmall!,
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
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: grey400,
                      ),
                ),
                SizedBox(
                  height: 3.125.h,
                ),
                FieldText(
                    labelText: "Nama Dana Darurat",
                    contr: controller.namaDana,
                    hintText: "Masukkan nama dana darurat"),
                FieldCurrency(
                    labelText: "Pengeluaran Bulanan",
                    contr: controller.nomPengeluaran,
                    infoText: "infoText"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status Pernikahan",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grey900,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 0.75.h,
                    ),
                    Container(
                      height: 5.5.h,
                      width: 84.44444.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: grey100),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButton(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 4.583333.w),
                            child: Text(
                              "Pilih Status Pernikahan",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: grey400,
                                  ),
                            ),
                          ),
                          value: null,
                          isDense: true,
                          underline: const SizedBox(),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: grey400,
                          ),
                          onChanged: (value) {},
                          items: ["Belum Menikah", "Sudah Menikah"]
                              .map((String valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList()),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                  ],
                ),
                FieldNumber(
                    labelText: "Kapan Kamu Ingin Mencapai Target",
                    contr: controller.bulanTercapai,
                    hintText: "1"),
                FieldCurrency(
                    labelText: "Dana Yang Sudah Ada",
                    contr: controller.nomDanaTersedia,
                    infoText: "infoText")
              ],
            ),
          ),
          SizedBox(
            width: 100.w,
            child: Center(
              child: SizedBox(
                width: 84.1667.w,
                height: 5.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Hitung Dana",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
