import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';
import '../controllers/cashflow_controller.dart';

class CashflowView extends GetView<CashflowController> {
  const CashflowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [buttonColor1, buttonColor2],
                ),
              ),
              height: 16.625.h,
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                // Add AppBar here only
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  "Anggaran",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: backgroundColor1,
                      ),
                ),
                actions: [
                  IconButton(
                    icon: const Iconify(
                      MaterialSymbols.download,
                      color: backgroundColor1,
                    ),
                    onPressed: () {
                      // action when search icon is pressed
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7.77778.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 13.25.h,
                  ),
                  Container(
                    width: 84.4444.w,
                    height: 6.75.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: backgroundColor1),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 12.7778.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 1.125.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Iconify(
                                      MaterialSymbols.arrow_downward_rounded,
                                      size: 9.sp,
                                      color: const Color(0XFF0096C7),
                                    ),
                                    SizedBox(
                                      width: 1.1111.w,
                                    ),
                                    Text(
                                      "Pendapatan",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: grey400),
                                    )
                                  ],
                                ),
                                Text(
                                  "Rp. 0",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: const Color(0XFF0096C7),
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.75.h,
                            child: VerticalDivider(
                              width: 8.3333.w,
                              thickness: 1,
                              color: grey50,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 1.125.h),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Iconify(
                                      MaterialSymbols.arrow_upward_rounded,
                                      size: 9.sp,
                                      color: const Color(0XFFCC444B),
                                    ),
                                    SizedBox(
                                      width: 1.1111.w,
                                    ),
                                    Text(
                                      "Pengeluaran",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: grey400),
                                    )
                                  ],
                                ),
                                Text(
                                  "Rp. 0",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: const Color(0XFFCC444B),
                                          fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    height: 4.5.h,
                    child: TextField(
                      textAlign: TextAlign.left,
                      // textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: grey900,
                          ),
                      decoration: InputDecoration(
                        fillColor: grey50,
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(2.222.w, 1.25.h, 0, 1.25.h),
                        suffixIcon: IconButton(
                          icon: const Iconify(
                            Uil.search,
                            color: grey400,
                          ),
                          onPressed: () {},
                          iconSize: 12.sp,
                        ),
                        suffixIconColor: grey400,
                        hintText: "Cari transaksi kamu disini",
                        hintStyle:
                            Theme.of(context).textTheme.caption!.copyWith(
                                  color: grey400,
                                ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 37.5.w,
                        height: 3.5.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: buttonColor1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "Semua Transaksi",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: backgroundColor1),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 37.5.w,
                        height: 3.5.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: grey50,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            "Kategori Transaksi",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: grey400),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 51.25.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 12.1875.h,
                        ),
                        Image.asset(
                          'assets/images/no_records_1.png',
                          width: 40.w,
                          height: 14.125.h,
                        ),
                        Text(
                          "Kamu belum mengatur anggaran keuangan kamu, nih. Yuk, catat anggaran keuanganmu dengan mudah~",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: grey400),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        SizedBox(
                          width: 50.27778.w,
                          height: 4.25.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: buttonColor2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Text(
                              "Atur Anggaran Sekarang",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: backgroundColor1),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
