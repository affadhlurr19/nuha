import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmarked_artikel_controller.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:sizer/sizer.dart';

class BookmarkedArtikelView extends GetView {
  BookmarkedArtikelView({Key? key}) : super(key: key);
  final c = Get.find<BookmarkedArtikelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
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
        centerTitle: true,
        title: Text(
          'Bookmark Artikel',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600, fontSize: 13.sp, color: titleColor),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0.5,
        toolbarHeight: 7.375.h,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: c.streamBookmarked(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: buttonColor1),
              );
            }

            if (snapshot.data?.docs.length == 0 || snapshot.data == null) {
              return const Center(
                child: Text('Belum ada data bookmark'),
              );
            }
            // return ListView.builder(
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (context, index) {
            //     var docBookmarked = snapshot.data!.docs[index];
            //     Map<String, dynamic> bookmark = docBookmarked.data();
            //     return ListTile(
            //       onTap: () => Get.toNamed(
            //         Routes.DETAIL_ARTIKEL,
            //         arguments: bookmark['artikelId'].toString(),
            //       ),
            //       title: Text(bookmark['title']),
            //       subtitle: Text('desc'),
            //       trailing: IconButton(
            //         onPressed: () {},
            //         icon: Icon(Icons.delete),
            //       ),
            //     );
            //   },
            // );
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.78.w),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var docBookmarked = snapshot.data!.docs[index];
                        Map<String, dynamic> bookmark = docBookmarked.data();
                        return GestureDetector(
                          onTap: () => Get.toNamed(
                            Routes.DETAIL_ARTIKEL,
                            arguments: bookmark['artikelId'].toString(),
                          ),
                          child: Card(
                            color: backgroundColor2,
                            elevation: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      bookmark['imageUrl'],
                                      height: 8.625.h,
                                      width: 29.72.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.89.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        bookmark['title'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0XFF0D4136),
                                                fontSize: 9.sp),
                                      ),
                                      Text(
                                        timeago.format(
                                            DateTime.parse(
                                                bookmark['createdAt']),
                                            locale: 'id'),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: grey500,
                                                fontSize: 8.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: grey50,
                          thickness: 0.2.h,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
