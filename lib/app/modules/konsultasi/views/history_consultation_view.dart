import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/controllers/history_consultation_controller.dart';
import 'package:sizer/sizer.dart';

class HistoryConsultationView extends GetView<HistoryConsultationController> {
  HistoryConsultationView({Key? key}) : super(key: key);
  final c = Get.find<HistoryConsultationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
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
        title: Text(
          'Riwayat Konsultasi',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      body: AnimationLimiter(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 1.875.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => ChipsChoice.single(
                      spacing: 3.3.w,
                      wrapped: true,
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      value: c.tag.value,
                      onChanged: (val) {
                        c.tag.value = val;
                      },
                      choiceItems: const <C2Choice>[
                        C2Choice(value: 1, label: 'Belum Bayar'),
                        C2Choice(value: 2, label: 'Siap Konsultasi'),
                        C2Choice(value: 3, label: 'Konsultasi Selesai'),
                      ],
                      choiceStyle: C2ChipStyle.filled(
                        foregroundStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                color: grey400,
                                fontWeight: FontWeight.w600,
                                fontSize: 9.sp),
                        color: grey50,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        selectedStyle: C2ChipStyle(
                          backgroundColor: buttonColor1,
                          foregroundStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: backgroundColor1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.5.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
                child: TextField(
                  onTap: () {},
                  readOnly: true,
                  cursorColor: buttonColor1,
                  autocorrect: false,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 9.sp,
                      color: grey400),
                  decoration: InputDecoration(
                    hintText: 'Cari konsultan disini',
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 9.sp,
                        color: grey400),
                    filled: true,
                    fillColor: backgroundColor1,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0, color: grey50),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0, color: grey50),
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: Iconify(
                        Ri.search_line,
                        size: 12.sp,
                        color: grey400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        horizontalOffset: -50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1.5.h),
                            child: Card(
                              color: backgroundColor1,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.375.h, horizontal: 3.33.w),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Konsultasi pada :',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 9.sp,
                                                    color:
                                                        const Color(0XFF0D4136),
                                                  ),
                                            ),
                                            Text(
                                              '12 Juni 2023 | 11:00 - 12:00',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 8.sp,
                                                    color: grey400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: errColor,
                                            border: Border.all(
                                              color: errColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                          ),
                                          child: Text(
                                            'Belum Bayar',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: backgroundColor1,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 8.sp,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: grey100,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                'https://assets-global.website-files.com/5c88fc88555981dc7f314a41/5d4807f1a904cd6566057915_5d1c83174cf9cb8adf5b05a0_Scott-Kubie-Headshot-Web.jpeg',
                                                height: 4.h,
                                                width: 4.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 1.h),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Caryne Sali, ST, MM, CFP',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: grey500,
                                                        fontSize: 9.sp),
                                              ),
                                              Text(
                                                'Perencanaan Keuangan',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: grey400,
                                                        fontSize: 9.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: SizedBox(
                                            height: 3.5.h,
                                            width: 28.w,
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                foregroundColor: buttonColor2,
                                                side: const BorderSide(
                                                    color: buttonColor2,
                                                    width: 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: Text(
                                                'Bayar Sekarang',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: buttonColor2,
                                                        fontSize: 8.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
