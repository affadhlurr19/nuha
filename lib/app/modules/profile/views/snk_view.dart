import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';

class SnkView extends GetView {
  const SnkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Syarat dan Ketentuan',
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
      body: ListView(
        children: [
          SizedBox(height: 2.25.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. Penggunaan Aplikasi",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                Text(
                  "a. Aplikasi Nuha bertujuan untuk membantu pengguna dalam pengelolaan keuangan, pencatatan alur kas, literasi keuangan, dan pemesanan konsultasi keuangan.\nb. Pengguna bertanggung jawab atas keakuratan dan kebenaran informasi yang diinput ke dalam aplikasi.\nc. Pengguna diharapkan menggunakan aplikasi dengan bijak dan sesuai dengan peraturan yang berlaku.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  "2. Privasi Pengguna",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                Text(
                  "a. Aplikasi Nuha akan mengumpulkan data pribadi pengguna seperti nama, alamat email, dan informasi keuangan terkait.\nb. Data pribadi yang dikumpulkan akan digunakan sesuai dengan Kebijakan Privasi yang berlaku di aplikasi Nuha.\nc. Nuha akan melindungi privasi pengguna dan tidak akan memberikan data pribadi kepada pihak ketiga tanpa persetujuan pengguna, kecuali jika diwajibkan oleh hukum.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  "3. Keamanan",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                Text(
                  "a. Pengguna bertanggung jawab untuk menjaga kerahasiaan informasi login dan kata sandi mereka.\nb. Nuha tidak bertanggung jawab atas kehilangan, kerusakan, atau akses tidak sah yang disebabkan oleh ketidakhati-hatian pengguna dalam menjaga kerahasiaan informasi login mereka.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  "4. Konten dan Informasi",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                Text(
                  "a. Konten yang disediakan di dalam aplikasi Nuha adalah untuk tujuan informasi dan edukasi. Nuha tidak memberikan jaminan atas keakuratan, kelengkapan, atau keandalan konten tersebut.\nb. Pengguna diharapkan untuk melakukan penelitian tambahan dan berkonsultasi dengan ahli keuangan sebelum mengambil keputusan berdasarkan informasi yang disediakan di aplikasi Nuha.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  "5. Konsultasi Keuangan",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                Text(
                  "a. Fitur pemesanan konsultasi keuangan di aplikasi Nuha hanya bertujuan untuk memberikan akses dan kemudahan kepada pengguna.\nb. Konsultasi keuangan yang diadakan melalui aplikasi Nuha akan melibatkan pihak ketiga yang merupakan konsultan keuangan terdaftar.\nc. Nuha tidak bertanggung jawab atas hasil atau konsekuensi dari konsultasi keuangan yang dilakukan melalui aplikasi ini.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                ),
                SizedBox(height: 1.h),
                Text(
                  "6. Perubahan Syarat & Ketentuan",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                Text(
                  "a. Nuha berhak untuk mengubah atau memperbarui syarat & ketentuan ini tanpa pemberitahuan sebelumnya.\nb. Setiap perubahan akan diberlakukan sejak tanggal diumumkannya perubahan tersebut.\nc. Pengguna diharapkan untuk secara berkala memeriksa syarat & ketentuan untuk tetap memperbarui informasi terkini.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Harap dicatat bahwa penggunaan aplikasi Nuha mengindikasikan persetujuan Anda terhadap syarat & ketentuan yang telah disebutkan di atas. Jika Anda tidak setuju dengan syarat & ketentuan tersebut, disarankan untuk tidak melanjutkan penggunaan aplikasi Nuha.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.25.h),
        ],
      ),
    );
  }
}
