import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gridicons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/views/transaksi_create_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class TransaksiEditView extends GetView<CashflowController> {
  final String id;

  const TransaksiEditView({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor2,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Edit Transaksi",
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
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                onPressed: () => PersistentNavBarNavigator.pushDynamicScreen(
                    context,
                    screen: showDeleteTransaksiById(context, id)),
                icon: Icon(
                  Icons.delete,
                  size: 18.sp,
                  color: titleColor,
                ))
          ],
          backgroundColor: backgroundColor1,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: FutureBuilder<Map<String, dynamic>?>(
          future: controller.getTransaksiById(id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("Tidak dapat mengambil informasi data"),
              );
            } else {
              controller.jenisC.value = snapshot.data!["jenisTransaksi"];
              controller.namaTransaksiC.text = snapshot.data!["namaTransaksi"];
              controller.kategoriC.value = snapshot.data!["kategori"];
              controller.nominalTransaksiC.text =
                  snapshot.data!["nominal"].toString();
              controller.deskripsiC.text = snapshot.data?["deskripsi"];

              DateTime dateTime = DateFormat('dd MMMM yyyy')
                  .parse(snapshot.data?["tanggalTransaksi"]);

              controller.selectDate.value = dateTime;
              // controller.image.name = snapshot.data?["foto"];
              // print(controller.image);

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: backgroundColor1),
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
                        Text(
                          "Jenis Transaksi*",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: grey900,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(
                          height: 0.75.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              radius: 25,
                              title: "Pilih Jenis Transaksi",
                              titleStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: grey900,
                                      fontWeight: FontWeight.w600),
                              content: DialogContent(),
                            );
                          },
                          child: Container(
                            height: 5.5.h,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.sp, color: grey100),
                                borderRadius: BorderRadius.circular(20),
                                color: backgroundColor1),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.53333.w,
                                vertical: 1.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => Text(
                                        controller.jenisC.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: grey900,
                                            ),
                                      )),
                                  Iconify(
                                    Gridicons.dropdown,
                                    size: 18.sp,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nama Transaksi*",
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
                            controller: controller.namaTransaksiC,
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: grey900,
                                    ),
                            decoration: InputDecoration(
                              hintText: "Masukan Nama Transaksi",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: grey400,
                                  ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.53333.w,
                                vertical: 1.h,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(width: 1.sp, color: grey100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                    color: buttonColor1, width: 1.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nominal Transaksi*",
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
                            controller: controller.nominalTransaksiC,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              CurrencyTextInputFormatter(
                                locale: 'id',
                                decimalDigits: 0,
                                symbol: '',
                              ),
                            ],
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              hintText: "0",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: grey400,
                                  ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 1.w, vertical: 1.h),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: grey400,
                                      fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(color: grey100, width: 1.sp),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                    color: buttonColor1, width: 1.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
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
                              Get.bottomSheet(
                                controller.jenisC.value == "Pengeluaran"
                                    ? const BottomSheetPengeluaran()
                                    : const BottomSheetPendapatan(),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.53333.w,
                                vertical: 1.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.kategoriC.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: grey900,
                                          )),
                                  Iconify(
                                    Gridicons.dropdown,
                                    size: 18.sp,
                                    color: grey900,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tanggal*",
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
                              controller.chooseDate();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.53333.w,
                                vertical: 1.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => Text(
                                        DateFormat("dd-MM-yyyy").format(
                                            controller.selectDate.value),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: grey900,
                                            ),
                                      )),
                                  Iconify(
                                    MaterialSymbols.calendar_month,
                                    size: 18.sp,
                                    color: grey900,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: grey900,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(
                          height: 0.75.h,
                        ),
                        SizedBox(
                          height: 14.875.h,
                          child: TextField(
                            controller: controller.deskripsiC,
                            minLines: 5,
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: grey900,
                                    ),
                            decoration: InputDecoration(
                              hintText: "Tulis deskripsi...",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    color: grey400,
                                  ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.53333.w,
                                vertical: 1.h,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(width: 1.sp, color: grey100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                    color: buttonColor1, width: 1.sp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Unggah Foto",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: grey900,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(
                          height: 0.75.h,
                        ),
                        GetBuilder<CashflowController>(
                          builder: (c) {
                            return c.image != null
                                ? Stack(
                                    children: <Widget>[
                                      Container(
                                        width: 75.55556.w,
                                        height: 14.875.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.sp, color: grey100),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: backgroundColor1),
                                        child: FullScreenWidget(
                                          disposeLevel: DisposeLevel.Medium,
                                          child: Image(
                                            fit: BoxFit.fitWidth,
                                            image: FileImage(
                                              File(c.image!.path),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () =>
                                              c.resetImageTransaksi(),
                                          icon: Iconify(
                                            MaterialSymbols
                                                .cancel_outline_rounded,
                                            size: 20.sp,
                                            color: backgroundColor2,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : snapshot.data?["foto"] != ""
                                    ? Stack(
                                        children: <Widget>[
                                          Container(
                                            width: 75.55556.w,
                                            height: 14.875.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.sp,
                                                    color: grey100),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: backgroundColor1),
                                            child: FullScreenWidget(
                                              disposeLevel: DisposeLevel.Medium,
                                              child: Image(
                                                fit: BoxFit.fitWidth,
                                                image: NetworkImage(
                                                    snapshot.data!["foto"]),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                              onPressed: () =>
                                                  Get.defaultDialog(
                                                radius: 25,
                                                title: "Unggah Foto",
                                                titleStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: grey900,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                content: DialogCamera(),
                                              ),
                                              icon: Iconify(
                                                MaterialSymbols.edit,
                                                size: 20.sp,
                                                color: grey100,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () => Get.defaultDialog(
                                          radius: 25,
                                          title: "Unggah Foto",
                                          titleStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: grey900,
                                                  fontWeight: FontWeight.w600),
                                          content: DialogCamera(),
                                        ),
                                        child: Container(
                                          height: 11.375.h,
                                          width: 75.55556.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1.sp, color: grey100),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: backgroundColor1),
                                          child: Center(
                                            child: Iconify(
                                              MaterialSymbols.photo_sharp,
                                              size: 18.sp,
                                              color: grey400,
                                            ),
                                          ),
                                        ),
                                      );
                          },
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 75.55556.w,
                      height: 5.5.h,
                      child: Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: buttonColor2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Text(
                              controller.isLoading.isFalse
                                  ? "Simpan"
                                  : "Loading...",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: backgroundColor1),
                            ),
                            // onPressed: () => print(snapshot.data?["foto"]),
                            onPressed: () {
                              if (controller.isLoading.isFalse) {
                                controller.updateTransaksiById(
                                    context, id.toString());
                              }
                            },
                          )),
                    ),
                  ],
                ),
              );
            }
          },
        )));
  }
}

showDeleteTransaksiById(BuildContext context, docId) {
  final controller = Get.find<CashflowController>();
  // set up the buttons
  Widget batalButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(width: 1, color: buttonColor2),
        backgroundColor: backgroundColor1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Text(
      "Batal",
      style:
          Theme.of(context).textTheme.bodyText2!.copyWith(color: buttonColor2),
    ),
    onPressed: () => Navigator.pop(context),
  );
  Widget yaButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(
        "Ya",
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: backgroundColor1),
      ),
      onPressed: () {
        // print(docId);
        if (controller.isLoading.isFalse) {
          controller.deleteTransaksiById(context, docId);
        }
      });

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Apakah kamu yakin ingin menghapus transaksi ini?",
      style: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: grey900, fontWeight: FontWeight.w600),
    ),
    titlePadding: EdgeInsets.fromLTRB(7.777778.w, 3.5.h, 7.777778.w, 0.25.h),
    content: Text(
      "Dengan menyetujui ini, maka transaksi ini akan terhapus secara permanen. Apakah kamu yakin?",
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: grey400,
          ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 7.777778.w,
    ),
    actions: [
      batalButton,
      yaButton,
    ],
  );
  // show the dialog

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
