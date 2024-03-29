import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/views/anggaran_create_view.dart';
import 'package:nuha/app/modules/cashflow/views/laporankeuangan_view.dart';
import 'package:nuha/app/modules/profile/controllers/profile_controller.dart';
import 'package:nuha/app/modules/zis/views/zis_view.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/utility/result_state.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';
import 'package:iconify_flutter/icons/ic.dart';
import '../controllers/home_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final HomeController co = Get.put(HomeController());
  final ProfileController c = Get.find<ProfileController>();
  final CashflowController con = Get.put(CashflowController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        title: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: c.streamProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Container();
            }

            Map<String, dynamic>? data = snapshot.data!.data();
            String sentence = data?["name"];
            List<String> words = sentence.split(" ");
            String firstName = words[0]; // Output: This
            return Padding(
              padding: EdgeInsets.only(left: 3.333.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: data?["profile"] != null
                        ? ClipOval(
                            child: Image.network(
                              snapshot.data!["profile"].toString(),
                              width: 23.sp,
                              height: 23.sp,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Stack(
                            children: [
                              Center(
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/jade_lemon.png',
                                    width: 23.sp,
                                    height: 23.sp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Center(
                                  child: Text(
                                    data!["name"][0],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: backgroundColor1,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  SizedBox(
                    width: 3.3333.w,
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "SALAAM, ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: grey400, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: firstName.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: buttonColor2,
                                  fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(right: 3.333.w),
        //     child: IconButton(
        //       icon: Iconify(
        //         Ph.bell,
        //         size: 20.sp,
        //         color: grey400,
        //       ),
        //       onPressed: () => Get.to(const ZisView()),
        //     ),
        //   ),
        // ],
      ),
      backgroundColor: backgroundColor2,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.7778.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const CarouselHome(),
            Text(
              "#NUHA",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: dark, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Get.toNamed("/perencanaan-keuangan"),
                  child: Container(
                    width: 25.8333.w,
                    height: 11.5.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: backgroundColor1),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.196667.w,
                      vertical: 1.5.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: const AssetImage('assets/images/home_pk.png'),
                          height: 23.sp,
                        ),
                        Center(
                          child: Text(
                            "Perencanaan Keuangan",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: grey500,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0,
                                  height: 0,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/fincheck'),
                  child: Container(
                    width: 25.8333.w,
                    height: 11.5.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: backgroundColor1),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.196667.w,
                      vertical: 1.5.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: const AssetImage('assets/images/home_cku.png'),
                          height: 23.sp,
                        ),
                        Text(
                          "Cek Kesehatan Keuangan",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: grey500,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    height: 0,
                                  ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/daftar-lembaga'),
                  child: Container(
                    width: 25.83333.w,
                    height: 11.5.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: backgroundColor1),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.196667.w,
                      vertical: 1.5.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: const AssetImage('assets/images/home_dlt.png'),
                          height: 23.sp,
                        ),
                        Text(
                          "Daftar Lembaga Terpercaya",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: grey500,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0,
                                    height: 0,
                                  ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Bagi Berkah, Berbagi Kasih",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: dark, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.h,
            ),
            Stack(children: [
              InkWell(
                onTap: () {
                  Get.to(const ZisView());
                },
                child: Image(
                  image: const AssetImage('assets/images/banner_zis.png'),
                  width: 83.44444.w,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(27.w, 4.5.h, 1.h, 0),
                // child: Text(
                //   "Rekomendasi nominal zakat: ${controller.rekomendasiZakat}",
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodySmall!
                //       .copyWith(color: Colors.white),
                // ),
                child: Obx(() => Text(
                      NumberFormat.currency(
                              locale: 'id',
                              symbol: "Rekomendasi nominal zakat Rp",
                              decimalDigits: 0)
                          .format(controller.rekomendasiZakat.value),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white, letterSpacing: 0.2),
                    )),
              ),
            ]),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Atur Keuanganmu",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: dark, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.h,
            ),
            Obx(() => Container(
                width: 84.4444.w,
                height: 20.75.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: backgroundColor1),
                child: controller.dataAnggaran.value != 0
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.4444.w, vertical: 1.875.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Laporan Keuangan",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: buttonColor1,
                                                fontWeight: FontWeight.w600,
                                                height: 1.25),
                                      ),
                                      Text(
                                        "Cek laporan keuanganmu disini!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: grey400, height: 1.3),
                                      ),
                                    ],
                                  ),
                                  Iconify(
                                    Ic.sharp_arrow_forward_ios,
                                    size: 15.sp,
                                    color: buttonColor1,
                                  ),
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: Get.context!,
                                    builder: (_) {
                                      return Dialog(
                                        // The background color
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // The loading indicator
                                              const CircularProgressIndicator(
                                                color: buttonColor1,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              // Some text
                                              Text('Tunggu sebentar...',
                                                  style: Theme.of(Get.context!)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: grey900,
                                                      ))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                Future.delayed(const Duration(seconds: 2), () {
                                  Get.back(); // Tutup dialog "Tunggu sebentar"
                                  Get.to(() =>
                                      LaporankeuanganView()); // Pindah ke halaman LaporanKeuanganView()
                                });
                              },
                            ),
                            const Divider(),
                            Text(
                              "Anggaran",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: grey900,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25),
                            ),
                            Obx(() => Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: double.parse(con
                                                      .persenAnggaran.value) >
                                                  1.0
                                              ? "Melebihi anggaran sebesar Rp"
                                              : "Sisa anggaran kamu Rp",
                                          decimalDigits: 0)
                                      .format(con.sisaAnggaran.value),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: grey400, height: 1.3),
                                )),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Obx(() => LinearPercentIndicator(
                                  barRadius: const Radius.circular(40),
                                  // width: 75.55556.w,
                                  lineHeight: 2.5.h,
                                  percent: double.parse(
                                              con.persenAnggaran.value) <
                                          0.0
                                      ? 0.0
                                      : double.parse(con.persenAnggaran.value) >
                                              1.0
                                          ? 1.0
                                          : double.parse(
                                              con.persenAnggaran.value),
                                  backgroundColor: backBar,
                                  progressColor: con.getProgressColor(
                                      double.parse(con.persenAnggaran.value)),
                                ))
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  child: Text(
                                    "Yuk, catat anggaran keuanganmu dengan mudah~",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: grey500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/no_records_1.png',
                                  width: 32.w,
                                  height: 14.125.h,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50.27778.w,
                              height: 4.25.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: buttonColor2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Text(
                                  "Atur Anggaran Sekarang",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: backgroundColor1),
                                ),
                                onPressed: () =>
                                    PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: FormAnggaranView()),
                              ),
                            ),
                          ],
                        ),
                      ))),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Informasi",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: dark, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              height: 20.h,
              child: FutureBuilder<dynamic>(
                future: co.fetchArticleInformation(),
                builder: (context, snapshot) {
                  return Obx(
                    () {
                      switch (co.resultState.value.status) {
                        case ResultStatus.loading:
                          return const Center(
                            child: CircularProgressIndicator(
                              color: buttonColor1,
                            ),
                          );
                        case ResultStatus.hasData:
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var data = co.result.data[index];
                              return GestureDetector(
                                onTap: () => Get.toNamed(Routes.DETAIL_ARTIKEL,
                                    arguments: data.id.toString()),
                                child: Container(
                                  margin: EdgeInsets.only(right: 3.w),
                                  width: 75.83333.w,
                                  height: 19.125.h,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: backgroundColor1),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 10.h,
                                        width: 75.83333.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: data.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.44444.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 1.h),
                                            Text(
                                              data.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: dark,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0.5),
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Text(
                                              timeago.format(data.publishedAt,
                                                  locale: 'id'),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: grey500,
                                                      letterSpacing: 0),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        case ResultStatus.noData:
                          return const Text('Data Kosong');
                        case ResultStatus.error:
                          return Text(co.message);
                        default:
                          return const SizedBox();
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
