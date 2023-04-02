import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF8F8F8),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: buttonColor1),
            );
          }
          return SingleChildScrollView(
            child: Stack(children: <Widget>[
              // Background with gradient
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [buttonColor1, buttonColor2],
                  ),
                ),
                height: 38.25.h,
              ),
              //Content
              Column(
                children: <Widget>[
                  SizedBox(height: 12.125.h),
                  Center(
                    child: SizedBox(
                      height: 10.h,
                      width: 10.h,
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Center(
                    child: Text(
                      snapshot.data!["name"],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: backgroundColor1,
                          ),
                    ),
                  ),
                  Center(
                    child: Text(
                      snapshot.data!["email"],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            color: backgroundColor1,
                          ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: backgroundColor1,
                    child: SizedBox(
                      height: 32.975.h,
                      width: 84.4.w,
                      child: Column(
                        children: [
                          SizedBox(height: 2.5.h),
                          Container(
                            width: widthDevice,
                            padding: EdgeInsets.symmetric(horizontal: 4.4.w),
                            child: Text(
                              'Pengaturan Akun',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0XFF1F1F1F),
                                    fontSize: 11.sp,
                                  ),
                            ),
                          ),
                          SizedBox(height: 1.5.h),
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
                              leading: FlutterLogo(size: 18.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                              ),
                              title: Text(
                                'Edit Akun',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: const Color(0XFF1F1F1F),
                                    ),
                              ),
                              onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
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
                              leading: FlutterLogo(size: 18.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                              ),
                              title: Text(
                                'Upgrade Akun',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: const Color(0XFF1F1F1F),
                                    ),
                              ),
                              onTap: () {},
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
                              leading: FlutterLogo(size: 18.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                              ),
                              title: Text(
                                'Pengaturan Keamanan',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: const Color(0XFF1F1F1F),
                                    ),
                              ),
                              onTap: () =>
                                  Get.toNamed(Routes.PENGATURAN_KEAMANAN),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: backgroundColor1,
                    child: SizedBox(
                      height: 40.925.h,
                      width: 84.4.w,
                      child: Column(
                        children: [
                          SizedBox(height: 2.5.h),
                          Container(
                            width: widthDevice,
                            padding: EdgeInsets.symmetric(horizontal: 4.4.w),
                            child: Text(
                              'Informasi',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0XFF1F1F1F),
                                    fontSize: 11.sp,
                                  ),
                            ),
                          ),
                          SizedBox(height: 1.5.h),
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
                              leading: FlutterLogo(size: 18.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                              ),
                              title: Text(
                                'Bantuan',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: const Color(0XFF1F1F1F),
                                    ),
                              ),
                              onTap: () {},
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
                              leading: FlutterLogo(size: 18.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                              ),
                              title: Text(
                                'Syarat & Ketentuan',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: const Color(0XFF1F1F1F),
                                    ),
                              ),
                              onTap: () {},
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
                              leading: FlutterLogo(size: 18.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                              ),
                              title: Text(
                                'Hubungi Kami',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: const Color(0XFF1F1F1F),
                                    ),
                              ),
                              onTap: () {},
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
                              leading: FlutterLogo(size: 18.sp),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                              ),
                              title: Text(
                                'Hapus Akun',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 9.sp,
                                      color: const Color(0XFF1F1F1F),
                                    ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.53125.h),                  
                  Container(
                    padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                    child: SizedBox(
                      width: 38.89.w,
                      height: 5.5.h,
                      child: auth.currentUser!.providerData[0].providerId ==
                              'google.com'
                          ? Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: buttonColor1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: controller.isLoading.isFalse
                                    ? Text(
                                        "Logout",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                                color: Colors.white,
                                                fontStyle: FontStyle.normal),
                                      )
                                    : SizedBox(
                                        height: 1.5.h,
                                        width: 1.5.h,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                onPressed: () {
                                  if (controller.isLoading.isFalse) {
                                    controller.logoutGoogle();
                                  }
                                },
                              ),
                            )
                          : Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: buttonColor1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: controller.isLoading.isFalse
                                    ? Text(
                                        "Logout",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                                color: Colors.white,
                                                fontStyle: FontStyle.normal),
                                      )
                                    : SizedBox(
                                        height: 1.5.h,
                                        width: 1.5.h,
                                        child: const CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                onPressed: () {
                                  if (controller.isLoading.isFalse) {
                                    controller.logout();
                                  }
                                },
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 3.53125.h),
                ],
              ),
              // Positioned to take only AppBar size
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text(
                    "Profil",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: backgroundColor1,
                        ),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
