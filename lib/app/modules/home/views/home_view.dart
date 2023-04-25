import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor1,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left: 3.333.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Your code here
                  },
                  child: Stack(
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
                            "Y",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
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
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: grey400, fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "YUTA",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: buttonColor2, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 3.333.w),
              child: IconButton(
                icon: Iconify(
                  Ph.bell,
                  size: 20.sp,
                  color: grey400,
                ),
                onPressed: () {
                  // Your code here
                },
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor2,
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 7.7778.w),
          children: [
            // const CarouselHome(),
            Text(
              "#NUHA",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
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
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
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
                          style: Theme.of(context).textTheme.overline!.copyWith(
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
                  onTap: () => Get.toNamed('/cashflow'),
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
                          style: Theme.of(context).textTheme.overline!.copyWith(
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
              height: 3.h,
            ),
            Text(
              "Bingung mau mulai dari mana?",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: dark, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.h,
            ),
            InkWell(
              onTap: () {
                Get.toNamed('/perencanaan-keuangan');
              },
              child: Image(
                image: AssetImage('assets/images/banner_mulaisekarang.png'),
                width: 83.44444.w,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Anggaran Kamu",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: dark, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 1.h,
            ),
          ],
        ));
  }
}
