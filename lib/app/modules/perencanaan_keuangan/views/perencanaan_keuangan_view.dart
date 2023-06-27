import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_darurat_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_kendaraan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_pendidikan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_pensiun_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_pernikahan_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_rumah_view.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/views/pk_umroh_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

import '../controllers/perencanaan_keuangan_controller.dart';

class PerencanaanKeuanganView extends GetView<PerencanaanKeuanganController> {
  const PerencanaanKeuanganView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.875.h),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              color: dark,
            ),
            title: Text(
              "Perencanaan Keuangan",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: titleColor),
            ),
            backgroundColor: backgroundColor1,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        backgroundColor: backgroundColor1,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.91666.w),
          child: ListView(
            children: [
              SizedBox(
                height: 0.625.h,
              ),
              GradientText(
                "Rencanakan Keuangan Kamu Sekarang",
                style: Theme.of(context).textTheme.displayMedium!,
                colors: const [
                  buttonColor1,
                  buttonColor2,
                ],
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                "Perencanaan keuangan dapat membantu dalam pengelolaan keuangan dengan lebih bijak, mencapai tujuan keuangan jangka panjang, dan menghadapi situasi keuangan yang tidak terduga.",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: grey500, wordSpacing: 0.sp),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 3.125.h,
              ),
              Text("Silahkan Pilih Kategori Perencanaan Keuanganmu :",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: buttonColor1, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 1.25.h,
              ),
              Wrap(
                spacing: 4.166667.w,
                runSpacing: 2.5.h,
                children: [
                  CategoryPerencanaanWidget(
                    image: const AssetImage('assets/images/pk_darurat.png'),
                    onTap: () => Get.to(PkDaruratView()),
                    text: "Dana Darurat",
                  ),
                  CategoryPerencanaanWidget(
                      image: const AssetImage('assets/images/pk_pendidikan.png'),
                      onTap: () => Get.to(const PkPendidikanView()),
                      text: "Dana Pendidikan"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage('assets/images/pk_haji.png'),
                      onTap: () => Get.to(const PkUmrohView()),
                      text: "Dana Haji/Umroh"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage('assets/images/pk_pernikahan.png'),
                      onTap: () => Get.to(const PkPernikahanView()),
                      text: "Dana Pernikahan"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage('assets/images/pk_rumah.png'),
                      onTap: () => Get.to(const PkRumahView()),
                      text: "Dana Beli Rumah"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage('assets/images/pk_kendaraan.png'),
                      onTap: () => Get.to(const PkKendaraanView()),
                      text: "Dana Beli Kendaraan"),
                  CategoryPerencanaanWidget(
                      image: const AssetImage('assets/images/pk_pensiun.png'),
                      onTap: () => Get.to(const PkPensiunView()),
                      text: "Dana Pensiun"),
                ],
              ),
            ],
          ),
        ));
  }
}

class CategoryPerencanaanWidget extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final GestureTapCallback onTap;

  CategoryPerencanaanWidget(
      {Key? key, required this.image, required this.onTap, required this.text})
      : super(key: key);

  final PerencanaanKeuanganController controller =
      Get.put(PerencanaanKeuanganController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: image,
              width: 13.3333.w,

              // fit: BoxFit.cover,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
