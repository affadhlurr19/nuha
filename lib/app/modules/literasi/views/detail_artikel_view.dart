import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/controllers/detail_artikel_controller.dart';
import 'package:nuha/app/utility/result_state.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

class DetailArtikelView extends GetView<DetailArtikelController> {
  DetailArtikelView({Key? key}) : super(key: key);
  final c = Get.find<DetailArtikelController>();    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        leading: Container(
          width: 100,
          padding: EdgeInsets.only(left: 4.58.w),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              size: 3.h,
              color: titleColor,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: titleColor,
        ),
        centerTitle: true,
        title: Text(
          'Artikel',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 2.98.w),
            child: Obx(
              () => IconButton(
                onPressed: () {
                  if (c.isLoading.isFalse) {
                    c.toogleBookmark(Get.arguments);
                  }
                },
                icon: Icon(
                  c.isBookmarked.isTrue
                      ? Icons.bookmark_border_outlined
                      : Icons.bookmark_border,
                  size: 3.h,
                  color: titleColor,
                ),
              ),
            ),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.7,
        toolbarHeight: 7.375.h,
      ),
      body: FutureBuilder<dynamic>(
        future: c.fetchDetailArtikel(Get.arguments),
        builder: (context, snapshot) {
          return Obx(
            () {
              switch (c.resultState.value.status) {
                case ResultStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: buttonColor1,
                    ),
                  );
                case ResultStatus.hasData:
                  var detail = c.resultDetailArtikel.article;
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text(c.isBookmarked.value.toString()),
                      SizedBox(height: 1.875.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.2.w),
                        child: GradientText(
                          detail.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 21.sp),
                          colors: const [buttonColor1, buttonColor2],
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.2.w),
                        child: Text(
                          DateFormat('dd MMMM yyyy, HH:mm')
                              .format(detail.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.sp,
                                  color: grey500),
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.2.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 5.w,
                              backgroundColor: buttonColor2,
                            ),
                            SizedBox(width: 3.3.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detail.author,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w600,
                                          color: buttonColor2),
                                ),
                                Text(
                                  detail.category,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w600,
                                          color: grey400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.2.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            detail.imageUrl,
                            fit: BoxFit.cover,
                            // height: 15.5.h,
                            // width: 75.56.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.2.w),
                        child: Text(
                          detail.content,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  color: grey500),
                        ),
                      ),
                    ],
                  );
                case ResultStatus.noData:
                  return const Text('Data Kosong');
                case ResultStatus.error:
                  return Text(c.message);
                default:
                  return const SizedBox();
              }
            },
          );
        },
      ),
      // body: Obx(
      //   () {
      //     switch (c.resultState.value.status) {
      //       case ResultStatus.loading:
      //         return const Center(
      //           child: CircularProgressIndicator(
      //             color: buttonColor1,
      //           ),
      //         );
      //       case ResultStatus.hasData:
      //         return FutureBuilder(
      //           future: c.fetchDetailArtikel(Get.arguments),
      //           builder: (context, snapshot) {
      //             var detail = c.resultDetailArtikel.article;
      //             return ListView(
      //               physics: const BouncingScrollPhysics(),
      //               children: [
      //                 SizedBox(height: 1.875.h),
      //                 Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 12.2.w),
      //                   child: GradientText(
      //                     detail.title,
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .headline2!
      //                         .copyWith(
      //                             fontWeight: FontWeight.w600, fontSize: 21.sp),
      //                     colors: const [buttonColor1, buttonColor2],
      //                   ),
      //                 ),
      //                 SizedBox(height: 0.5.h),
      //                 Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 12.2.w),
      //                   child: Text(
      //                     DateFormat('dd MMMM yyyy, HH:mm')
      //                         .format(detail.createdAt),
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .bodyText1!
      //                         .copyWith(
      //                             fontWeight: FontWeight.w400,
      //                             fontSize: 9.sp,
      //                             color: grey500),
      //                   ),
      //                 ),
      //                 SizedBox(height: 0.5.h),
      //                 Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 12.2.w),
      //                   child: Row(
      //                     children: [
      //                       CircleAvatar(
      //                         radius: 5.w,
      //                         backgroundColor: buttonColor2,
      //                       ),
      //                       SizedBox(width: 3.3.w),
      //                       Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             detail.author,
      //                             style: Theme.of(context)
      //                                 .textTheme
      //                                 .caption!
      //                                 .copyWith(
      //                                     fontSize: 9.sp,
      //                                     fontWeight: FontWeight.w600,
      //                                     color: buttonColor2),
      //                           ),
      //                           Text(
      //                             detail.category,
      //                             style: Theme.of(context)
      //                                 .textTheme
      //                                 .caption!
      //                                 .copyWith(
      //                                     fontSize: 9.sp,
      //                                     fontWeight: FontWeight.w600,
      //                                     color: grey400),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 2.5.h),
      //                 Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 12.2.w),
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(15),
      //                     child: Image.network(
      //                       detail.imageUrl,
      //                       fit: BoxFit.cover,
      //                       // height: 15.5.h,
      //                       // width: 75.56.w,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 2.5.h),
      //                 Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 12.2.w),
      //                   child: Text(
      //                     detail.content,
      //                     textAlign: TextAlign.justify,
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .bodyText1!
      //                         .copyWith(
      //                             fontSize: 11.sp,
      //                             fontWeight: FontWeight.w400,
      //                             color: grey500),
      //                   ),
      //                 ),
      //               ],
      //             );
      //           },
      //         );
      //       case ResultStatus.noData:
      //         return Text('Data Kosong');
      //       case ResultStatus.error:
      //         return Text(c.message);
      //       default:
      //         return SizedBox();
      //     }
      //   },
      // ),
    );
  }
}
