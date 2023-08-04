import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/konsultasi/models/consultation_transaction_model.dart';
import 'package:nuha/app/modules/konsultasi/models/post_payment_with_midtrans_model.dart';
import 'package:nuha/app/modules/konsultasi/providers/payment_provider.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class OrderConstultationController extends GetxController {
  ConsultationTransaction consultationTransaction = Get.arguments;
  final PaymentProvider _paymentProvider = PaymentProvider();
  RxList<String> paymentMethodList = <String>[].obs;
  RxString currentPaymentMethod = ''.obs;
  RxBool isPaymentMethodSelected = false.obs;
  final GlobalKey<ExpansionTileCardState> mandiriCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> bcaCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> bniCard = GlobalKey();
  final GlobalKey<ExpansionTileCardState> briCard = GlobalKey();
  RxInt totalFixedPrice = 0.obs;
  RxBool isLoading = false.obs;
  String? fixStartTime;
  String? fixEndTime;
  var uuid = const Uuid();

  @override
  void onInit() {
    initializeDateFormatting('id', null);
    paymentMethodList.value = [
      'bank_transfer_mandiri',
      'bank_transfer_bca',
      'bank_transfer_bni',
      'bank_transfer_bri',
    ];
    super.onInit();
  }

  Future<void> getDetailData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('consultant')
              .doc(consultationTransaction.consultantId)
              .get();

      final DocumentSnapshot<Map<String, dynamic>> snapshot2 =
          await FirebaseFirestore.instance
              .collection('consultant')
              .doc(consultationTransaction.consultantId)
              .collection('consultant_schedule')
              .doc(consultationTransaction.scheduleId)
              .get();

      if (snapshot.exists && snapshot2.exists) {
        fixStartTime = snapshot2.data()!['startTime'];
        fixEndTime = snapshot2.data()!['endTime'];
        var fixedTime = '$fixStartTime - $fixEndTime';
        var consultantPrice = snapshot.data()!['price'];
        var totalPrice = consultantPrice + 1500;

        consultationTransaction = ConsultationTransaction(
          uid: consultationTransaction.uid,
          consultantId: consultationTransaction.consultantId,
          consultantImg: snapshot.data()!['imageUrl'],
          consultantName: snapshot.data()!['name'],
          consultantEmail: snapshot.data()!['consultant_email'],
          consultantCategory: snapshot.data()!['category'],
          consultantPrice: consultantPrice,
          scheduleId: consultationTransaction.scheduleId,
          consultationStartDate: consultationTransaction.consultationStartDate,
          consultationEndDate: consultationTransaction.consultationEndDate,
          fixScheduleTime: fixedTime,
          totalPrice: totalPrice,
        );

        totalFixedPrice.value = totalPrice;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void dialogMessage() {
    Get.defaultDialog(
      title: 'Perhatian',
      titleStyle: Theme.of(Get.context!).textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w600, fontSize: 15.sp, color: grey900),
      middleText: 'Apakah kamu yakin ingin melakukan pemesanan konsultasi?',
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
                onPressed: () {
                  try {
                    isLoading.value = true;
                    final currentUser = FirebaseAuth.instance.currentUser;
                    PostPayment postPaymentWithMidtrans = PostPayment(
                      bookingId: uuid.v4().toString(),
                      userId: currentUser!.uid,
                      consultantId: consultationTransaction.consultantId,
                      consultantName:
                          consultationTransaction.consultantName.toString(),
                      mailConsultant:
                          consultationTransaction.consultantEmail.toString(),
                      mailUser: currentUser.email.toString(),
                      kategori:
                          consultationTransaction.consultantCategory.toString(),
                      imageUrl:
                          consultationTransaction.consultantImg.toString(),
                      grossAmount: totalFixedPrice.value,
                      paymentMethod: currentPaymentMethod.value,
                      vaNumber: "none",
                      startDateTime:
                          consultationTransaction.consultationStartDate,
                      endDateTime: consultationTransaction.consultationEndDate,
                    );
                    _paymentProvider.postPayment(postPaymentWithMidtrans);

                    isLoading.value = false;
                    Get.back();
                    Get.back();
                    Get.back();
                  } catch (e) {
                    isLoading.value = false;
                    // ignore: avoid_print
                    print(e);
                  }
                },
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

  Future<void> createPayment() async {
    try {
      isLoading.value = true;
      final currentUser = FirebaseAuth.instance.currentUser;

      isLoading.value = false;

      await FirebaseFirestore.instance
          .collection('consultation_transaction')
          .add(
        {
          'userId': currentUser!.uid,
          'consultantId': consultationTransaction.consultantId,
          'scheduleId': consultationTransaction.scheduleId,
          'startDateTime': consultationTransaction.consultationStartDate,
          'endDateTime': consultationTransaction.consultationEndDate,
          'total': totalFixedPrice.toString(),
          'selectedPaymentMethod': currentPaymentMethod.value,
          'proofOfPayment': '',
          'meetingLink': '',
          'paymentStatus': 'Menunggu Pembayaran',
          'createdAt': DateTime.now(),
        },
      );

      await FirebaseFirestore.instance
          .collection('consultant')
          .doc(consultationTransaction.consultantId)
          .collection('consultant_schedule')
          .doc(consultationTransaction.scheduleId)
          .update({
        'isAvailable': false,
      });

      Get.back();
      Get.back();
      Get.back();
      Get.toNamed(Routes.RIWAYAT_KONSULTASI);
    } catch (e) {
      isLoading.value = false;
      // ignore: avoid_print
      print(e);
    }
  }

  Widget paymentMethodDetails(
    BuildContext context,
    keyCard,
    paymentMethodValue,
    logo,
    paymentName,
    titlePayment,
    nomorBody,
    bodyPayment,
    String? titlePayment2,
    String? nomorBody2,
    String? bodyPayment2,
    String? titlePayment3,
    String? nomorBody3,
    String? bodyPayment3,
  ) {
    return ExpansionTileCard(
      key: keyCard,
      trailing: Obx(
        () => Radio(
          activeColor: buttonColor1,
          overlayColor:
              MaterialStateProperty.all(buttonColor1.withOpacity(0.2)),
          value: paymentMethodValue,
          groupValue: currentPaymentMethod.value,
          onChanged: (value) {
            currentPaymentMethod.value = value.toString();
            isPaymentMethodSelected.value = true;
            // ignore: avoid_print
            print(value);
          },
        ),
      ),
      title: Row(
        children: [
          SizedBox(
            width: 50,
            child: Image.asset(
              logo,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            paymentName,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
        ],
      ),
      children: <Widget>[
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 2.h,
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titlePayment,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            nomorBody,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          flex: 15,
                          child: Text(
                            bodyPayment,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                titlePayment2 != null &&
                        nomorBody2 != null &&
                        bodyPayment2 != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titlePayment2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  nomorBody2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                flex: 15,
                                child: Text(
                                  bodyPayment2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
                titlePayment3 != null &&
                        nomorBody3 != null &&
                        bodyPayment3 != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titlePayment3,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  nomorBody3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                flex: 15,
                                child: Text(
                                  bodyPayment3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
                SizedBox(height: 0.75.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
