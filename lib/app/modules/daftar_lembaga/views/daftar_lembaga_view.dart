import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nuha/app/modules/daftar_lembaga/controllers/daftar_pinjol_controller.dart';
import 'package:nuha/app/modules/daftar_lembaga/providers/daftar_ikd_provider.dart';
import 'package:nuha/app/modules/daftar_lembaga/providers/daftar_pinjol_provider.dart';
import 'package:nuha/app/utility/result_state.dart';
import '../controllers/daftar_lembaga_controller.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:url_launcher/url_launcher.dart';

class DaftarLembagaView extends GetView<DaftarLembagaController> {
  DaftarLembagaView({Key? key}) : super(key: key);
  final c = Get.find<DaftarLembagaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 7.375.h,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: dark,
        ),
        title: Text(
          "Daftar Lembaga",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: titleColor),
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          indicatorWeight: 3,
          labelColor: buttonColor1,
          indicatorColor: buttonColor1,
          controller: c.tabs,
          tabs: c.daftarLembagaTabs,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
          unselectedLabelColor: grey400,
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 11.sp),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: backgroundColor1,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      backgroundColor: backgroundColor2,
      body: TabBarView(
        controller: controller.tabs,
        children: [
          DataIKD(),
          DataPinjol(),
        ],
      ),
    );
  }
}

class DataIKD extends StatelessWidget {
  DataIKD({super.key});
  final controller = Get.find<DaftarLembagaController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.91666.w),
      child: ListView(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Image(
            image: const AssetImage('assets/images/banner_daftarlembaga.png'),
            width: 83.44444.w,
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 4.5.h,
            child: TextField(
              textAlign: TextAlign.left,
              controller: controller.searchC,
              onChanged: (value) => controller.searchDataIKD(value),
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: grey900,
                  ),
              decoration: InputDecoration(
                fillColor: grey50,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(2.222.w, 1.25.h, 0, 1.25.h),
                suffixIcon: IconButton(
                  icon: const Iconify(
                    Uil.search,
                    color: grey400,
                  ),
                  onPressed: () {},
                  iconSize: 12.sp,
                ),
                suffixIconColor: grey400,
                hintText: "Cari Lembaga Disini",
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grey400,
                    ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: backgroundColor1),
              padding: EdgeInsets.symmetric(
                horizontal: 4.44444.w,
                vertical: 2.75.h,
              ),
              child: GetBuilder<DaftarLembagaController>(
                init: DaftarLembagaController(
                    daftarIkdProvider: DaftarIkdProvider()),
                initState: (_) {},
                builder: (_) {
                  return SizedBox(
                      child: _.searchC.text.isEmpty
                          ? Obx(() {
                              switch (controller.resultState.value.status) {
                                case ResultStatus.loading:
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: buttonColor1,
                                    ),
                                  );
                                case ResultStatus.hasData:
                                  // print(controller.resultIKD.data.length);
                                  return GroupedListView<dynamic, String>(
                                    shrinkWrap: true,
                                    elements: controller.resultIKD.data,
                                    groupBy: (element) => element.namaPlatform
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    groupSeparatorBuilder:
                                        (String groupByValue) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          groupByValue,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: buttonColor1,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        )
                                      ],
                                    ),
                                    itemBuilder: (context, element) =>
                                        GestureDetector(
                                      onTap: () {
                                        Get.defaultDialog(
                                          radius: 25,
                                          titlePadding:
                                              EdgeInsets.only(top: 2.h),
                                          title: "Detail Lembaga",
                                          titleStyle: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: grey900,
                                                  fontWeight: FontWeight.w600),
                                          content: IKDDialog(
                                            namaPlatform: element.namaPlatform,
                                            namaPT: element.namaPT,
                                            suratTanda: element.suratTanda,
                                            tanggalTercatat:
                                                element.tglTercatat,
                                            klaster: element.klaster,
                                          ),
                                        );
                                      },
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element.namaPlatform,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(color: dark),
                                            ),
                                            Divider(
                                              color: grey50,
                                              thickness: 0.2.h,
                                            )
                                          ]),
                                    ),
                                    order: GroupedListOrder.ASC,
                                  );
                                case ResultStatus.noData:
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 14.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              'assets/images/Empty.png'),
                                          height: 15.h,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "Data yang dicari tidak ditemukan. Silahkan coba kata kunci lain!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: grey500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                case ResultStatus.error:
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              'assets/images/Error.png'),
                                          height: 15.h,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "Maaf, sepertinya terjadi kesalahan. Silahkan untuk mencoba kembali atau hubungi kami  jika masalah masih berlanjut!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: grey500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            })
                          : Obx(
                              () {
                                switch (
                                    controller.resultStateSearch.value.status) {
                                  case ResultStatus.loading:
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: buttonColor1,
                                      ),
                                    );
                                  case ResultStatus.hasData:
                                    // print(controller.resultSearch.data.length);
                                    return GroupedListView<dynamic, String>(
                                      shrinkWrap: true,
                                      elements: controller.resultSearch.data,
                                      groupBy: (element) => element.namaPlatform
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      groupSeparatorBuilder:
                                          (String groupByValue) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            groupByValue,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: buttonColor1,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          )
                                        ],
                                      ),
                                      itemBuilder: (context, element) =>
                                          GestureDetector(
                                        onTap: () {
                                          Get.defaultDialog(
                                            radius: 25,
                                            titlePadding:
                                                EdgeInsets.only(top: 2.h),
                                            title: "Detail Lembaga",
                                            titleStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: grey900,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            content: IKDDialog(
                                              namaPlatform:
                                                  element.namaPlatform,
                                              namaPT: element.namaPT,
                                              suratTanda: element.suratTanda,
                                              tanggalTercatat:
                                                  element.tglTercatat,
                                              klaster: element.klaster,
                                            ),
                                          );
                                        },
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                element.namaPlatform,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(color: dark),
                                              ),
                                              Divider(
                                                color: grey50,
                                                thickness: 0.2.h,
                                              )
                                            ]),
                                      ),
                                      order: GroupedListOrder.ASC,
                                    );
                                  case ResultStatus.noData:
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 14.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: const AssetImage(
                                                'assets/images/Empty.png'),
                                            height: 15.h,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text(
                                            "Data yang dicari tidak ditemukan. Silahkan coba kata kunci lain!",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: grey500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  case ResultStatus.error:
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: const AssetImage(
                                                'assets/images/Error.png'),
                                            height: 15.h,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text(
                                            "Maaf, sepertinya terjadi kesalahan. Silahkan untuk mencoba kembali atau hubungi kami  jika masalah masih berlanjut!",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: grey500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  default:
                                    return const SizedBox();
                                }
                              },
                            ));
                },
              ))
        ],
      ),
    );
  }
}

