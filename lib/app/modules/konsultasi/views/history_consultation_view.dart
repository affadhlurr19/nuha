import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/controllers/history_consultation_controller.dart';
import 'package:nuha/app/modules/konsultasi/models/get_payment_history_model.dart';
import 'package:nuha/app/modules/konsultasi/models/get_zoom_meeting_link_model.dart';
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
      body: SingleChildScrollView(
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
                      C2Choice(value: 1, label: 'Menunggu Pembayaran'),
                      C2Choice(value: 2, label: 'Siap Konsultasi'),
                      C2Choice(value: 3, label: 'Selesai'),
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
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.9167.w),
              child: Obx(
                () => StreamBuilder<PaymentHistory>(
                  stream: (c.tag.value == 1)
                      ? c.getPendingRealtimeData()
                      : (c.tag.value == 2)
                          ? c.getSuccessRealtimeData()
                          : c.getDoneRealtimeData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: const Center(
                          child: CircularProgressIndicator(color: buttonColor1),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final historyList = snapshot.data!;
                      if (historyList.data.isEmpty) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 25.h),
                          child: Column(
                            children: [
                              Image.asset('assets/images/404_error.png'),
                              SizedBox(height: 2.5.h),
                              Text(
                                'Maaf, data riwayat konsultasi pada status ini kosong. Silahkan pilih status lainnya.',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400,
                                        color: grey500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: historyList.data.length,
                          itemBuilder: (context, index) {
                            final datas = historyList.data[index];
                            var startDate = c.convertTimestampToDateTime(
                                datas.startDateTime);
                            var endDate =
                                c.getTimeFromTimestamp(datas.endDateTime);
                            var fixDateTimeConsultation =
                                '$startDate - $endDate';
                            return Padding(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 9.sp,
                                                      color: const Color(
                                                          0XFF0D4136),
                                                    ),
                                              ),
                                              Text(
                                                fixDateTimeConsultation,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 8.sp,
                                                      color: grey400,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.5.h,
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                                side: datas.status == 'PENDING'
                                                    ? const BorderSide(
                                                        color: warnColor,
                                                        width: 1)
                                                    : const BorderSide(
                                                        color: succColor,
                                                        width: 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              child: datas.status == 'PENDING'
                                                  ? Text(
                                                      datas.status,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: warnColor,
                                                              fontSize: 8.sp),
                                                    )
                                                  : Text(
                                                      datas.status,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: succColor,
                                                              fontSize: 8.sp),
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
                                                  datas.imageUrl,
                                                  height: 5.h,
                                                  width: 5.h,
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
                                                  datas.consultantName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: grey500,
                                                          fontSize: 10.sp),
                                                ),
                                                const SizedBox(height: 0.5),
                                                Text(
                                                  datas.kategori,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: grey400,
                                                          fontSize: 10.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SizedBox(
                                              height: 3.5.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  (c.tag.value == 1)
                                                      ? customShowDialog(
                                                          context,
                                                          datas.vaNumber,
                                                          datas.bookingId,
                                                          datas.paymentMethod,
                                                        )
                                                      : (c.tag.value == 2)
                                                          ? meetDialog(context,
                                                              datas.bookingId)
                                                          : '';
                                                },
                                                style: (c.tag.value == 1)
                                                    ? ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            buttonColor2,
                                                        side: const BorderSide(
                                                            color: buttonColor2,
                                                            width: 1),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                      )
                                                    : (c.tag.value == 2)
                                                        ? ElevatedButton
                                                            .styleFrom(
                                                            backgroundColor:
                                                                buttonColor1,
                                                            side: const BorderSide(
                                                                color:
                                                                    buttonColor1,
                                                                width: 1),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                          )
                                                        : ElevatedButton
                                                            .styleFrom(
                                                            backgroundColor:
                                                                grey400,
                                                            side:
                                                                const BorderSide(
                                                                    color:
                                                                        grey400,
                                                                    width: 1),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                          ),
                                                child: Text(
                                                  (c.tag.value == 1)
                                                      ? 'Bayar Sekarang'
                                                      : (c.tag.value == 2)
                                                          ? 'Lihat Detail'
                                                          : 'Selesai',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              backgroundColor1,
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
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void customShowDialog(BuildContext context, String meetingLink,
      String paymentId, String paymentMethod) {
    c.meetingLinkC.text = meetingLink;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimationConfiguration.synchronized(
          child: FadeInAnimation(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 250),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              content: SizedBox(
                width: 84.44.w,
                height: 28.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Silahkan salin nomor virtual account berikut untuk melakukan pembayaran.',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          SizedBox(height: 2.h),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Bank $paymentMethod',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: buttonColor1),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          TextField(
                            autocorrect: false,
                            controller: c.meetingLinkC,
                            readOnly: true,
                            cursorColor: buttonColor1,
                            textInputAction: TextInputAction.next,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.h, vertical: 1.5.h),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 1, color: grey50),
                                  borderRadius: BorderRadius.circular(10)),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    c.copyTextToClipboard(c.meetingLinkC.text),
                                splashRadius: 20,
                                icon: const Iconify(
                                    MaterialSymbols.content_copy_outline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            c.isConsultationDone.value = false;
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor2,
                          ),
                          child: Text(
                            'Tutup',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
                                    color: backgroundColor1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void meetDialog(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AnimationConfiguration.synchronized(
          child: FadeInAnimation(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 250),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              content: SizedBox(
                width: 84.44.w,
                height: 45.h,
                child: FutureBuilder<ZoomMeetingLink>(
                  future: c.getDetailZoomLink(bookingId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: buttonColor1),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final meetingData = snapshot.data;
                      if (meetingData!.data.isEmpty) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 25.h),
                          child: Text(
                            'Terjadi kesalahan, silahkan coba lagi',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w400,
                                    color: grey500),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: meetingData.data.length,
                          itemBuilder: (context, index) {
                            final data = meetingData.data[index];
                            c.zoomLinkC.text = data.joinUrl;
                            c.waktukonsultasiC.text =
                                DateFormat('EEEE d MMMM yyyy, HH:mm', 'id_ID')
                                    .format(data.startTime);
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Silahkan salin link zoom meeting dibawah ini untuk melaksanakan konsultasi di waktu yang telah ditentukan',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                      ),
                                      SizedBox(height: 2.h),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Waktu Konsultasi',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: grey900),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(height: 0.75.h),
                                      TextField(
                                        autocorrect: false,
                                        controller: c.waktukonsultasiC,
                                        readOnly: true,
                                        cursorColor: buttonColor1,
                                        textInputAction: TextInputAction.next,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 2.h, vertical: 1.5.h),
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1, color: grey50),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      const SizedBox(height: 1.25),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'Link Meeting',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: grey900),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(height: 0.75.h),
                                      TextField(
                                        autocorrect: false,
                                        controller: c.zoomLinkC,
                                        readOnly: true,
                                        cursorColor: buttonColor1,
                                        textInputAction: TextInputAction.next,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 2.h, vertical: 1.5.h),
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1, color: grey50),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          suffixIcon: IconButton(
                                            onPressed: () =>
                                                c.copyTextToClipboard(
                                                    c.zoomLinkC.text),
                                            splashRadius: 20,
                                            icon: const Iconify(MaterialSymbols
                                                .content_copy_outline),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                        child: Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor:
                                                  buttonColor1),
                                          child: Obx(
                                            () => Checkbox(
                                              activeColor: buttonColor1,
                                              value: c.isConsultationDone.value,
                                              onChanged: (value) =>
                                                  c.isConsultationDone.toggle(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "Saya telah melaksanakan konsultasi",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w400,
                                                color: grey900),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 32.w,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            c.isConsultationDone.value = false;
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: buttonColor2,
                                          ),
                                          child: Text(
                                            'Tutup',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 11.sp,
                                                    color: backgroundColor1),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => SizedBox(
                                          height: 40,
                                          width: 32.w,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (c.isConsultationDone.isTrue) {
                                                c.isConsultationDone.value =
                                                    false;
                                                c.consultationDoneStatusUpdate(
                                                    bookingId);
                                              }
                                            },
                                            style: c.isConsultationDone.isFalse
                                                ? ElevatedButton.styleFrom(
                                                    backgroundColor: grey500,
                                                    foregroundColor: grey500,
                                                  )
                                                : ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        buttonColor1,
                                                  ),
                                            child: c.isLoadingConsultationDone
                                                    .isFalse
                                                ? Text(
                                                    'Selesai',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 11.sp,
                                                            color:
                                                                backgroundColor1),
                                                  )
                                                : SizedBox(
                                                    height: 1.5.h,
                                                    width: 1.5.h,
                                                    child:
                                                        const CircularProgressIndicator(
                                                      color: backgroundColor1,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
                // child: Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Column(
                //         children: [
                //           Text(
                //             'Silahkan salin nomor virtual account berikut untuk melakukan pembayaran.',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .headlineMedium!
                //                 .copyWith(
                //                     fontSize: 11.sp,
                //                     fontWeight: FontWeight.w600,
                //                     color: Colors.black),
                //           ),
                //           SizedBox(height: 2.h),
                //           SizedBox(
                //             width: double.infinity,
                //             child: Text(
                //               'Bank',
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .headlineMedium!
                //                   .copyWith(
                //                       fontSize: 10.sp,
                //                       fontWeight: FontWeight.w600,
                //                       color: buttonColor1),
                //               textAlign: TextAlign.left,
                //             ),
                //           ),
                //           SizedBox(height: 0.5.h),
                //           TextField(
                //             autocorrect: false,
                //             controller: c.meetingLinkC,
                //             readOnly: true,
                //             cursorColor: buttonColor1,
                //             textInputAction: TextInputAction.next,
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .bodyMedium!
                //                 .copyWith(
                //                     fontWeight: FontWeight.w400,
                //                     fontSize: 11.sp),
                //             decoration: InputDecoration(
                //               contentPadding: EdgeInsets.symmetric(
                //                   horizontal: 2.h, vertical: 1.5.h),
                //               border: OutlineInputBorder(
                //                   borderSide:
                //                       const BorderSide(width: 1, color: grey50),
                //                   borderRadius: BorderRadius.circular(10)),
                //               suffixIcon: IconButton(
                //                 onPressed: () =>
                //                     c.copyTextToClipboard(c.meetingLinkC.text),
                //                 splashRadius: 20,
                //                 icon: const Iconify(
                //                     MaterialSymbols.content_copy_outline),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 40,
                //         width: double.infinity,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             c.isConsultationDone.value = false;
                //             Get.back();
                //           },
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: buttonColor2,
                //           ),
                //           child: Text(
                //             'Tutup',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .labelMedium!
                //                 .copyWith(
                //                     fontWeight: FontWeight.w600,
                //                     fontSize: 11.sp,
                //                     color: backgroundColor1),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}
