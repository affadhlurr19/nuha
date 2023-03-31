import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/views/form_transaksi_view.dart';
import 'package:sizer/sizer.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class FormAnggaranView extends GetView<CashflowController> {
  const FormAnggaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tambah Anggaran",
          style: Theme.of(context).textTheme.button!.copyWith(
                color: dark,
              ),
        ),
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
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: backgroundColor1),
        margin: EdgeInsets.symmetric(
          horizontal: 7.77778.w,
          vertical: 3.5.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.55556.w,
          vertical: 2.5.h,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kategori*",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: grey900,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 0.75.h,
                    ),
                    Container(
                      height: 5.5.h,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.sp, color: grey100),
                          borderRadius: BorderRadius.circular(20),
                          color: backgroundColor1),
                      child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(const BottomSheetPengeluaran());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.53333.w,
                            vertical: 1.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(controller.kategoriC.toString(),
                                    style: controller.kategoriStat.value ==
                                            "choosen"
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: grey900,
                                            )
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: grey400)),
                              ),
                              Iconify(
                                Gridicons.dropdown,
                                size: 18.sp,
                                color:
                                    controller.kategoriStat.value == "choosen"
                                        ? grey900
                                        : grey400,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nominal Anggaran*",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: grey900,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 0.75.h,
                    ),
                    SizedBox(
                      height: 5.5.h,
                      child: TextField(
                        controller: controller.nomAnggaranC,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            locale: 'id',
                            decimalDigits: 0,
                            symbol: '',
                          ),
                        ],
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: grey900,
                            ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.5833.w, vertical: 1.h),
                            child: Text(
                              "Rp. ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: grey400),
                            ),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                          hintText: "0",
                          hintStyle:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: grey400,
                                  ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(
                                  color: grey400, fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(color: grey100, width: 1.sp),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide:
                                BorderSide(color: buttonColor1, width: 1.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 41.125.h,
                ),
                SizedBox(
                  width: 75.55556.w,
                  height: 5.5.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: buttonColor2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text(
                      "Simpan",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: backgroundColor1),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
