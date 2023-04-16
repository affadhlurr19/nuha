import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/views/transaksi_create_view.dart';
import 'package:nuha/app/modules/cashflow/views/transaksi_edit_view.dart';
import 'package:sizer/sizer.dart';
import '../controllers/cashflow_controller.dart';

class TransaksiView extends GetView<CashflowController> {
  TransaksiView({Key? key}) : super(key: key);

  @override
  final CashflowController controller = Get.put(CashflowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      floatingActionButton: SizedBox(
        // width: 35.sp,
        // height: 35.sp,
        width: 12.96389.w, height: 5.83375.h,
        child: FloatingActionButton(
          backgroundColor: buttonColor1,
          foregroundColor: backgroundColor2,
          elevation: 0,
          onPressed: () => Get.to(FormTransaksiView()),
          child: Icon(
            Icons.add,
            size: 23.sp,
          ),
        ),
      ),
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
                  "Transaksi",
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
                                Obx(() => Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: "Rp. ",
                                              decimalDigits: 0)
                                          .format(
                                              controller.totalPendapatan.value),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              color: const Color(0XFF0096C7),
                                              fontWeight: FontWeight.w600),
                                    ))
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
                                Obx(() => Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: "Rp. ",
                                              decimalDigits: 0)
                                          .format(controller
                                              .totalPengeluaran.value),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              color: const Color(0XFFCC444B),
                                              fontWeight: FontWeight.w600),
                                    ))
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
                      controller: controller.searchTransaksiC,
                      onChanged: (value) => controller.searchTransaksi(value),
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
                  GetBuilder<CashflowController>(
                    init: CashflowController(),
                    initState: (_) {},
                    builder: (_) {
                      return SizedBox(
                        height: 60.75.h,
                        child: _.searchTransaksiC.text.isEmpty
                            ? DataViewWidget()
                            : Obx(() => SizedBox(
                                  child: controller.tempSearch.isEmpty
                                      ? Center(
                                          child: Text("data tidak ada"),
                                        )
                                      : MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          child: ListView.builder(
                                            itemCount:
                                                controller.tempSearch.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image(
                                                            width: 10.55556.w,
                                                            image: AssetImage(
                                                                'assets/images/${controller.tempSearch[index]["kategori"]}.png'),
                                                          ),
                                                          SizedBox(
                                                            width: 4.44444.w,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${controller.tempSearch[index]["namaTransaksi"]}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color:
                                                                          dark,
                                                                    ),
                                                              ),
                                                              Text(
                                                                controller.tempSearch[index]
                                                                            [
                                                                            "jenisTransaksi"] ==
                                                                        "Pengeluaran"
                                                                    ? NumberFormat.currency(
                                                                            locale:
                                                                                'id',
                                                                            symbol:
                                                                                "- ",
                                                                            decimalDigits:
                                                                                0)
                                                                        .format(controller.tempSearch[index]
                                                                            [
                                                                            "nominal"])
                                                                    : NumberFormat.currency(
                                                                            locale:
                                                                                'id',
                                                                            symbol:
                                                                                "+ ",
                                                                            decimalDigits:
                                                                                0)
                                                                        .format(
                                                                            controller.tempSearch[index]["nominal"]),
                                                                style: controller.tempSearch[index]
                                                                            [
                                                                            "jenisTransaksi"] ==
                                                                        "Pengeluaran"
                                                                    ? Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .caption!
                                                                        .copyWith(
                                                                          color:
                                                                              const Color(0XFFCC444B),
                                                                        )
                                                                    : Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(
                                                                          color:
                                                                              const Color(0XFF0096C7),
                                                                        ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      IconButton(
                                                        onPressed: () => Get.to(
                                                            const TransaksiEditView(),
                                                            arguments: controller
                                                                    .tempSearch[
                                                                index]["id"]),
                                                        icon: Iconify(
                                                          MaterialSymbols.edit,
                                                          size: 12.sp,
                                                          color: grey400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                    height: 0,
                                                    color: grey100,
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                )),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DataViewWidget extends StatelessWidget {
  DataViewWidget({super.key});

  final CashflowController controller = Get.put(CashflowController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.44444.w),
      height: 60.75.h,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamSemuaTransaksi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return SizedBox(
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
                    "Kamu belum melakukan pencatatan transaksi, nih. Yuk, catat transaksi dan pantau alur keuanganmu dengan mudah~",
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
                        "Tambah transaksi sekarang",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: backgroundColor1),
                      ),
                      onPressed: () => Get.to(FormTransaksiView()),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var docTransaksi = snapshot.data!.docs[index];
                    Map<String, dynamic> transaksi = docTransaksi.data();
                    // print(transaksi);
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  width: 10.55556.w,
                                  image: AssetImage(
                                      'assets/images/${transaksi["kategori"]}.png'),
                                ),
                                SizedBox(
                                  width: 4.44444.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${transaksi["namaTransaksi"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: dark,
                                          ),
                                    ),
                                    Text(
                                      transaksi["jenisTransaksi"] ==
                                              "Pengeluaran"
                                          ? NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "- ",
                                                  decimalDigits: 0)
                                              .format(transaksi["nominal"])
                                          : NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "+ ",
                                                  decimalDigits: 0)
                                              .format(transaksi["nominal"]),
                                      style: transaksi["jenisTransaksi"] ==
                                              "Pengeluaran"
                                          ? Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                color: const Color(0XFFCC444B),
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: const Color(0XFF0096C7),
                                              ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () => Get.to(const TransaksiEditView(),
                                  arguments: docTransaksi.id),
                              icon: Iconify(
                                MaterialSymbols.edit,
                                size: 12.sp,
                                color: grey400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        const Divider(
                          thickness: 1,
                          height: 0,
                          color: grey100,
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ],
                    );
                  },
                ));
          }
        },
      ),
    );
  }
}
