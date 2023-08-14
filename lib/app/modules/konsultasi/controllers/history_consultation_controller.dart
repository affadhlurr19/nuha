// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/models/consultation_history.dart';
import 'package:nuha/app/modules/konsultasi/models/get_payment_history_model.dart';
import 'package:nuha/app/modules/konsultasi/models/get_zoom_meeting_link_model.dart';
import 'package:nuha/app/modules/konsultasi/providers/payment_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class HistoryConsultationController extends GetxController {
  RxBool isSelected = false.obs;
  RxInt tag = RxInt(1);
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<ConsultationHistory> historyList = <ConsultationHistory>[].obs;
  TextEditingController meetingLinkC = TextEditingController();
  RxBool isConsultationDone = false.obs;
  RxBool isLoadingConsultationDone = false.obs;

  final PaymentProvider _paymentProvider = PaymentProvider();
  RxList<PaymentData> paymentList = <PaymentData>[].obs;
  RxList<MeetingData> meetingData = <MeetingData>[].obs;
  TextEditingController waktukonsultasiC = TextEditingController();
  TextEditingController zoomLinkC = TextEditingController();
  RxString message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
  }

  String convertTimestampToDateTime(DateTime timestamp) {
    DateTime dateTime = timestamp;
    String formatDatetime =
        DateFormat('EEEE d MMMM yyyy, HH:mm', 'id_ID').format(dateTime);
    return formatDatetime;
  }

  String getTimeFromTimestamp(DateTime timestamp) {
    DateTime datetime = timestamp;
    String formatDatetime = DateFormat('HH:mm').format(datetime);
    return formatDatetime;
  }

  Future<ZoomMeetingLink> getDetailZoomLink(String bookingId) async {
    try {
      final response = await http.get(Uri.parse(
          "https://starfish-app-pua4v.ondigitalocean.app/api/zoom/$bookingId"));
      if (response.statusCode == 200) {
        ZoomMeetingLink data =
            ZoomMeetingLink.fromJson(json.decode(response.body));
        meetingData.value = data.data;
        return data;
      } else {
        throw Exception('Gagal mengambil zoom meeting data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Gagal mengambil zoom meeting data');
    }
  }

  Future<void> getPendingPaymentHistory() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await http.get(Uri.parse(
          "https://starfish-app-pua4v.ondigitalocean.app/api/booking/isItDone/$uid/PENDING/false"));
      if (response.statusCode == 200) {
        PaymentHistory data =
            PaymentHistory.fromJson(json.decode(response.body));
        paymentList.value = data.data;
      } else {
        throw Exception('Gagal mengambil data payment');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getSuccessPaymentHistory() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await http.get(Uri.parse(
          "https://starfish-app-pua4v.ondigitalocean.app/api/booking/isItDone/$uid/SUCCESS/false"));
      if (response.statusCode == 200) {
        PaymentHistory data =
            PaymentHistory.fromJson(json.decode(response.body));
        paymentList.value = data.data;
      } else {
        throw Exception('Gagal mengambil data payment');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getDoneConsultationHistory() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await http.get(Uri.parse(
          "https://starfish-app-pua4v.ondigitalocean.app/api/booking/isItDone/$uid/SUCCESS/true"));
      if (response.statusCode == 200) {
        PaymentHistory data =
            PaymentHistory.fromJson(json.decode(response.body));
        paymentList.value = data.data;
      } else {
        throw Exception('Gagal mengambil data payment');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<PaymentHistory> getPendingRealtimeData() async* {
    while (true) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await http.get(Uri.parse(
          "https://starfish-app-pua4v.ondigitalocean.app/api/booking/isItDone/$uid/PENDING/false"));
      if (response.statusCode == 200) {
        PaymentHistory data =
            PaymentHistory.fromJson(json.decode(response.body));
        yield data;
      }
      await Future.delayed(const Duration(seconds: 5));
      print('refresh');
    }
  }

  Stream<PaymentHistory> getSuccessRealtimeData() async* {
    while (true) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await http.get(Uri.parse(
          "https://starfish-app-pua4v.ondigitalocean.app/api/booking/isItDone/$uid/SUCCESS/false"));
      if (response.statusCode == 200) {
        PaymentHistory data =
            PaymentHistory.fromJson(json.decode(response.body));
        yield data;
      }
      await Future.delayed(const Duration(seconds: 5));
      print('refresh');
    }
  }

  Stream<PaymentHistory> getDoneRealtimeData() async* {
    while (true) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await http.get(Uri.parse(
          "https://starfish-app-pua4v.ondigitalocean.app/api/booking/isItDone/$uid/SUCCESS/true"));
      if (response.statusCode == 200) {
        PaymentHistory data =
            PaymentHistory.fromJson(json.decode(response.body));
        yield data;
      }
      await Future.delayed(const Duration(seconds: 5));
      print('refresh');
    }
  }

  void getMeetingLink() {
    Get.defaultDialog(
      title: 'Perhatian',
      titleStyle: Theme.of(Get.context!).textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w600, fontSize: 15.sp, color: grey900),
      middleText: 'Apakah kamu yakin ingin mengkonfirmasi pembayaranmu?',
      middleTextStyle: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w400, fontSize: 11.sp, color: grey900),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: buttonColor2,
                  backgroundColor: backgroundColor1,
                  side: const BorderSide(color: buttonColor2, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'Batalkan',
                    style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: buttonColor2),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor2,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'Setuju',
                    style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: backgroundColor1),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void consultationDoneStatusUpdate(String bookingId) async {
    try {
      isLoadingConsultationDone.value = true;
      await _paymentProvider.consultationDoneStatusUpdate(bookingId);
      isLoadingConsultationDone.value = false;
      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  void copyTextToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Link berhasil disalin ke clipboard')),
    );
  }
}
