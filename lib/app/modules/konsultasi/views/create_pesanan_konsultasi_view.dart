import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/controllers/order_constultation_controller.dart';
import 'package:sizer/sizer.dart';

class CreatePesananKonsultasiView
    extends GetView<OrderConstultationController> {
  CreatePesananKonsultasiView({Key? key}) : super(key: key);
  final c = Get.find<OrderConstultationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        leading: Container(
          width: 100,
          padding: EdgeInsets.only(left: 4.58.w),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Iconify(
              Mdi.arrow_left,
              size: 3.h,
              color: titleColor,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: titleColor,
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 2.98.w),
            child: IconButton(
              onPressed: () {},
              icon: Iconify(
                Ion.md_information_circle_outline,
                size: 3.h,
                color: titleColor,
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: 4.6.w),
          child: Text(
            'Ringkasan Pesanan',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: titleColor),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      backgroundColor: backgroundColor1,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<void>(
          future: c.getDetailData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: const Center(
                  child: CircularProgressIndicator(color: buttonColor1),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(
                                    c.consultationTransaction.consultantImg ??
                                        '',
                                    height: 8.625.h,
                                    width: 8.625.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.89.w),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      c.consultationTransaction
                                              .consultantName ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0XFF0D4136),
                                              fontSize: 13.sp),
                                    ),
                                    Text(
                                      c.consultationTransaction
                                              .consultantCategory ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: grey500,
                                              fontSize: 11.sp),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Iconify(
                                          Ic.sharp_access_time_filled,
                                          size: 10.sp,
                                          color: grey900,
                                        ),
                                        SizedBox(width: 1.w),
                                        Text(
                                          DateFormat(
                                                  'EEEE d MMM yyyy, ', 'id_ID')
                                              .format(c.consultationTransaction
                                                  .consultationStartDate),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: grey900,
                                                  fontSize: 10.sp),
                                        ),
                                        Text(
                                          c.consultationTransaction
                                                  .fixScheduleTime ??
                                              '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: grey900,
                                                  fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    height: 7,
                    color: grey50,
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biaya Sesi 1 Jam',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                              .format(
                                  c.consultationTransaction.consultantPrice ??
                                      0)
                              .replaceAll(",00", ""),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.75.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biaya Layanan',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '+ Rp. 1.500',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.75.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                              .format(c.consultationTransaction.totalPrice ?? 0)
                              .replaceAll(",00", ""),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    height: 7,
                    color: grey50,
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      'Pilih Metode Pembayaran Anda',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.mandiriCard,
                      c.paymentMethodList[0],
                      'assets/images/logo-bank-mandiri.png',
                      'Bank Mandiri',
                      "Melalui Aplikasi Livin' By Mandiri:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n'
                          '6. \n',
                      "Buka aplikasi Livin' By Mandiri. \n"
                          'Pilih menu "Transfer Rupiah". \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Masukkan MPIN dan konfirmasi transfer. \n',
                      "Melalui ATM Mandiri:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Kunjungi mesin ATM Mandiri terdekat. \n"
                          'Masukkan kartu ATM Mandiri dan PIN. \n'
                          'Pilih menu "Transfer". \n'
                          'Pilih "Ke Rekening Mandiri". \n'
                          'Masukkan rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking Mandiri:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7.',
                      "Buka situs web Mandiri Internet Banking. \n"
                          'Masukkan username dan password. \n'
                          'Pilih menu "Transfer". \n'
                          'Masukkan rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.bcaCard,
                      c.paymentMethodList[1],
                      'assets/images/logo-bank-bca.png',
                      'Bank BCA',
                      "Melalui BCA mobile:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7 \n',
                      "Buka aplikasi BCA mobile. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui ATM BCA:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Masukkan kartu ATM BCA dan PIN. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking BCA:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7. \n'
                          '8. \n'
                          '9.',
                      "Buka situs web Internet Banking BCA. \n"
                          'Masuk ke akun Anda. \n'
                          'Pilih menu "Transfer Dana" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. ',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.bniCard,
                      c.paymentMethodList[2],
                      'assets/images/logo-bank-bni.png',
                      'Bank BNI',
                      "Melalui BNI Mobile Banking:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7 \n',
                      "Buka aplikasi BNI Mobile Banking. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui ATM BNI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Masukkan kartu ATM BNI dan PIN. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking BNI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7. \n'
                          '8. \n'
                          '9.',
                      "Buka situs web Internet Banking BNI. \n"
                          'Masuk ke akun Anda. \n'
                          'Pilih menu "Transfer Dana" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. ',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: c.paymentMethodDetails(
                      context,
                      c.briCard,
                      c.paymentMethodList[3],
                      'assets/images/logo-bank-bri.png',
                      'Bank BRI',
                      "Melalui Aplikasi BRImo BRI:",
                      '1. \n'
                          '2. \n'
                          '3. \n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n'
                          '7 \n',
                      "Buka aplikasi BRImo BRI. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui ATM BRI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n'
                          '5. \n\n'
                          '6. \n'
                          '7. \n'
                          '8. \n',
                      "Masukkan kartu ATM BRI dan PIN. \n"
                          'Pilih menu "Transfer" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. \n',
                      "Melalui Internet Banking BRI:",
                      '1. \n'
                          '2. \n'
                          '3. \n\n'
                          '4. \n\n'
                          '5. \n'
                          '6. \n\n'
                          '7. \n'
                          '8. \n'
                          '9.',
                      "Buka situs web Internet Banking BRI. \n"
                          'Masuk ke akun Anda. \n'
                          'Pilih menu "Transfer Dana" atau "Transfer antarbank". \n'
                          'Pilih "Transfer ke Bank Lain" atau "Transfer ke Bank Lain dalam Negeri". \n'
                          'Pilih bank tujuan (Mandiri). \n'
                          'Masukkan nomor rekening tujuan, yaitu 0123456789 a.n. Nuha Financial. \n'
                          'Masukkan nominal transfer. \n'
                          'Verifikasi detail transfer. \n'
                          'Konfirmasikan transfer. ',
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 135,
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 1.5.h,
          horizontal: 3.w,
        ),
        decoration: const BoxDecoration(
          color: backgroundColor1,
          boxShadow: [
            BoxShadow(
              color: grey400,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pembayaran Anda',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: grey400),
                ),
                SizedBox(height: 0.5.h),
                Obx(
                  () => Text(
                    NumberFormat.currency(locale: 'id', symbol: 'Rp. ')
                        .format(c.totalFixedPrice.value)
                        .replaceAll(",00", ""),
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Obx(
              () => c.isPaymentMethodSelected.isTrue
                  ? SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (c.isLoading.isFalse) {
                            c.dialogMessage();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor1,
                        ),
                        child: c.isLoading.isFalse
                            ? Text(
                                'Pesan Sekarang',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: backgroundColor1),
                              )
                            : SizedBox(
                                height: 1.5.h,
                                width: 1.5.h,
                                child: const CircularProgressIndicator(
                                  color: backgroundColor1,
                                ),
                              ),
                      ),
                    )
                  : SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: grey400,
                          foregroundColor: grey400,
                          disabledBackgroundColor: grey400,
                          disabledForegroundColor: grey400,
                        ),
                        child: c.isLoading.isFalse
                            ? Text(
                                'Pesan Sekarang',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: backgroundColor1),
                              )
                            : SizedBox(
                                height: 1.5.h,
                                width: 1.5.h,
                                child: const CircularProgressIndicator(
                                  color: backgroundColor1,
                                ),
                              ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
