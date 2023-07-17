import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';

class BantuanView extends GetView {
  const BantuanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Bantuan',
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
      body: const Center(
        child: Text(
          'BantuanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
