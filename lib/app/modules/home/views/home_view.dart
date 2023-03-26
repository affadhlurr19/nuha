import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/widgets/carousel_home.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

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
                Text(
                  'YUTA!',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: buttonColor1, fontWeight: FontWeight.w600),
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
          padding: EdgeInsets.symmetric(
            vertical: 2.5.h,
          ),
          children: [
            const CarouselHome(),
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.7778.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 25.83333.w,
                    height: 11.625.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text(
                        "Fincheck",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: buttonColor1),
                      ),
                      onPressed: () => Get.toNamed('/fincheck'),
                    ),
                  ),
                  SizedBox(
                    width: 3.333.w,
                  ),
                  SizedBox(
                    width: 25.83333.w,
                    height: 11.625.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text(
                        "Log Out",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: buttonColor1),
                      ),
                      onPressed: () => controller.logout(),
                    ),
                  ),
                  SizedBox(
                    width: 3.333.w,
                  ),
                  SizedBox(
                    width: 25.83333.w,
                    height: 11.625.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text(
                        "Cashflow",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: buttonColor1),
                      ),
                      onPressed: () => Get.toNamed('/cashflow'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