class DataPinjol extends StatelessWidget {
  DataPinjol({super.key});

  final c = Get.find<DaftarPinjolController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.91666.w),
      child: ListView(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Image(
            image: const AssetImage('assets/images/banner_daftarlembaga.png'),
            width: 83.44444.w,
          ),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 4.5.h,
            child: TextField(
              textAlign: TextAlign.left,
              controller: c.searchC,
              onChanged: (value) => c.searchDataPinjol(value),
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: grey900,
                  ),
              decoration: InputDecoration(
                fillColor: grey50,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(2.222.w, 1.25.h, 0, 1.25.h),
                suffixIcon: IconButton(
                  icon: const Iconify(
                    Uil.search,
                    color: grey400,
                  ),
                  onPressed: () {},
                  iconSize: 12.sp,
                ),
                suffixIconColor: grey400,
                hintText: "Cari Lembaga Disini",
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grey400,
                    ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundColor1),
            padding: EdgeInsets.symmetric(
              horizontal: 4.44444.w,
              vertical: 2.75.h,
            ),
            child: GetBuilder<DaftarPinjolController>(
                init: DaftarPinjolController(
                    daftarPinjolProvider: DaftarPinjolProvider()),
                initState: (_) {},
                builder: (_) {
                  return SizedBox(
                      child: _.searchC.text.isEmpty
                          ? Obx(() {
                              switch (c.resultState.value.status) {
                                case ResultStatus.loading:
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: buttonColor1,
                                    ),
                                  );
                                case ResultStatus.hasData:
                                  return GroupedListView<dynamic, String>(
                                    shrinkWrap: true,
                                    elements: c.resultPinjol.data,
                                    groupBy: (element) => element.namaPlatform
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    groupSeparatorBuilder:
                                        (String groupByValue) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          groupByValue,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: buttonColor1,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        )
                                      ],
                                    ),
                                    itemBuilder: (context, element) =>
                                        GestureDetector(
                                      onTap: () {
                                        Get.defaultDialog(
                                          radius: 25,
                                          titlePadding:
                                              EdgeInsets.only(top: 2.h),
                                          title: "Detail Lembaga",
                                          titleStyle: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: grey900,
                                                  fontWeight: FontWeight.w600),
                                          content: PinjolDialog(
                                            namaPlatform: element.namaPlatform,
                                            situs: element.situs,
                                            status: element.status,
                                          ),
                                        );
                                      },
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element.namaPlatform,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(color: dark),
                                            ),
                                            Divider(
                                              color: grey50,
                                              thickness: 0.2.h,
                                            )
                                          ]),
                                    ),
                                    order: GroupedListOrder.ASC,
                                  );
                                case ResultStatus.noData:
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 14.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              'assets/images/Empty.png'),
                                          height: 15.h,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "Data yang dicari tidak ditemukan. Silahkan coba kata kunci lain!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: grey500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                case ResultStatus.error:
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              'assets/images/Error.png'),
                                          height: 15.h,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "Maaf, sepertinya terjadi kesalahan. Silahkan untuk mencoba kembali atau hubungi kami  jika masalah masih berlanjut!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: grey500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            })
                          : Obx(() {
                              switch (c.resultStateSearch.value.status) {
                                case ResultStatus.loading:
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: buttonColor1,
                                    ),
                                  );
                                case ResultStatus.hasData:
                                  return GroupedListView<dynamic, String>(
                                    shrinkWrap: true,
                                    elements: c.resultSearch.data,
                                    groupBy: (element) => element.namaPlatform
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    groupSeparatorBuilder:
                                        (String groupByValue) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          groupByValue,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: buttonColor1,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        )
                                      ],
                                    ),
                                    itemBuilder: (context, element) =>
                                        GestureDetector(
                                      onTap: () {
                                        Get.defaultDialog(
                                          radius: 25,
                                          titlePadding:
                                              EdgeInsets.only(top: 2.h),
                                          title: "Detail Lembaga",
                                          titleStyle: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: grey900,
                                                  fontWeight: FontWeight.w600),
                                          content: PinjolDialog(
                                            namaPlatform: element.namaPlatform,
                                            situs: element.situs,
                                            status: element.status,
                                          ),
                                        );
                                      },
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element.namaPlatform,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(color: dark),
                                            ),
                                            Divider(
                                              color: grey50,
                                              thickness: 0.2.h,
                                            )
                                          ]),
                                    ),
                                    order: GroupedListOrder.ASC,
                                  );
                                case ResultStatus.noData:
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 14.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              'assets/images/Empty.png'),
                                          height: 15.h,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "Data yang dicari tidak ditemukan. Silahkan coba kata kunci lain!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: grey500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                case ResultStatus.error:
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                              'assets/images/Error.png'),
                                          height: 15.h,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "Maaf, sepertinya terjadi kesalahan. Silahkan untuk mencoba kembali atau hubungi kami  jika masalah masih berlanjut!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: grey500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            }));
                }),
          ),
        ],
      ),
    );
  }
}

