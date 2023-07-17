import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/profile/controllers/delete_account_controller.dart';
import 'package:nuha/app/modules/profile/controllers/pin_controller.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class PinView extends GetView {
  PinView({Key? key}) : super(key: key);
  final c = Get.find<PinController>();
  final accountC = Get.find<DeleteAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(4.4.w, 10.h, 4.4.w, 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Verifikasi Identitasmu',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 19.sp,
                        color: titleColor),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Masukkan PIN kamu sebanyak 6 digit untuk melanjutkan proses ini!',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                        color: grey500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: Form(
                      key: c.formKey,
                      child: SafeArea(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            obscureText: true,
                            obscuringCharacter: "*",
                            length: 6,
                            errorTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: errColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                            controller: c.pinController,
                            focusNode: c.pinNode,
                            defaultPinTheme: c.defaultPinTheme,
                            validator: (value) {
                              return value == c.myPIN.value
                                  ? null
                                  : 'Pin anda salah';
                            },
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: c.focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: c.defaultPinTheme.copyWith(
                              decoration:
                                  c.defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: c.focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: c.defaultPinTheme.copyWith(
                              decoration:
                                  c.defaultPinTheme.decoration!.copyWith(
                                color: c.fillColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: c.focusedBorderColor),
                              ),
                            ),
                            errorPinTheme: c.defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Kamu lupa PIN? ',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 9.sp,
                              color: const Color(0xFF919191),
                              fontWeight: FontWeight.w400,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Get.toNamed(Routes.SETEL_ULANG_PIN),
                            text: 'Setel Ulang PIN',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 9.sp,
                                      color: buttonColor1,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor1,
                      ),
                      onPressed: () {
                        if (c.pinController.text.isEmpty ||
                            c.pinController.length < 6) {
                          c.dialogMessage.errMsg('Masukkan PIN dengan benar');
                        } else {
                          if (c.pinController.text != c.myPIN.value) {
                            c.dialogMessage.errMsg('PIN tidak cocok');
                          } else {
                            c.pinNode.unfocus();
                            c.formKey.currentState!.validate();
                            if (Get.arguments == 'delete-account') {
                              if (accountC.isLoading.isFalse) {
                                accountC.deleteAccount();
                              }
                            } else {
                              Get.offAndToNamed(Get.arguments);
                            }
                          }
                        }
                      },
                      child: Text('Kirim',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  color: backgroundColor1)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
