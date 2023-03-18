import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sizer/sizer.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          backgroundColor: backgroundColor1,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: backgroundColor1,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 4.625.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: GradientText(
                    "NUHA",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 26.sp),
                    colors: const [buttonColor1, buttonColor2],
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Text(
                    'Selamat datang di Nuha!',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                        color: const Color(0XFF1F1F1F)),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Text(
                    'Untuk mendaftar, silahkan lengkapi data diri kamu dibawah, ya!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                        color: grey500),
                  ),
                ),
                SizedBox(height: 3.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Text(
                    'Nama Lengkap',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: grey500),
                  ),
                ),
                SizedBox(height: 0.75.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: TextField(
                    autocorrect: false,
                    controller: controller.nameC,
                    cursorColor: buttonColor1,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                    decoration: InputDecoration(
                      hintText: 'Nuha Finansial',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp,
                          color: grey400),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: grey400),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: buttonColor1),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: grey500),
                  ),
                ),
                SizedBox(height: 0.75.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: TextField(
                    autocorrect: false,
                    controller: controller.emailC,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: buttonColor1,
                    textInputAction: TextInputAction.next,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                    decoration: InputDecoration(
                      hintText: 'Nuha@gmail.com',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp,
                          color: grey400),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1, color: grey400),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: buttonColor1),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Text(
                    'Kata Sandi',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: grey500),
                  ),
                ),
                SizedBox(height: 0.75.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Obx(
                    () => TextField(
                      obscureText: controller.isHiddenPass.value,
                      autocorrect: false,
                      controller: controller.passC,
                      cursorColor: buttonColor1,
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                      decoration: InputDecoration(
                        hintText: 'min. 8 karakter',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: grey400),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 1.5.h),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: grey400),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: buttonColor1),
                            borderRadius: BorderRadius.circular(20)),
                        suffixIcon: IconButton(
                          onPressed: () => controller.isHiddenPass.toggle(),
                          icon: Icon(
                            controller.isHiddenPass.isTrue
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            color: buttonColor1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Text(
                    'Konfirmasi Kata Sandi',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                        color: grey500),
                  ),
                ),
                SizedBox(height: 0.75.h),
                Container(
                  padding: EdgeInsets.only(right: 11.1.w, left: 11.1.w),
                  width: widthDevice,
                  child: Obx(
                    () => TextField(
                      obscureText: controller.isHiddenConfirmPass.value,
                      autocorrect: false,
                      controller: controller.konfirpassC,
                      cursorColor: buttonColor1,
                      textInputAction: TextInputAction.done,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                      decoration: InputDecoration(
                        hintText: 'min. 8 karakter',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: grey400),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 1.5.h),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: grey400),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: buttonColor1),
                            borderRadius: BorderRadius.circular(20)),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              controller.isHiddenConfirmPass.toggle(),
                          icon: Icon(
                            controller.isHiddenConfirmPass.isTrue
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            color: buttonColor1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.125.h),
                SizedBox(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 9.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.w400,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(Routes.LOGIN),
                          text: 'Masuk',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 9.sp,
                                color: buttonColor1,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  width: 77.78.w,
                  child: SizedBox(
                    width: 77.78.w,
                    height: 5.5.h,
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: controller.isLoading.isFalse
                            ? Text(
                                "Daftar",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
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
                            controller.register();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.25.h),
                SizedBox(
                  width: 77.78.w,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Dengan masuk atau melakukan pendaftaran, kamu menyetujui ',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 9.sp,
                            color: const Color(0xFF919191),
                            fontWeight: FontWeight.w400,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Ketentuan Layanan ',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 9.sp,
                                color: buttonColor1,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        TextSpan(
                          text: 'dan ',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 9.sp,
                                color: const Color(0xFF919191),
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        TextSpan(
                          text: 'Kebijakan Privasi',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 9.sp,
                                color: buttonColor1,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