class IKDDialog extends StatelessWidget {
  final String namaPlatform;
  final String namaPT;
  final String suratTanda;
  final String tanggalTercatat;
  final String klaster;

  const IKDDialog({
    Key? key,
    required this.namaPlatform,
    required this.namaPT,
    required this.suratTanda,
    required this.tanggalTercatat,
    required this.klaster,
  }) : super(key: key);

  void _launchGoogleSearch(String query) async {
    final url = 'https://www.google.com/search?q=$query';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Platform : ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  namaPlatform,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                  maxLines: 3,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama PT         : ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  namaPT,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                  maxLines: 3,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Surat Tanda      : ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  suratTanda,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tanggal Tercatat: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  tanggalTercatat,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                  maxLines: 3,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Klaster             : ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  klaster,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                  maxLines: 3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          ElevatedButton(
            onPressed: () {
              _launchGoogleSearch(namaPlatform);
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: buttonColor2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Text(
              "Kunjungi Situs",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: backgroundColor1),
            ),
          )
        ],
      ),
    );
  }
}

class PinjolDialog extends StatelessWidget {
  final String namaPlatform;
  final String situs;
  final String status;

  const PinjolDialog(
      {Key? key,
      required this.namaPlatform,
      required this.situs,
      required this.status})
      : super(key: key);

  void _launchGoogleSearch(String query) async {
    final url = 'https://$query';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Platform: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  namaPlatform,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                  maxLines: 3,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status             : ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  status,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Situs              : ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: buttonColor1, fontWeight: FontWeight.w600),
              ),
              Flexible(
                child: Text(
                  situs,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: dark),
                  maxLines: 3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          ElevatedButton(
            onPressed: () {
              _launchGoogleSearch(situs);
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: buttonColor2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Text(
              "Kunjungi Situs",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: backgroundColor1),
            ),
          )
        ],
      ),
    );
  }
}
