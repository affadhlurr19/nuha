import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/laporankeuangan_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:nuha/app/modules/cashflow/models/laporankeuangan_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LaporankeuanganView extends GetView<LaporankeuanganController> {
  LaporankeuanganView({Key? key}) : super(key: key);
  final c = Get.find<LaporankeuanganController>();
  final con = Get.find<CashflowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [buttonColor1, buttonColor2],
              ),
            ),
            height: 16.625.h,
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              // Add AppBar here only
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                "Laporan Keuangan",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: backgroundColor1,
                    ),
              ),
              actions: [
                IconButton(
                  icon: const Iconify(
                    MaterialSymbols.download,
                    color: backgroundColor1,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              c.pickDateRange();
            },
            child: Container(
              width: 84.4444.w,
              height: 6.75.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
              margin: EdgeInsets.fromLTRB(7.77778.w, 13.25.h, 7.77778.w, 0.h),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: backgroundColor1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Iconify(
                    MaterialSymbols.calendar_month,
                    size: 18.sp,
                    color: buttonColor1,
                  ),
                  Column(
                    children: [
                      Obx(() => Text(
                            // "WAit",
                            // "${DateFormat('dd MMMM yyyy').format(c.dateRange.start)} - ${DateFormat('dd MMMM yyyy').format(c.dateRange.end)}",
                            "${DateFormat('dd MMMM yyyy').format(c.startDate.value)} - ${DateFormat('dd MMMM yyyy').format(c.endDate.value)}",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: grey900,
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                      Text(
                        "Atur rentang laporan keuanganmu!",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: grey500),
                      ),
                    ],
                  ),
                  Iconify(
                    Ic.sharp_arrow_forward_ios,
                    size: 15.sp,
                    color: buttonColor1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(7.77778.w, 22.h, 7.77778.w, 0.h),
            height: 75.h,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 0),
              shrinkWrap: true,
              children: [
                Text(
                  "Pendapatan vs Pengeluaran",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: dark,
                      ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                SizedBox(
                  height: 32.5.h,
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis: NumericAxis(
                      rangePadding: ChartRangePadding.auto,
                      // numberFormat: NumberFormat.currency(
                      //     locale: 'id', symbol: "Rp", decimalDigits: 0),
                      numberFormat: NumberFormat.compact(locale: 'id'),
                    ),
                    legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    series: <ChartSeries>[
                      LineSeries<LineChart, DateTime>(
                        name: 'Pendapatan',
                        color: const Color(0XFF0096C7),
                        dataSource: c.lineChartM,
                        pointColorMapper: (LineChart data, _) => data.color,
                        xValueMapper: (LineChart dat, _) =>
                            dat.tanggalTransaksi,
                        yValueMapper: (LineChart dat, _) => dat.nominal,
                      ),
                      LineSeries<LineChart, DateTime>(
                        name: 'Pengeluaran',
                        color: const Color(0XFFCC444B),
                        dataSource: c.lineChartK,
                        pointColorMapper: (LineChart data, _) => data.color,
                        xValueMapper: (LineChart dat, _) =>
                            dat.tanggalTransaksi,
                        yValueMapper: (LineChart dat, _) => dat.nominal,
                      )
                    ],
                  ),
                ),
                const Divider(),
                Text(
                  "Pengeluaran",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: dark,
                      ),
                ),
                Obx(() => Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                          .format(con.totalPengeluaran.value),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color(0XFFCC444B),
                          fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 32.5.h,
                  child: SfCircularChart(
                    margin: const EdgeInsets.all(0),
                    series: <CircularSeries>[
                      DoughnutSeries<ChartPengeluaran, String>(
                        dataSource: c.chartPengeluaran,
                        xValueMapper: (ChartPengeluaran data, _) =>
                            data.kategori,
                        yValueMapper: (ChartPengeluaran data, _) =>
                            data.nominal,
                        dataLabelMapper: (ChartPengeluaran data, _) =>
                            data.kategori,
                        radius: '70%',
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelPosition: ChartDataLabelPosition.outside,
                          // labelIntersectAction: LabelIntersectAction.shift,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Text(
                  "Pendapatan",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: dark,
                      ),
                ),
                Obx(() => Text(
                      NumberFormat.currency(
                              locale: 'id', symbol: "Rp. ", decimalDigits: 0)
                          .format(con.totalPendapatan.value),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color(0XFF0096C7),
                          fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 32.5.h,
                  child: SfCircularChart(
                    margin: const EdgeInsets.all(0),
                    series: <CircularSeries>[
                      DoughnutSeries<ChartPemasukan, String>(
                        dataSource: c.chartPemasukan,
                        xValueMapper: (ChartPemasukan data, _) => data.kategori,
                        yValueMapper: (ChartPemasukan data, _) => data.nominal,
                        dataLabelMapper: (ChartPemasukan data, _) =>
                            data.kategori,
                        radius: '70%',
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelPosition: ChartDataLabelPosition.outside,
                          // labelIntersectAction: LabelIntersectAction.shift,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
