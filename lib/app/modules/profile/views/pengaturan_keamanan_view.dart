import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class PengaturanKeamananView extends GetView {
  PengaturanKeamananView({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Pengaturan Keamanan',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: titleColor,
              ),
        ),
        iconTheme: const IconThemeData(color: titleColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      body: Column(
        children: [
          SizedBox(height: 2.25.h),
          Center(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: backgroundColor1,
              child:
                  auth.currentUser!.providerData[0].providerId == 'google.com'
                      ? SizedBox(
                          height: 14.475.h,
                          width: 84.4.w,
                          child: Column(
                            children: [
                              SizedBox(height: 2.5.h),
                              SizedBox(height: 1.h),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0XFFF1F1F1),
                                    ),
                                  ),
                                ),
                                width: widthDevice,
                                child: ListTile(
                                  trailing: const Iconify(
                                    Bi.chevron_right,
                                    size: 24,
                                    color: titleColor,
                                  ),
                                  title: Text(
                                    'Ganti PIN',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9.sp,
                                          color: titleColor,
                                        ),
                                  ),
                                  onTap: () => Get.toNamed(Routes.PIN,
                                      arguments: Routes.EDIT_PIN),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 20.475.h,
                          width: 84.4.w,
                          child: Column(
                            children: [
                              SizedBox(height: 2.5.h),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0XFFF1F1F1),
                                    ),
                                  ),
                                ),
                                width: widthDevice,
                                child: ListTile(
                                  trailing: const Iconify(
                                    Bi.chevron_right,
                                    size: 24,
                                    color: titleColor,
                                  ),
                                  title: Text(
                                    'Ganti Kata Sandi',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9.sp,
                                          color: titleColor,
                                        ),
                                  ),
                                  onTap: () => Get.toNamed(Routes.PIN,
                                      arguments: Routes.GANTI_KATA_SANDI),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0XFFF1F1F1),
                                    ),
                                  ),
                                ),
                                width: widthDevice,
                                child: ListTile(
                                  trailing: const Iconify(
                                    Bi.chevron_right,
                                    size: 24,
                                    color: titleColor,
                                  ),
                                  title: Text(
                                    'Ganti PIN',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9.sp,
                                          color: titleColor,
                                        ),
                                  ),
                                  onTap: () => Get.toNamed(Routes.PIN,
                                      arguments: Routes.EDIT_PIN),
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
