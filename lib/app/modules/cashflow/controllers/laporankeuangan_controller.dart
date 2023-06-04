import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/constant/styles.dart';
import 'package:nuha/app/modules/cashflow/models/laporankeuangan_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
// import 'package:nuha/app/modules/cashflow/views/laporankeuangan_view.dart';
// import 'package:intl/intl.dart';

class LaporankeuanganController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  RxList<LineChart> lineChartM = <LineChart>[].obs;
  RxList<LineChart> lineChartK = <LineChart>[].obs;
  RxList<ChartPemasukan> chartPemasukan = <ChartPemasukan>[].obs;
  RxList<ChartPengeluaran> chartPengeluaran = <ChartPengeluaran>[].obs;

  var startDate = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .obs;
  var endDate = DateTime.now().obs;
  var totalPendapatan = 0.obs;
  var totalPengeluaran = 0.obs;

  @override
  void onInit() {
    super.onInit();

    getDataMasukKeluar();
    getDataPemasukan();
    getDataPengeluaran();
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDateRange:
          DateTimeRange(start: startDate.value, end: endDate.value),
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      cancelText: "BATAL",
      confirmText: "OK",
      saveText: "SIMPAN",
      helpText: "Pilih Rentang Tanggal",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: buttonColor1,
              onPrimary: backgroundColor1,
              onSurface: grey900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: grey900,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
            ),
          ),
          child: SizedBox(
            height: 40.h,
            width: 20.w, // Sesuaikan dengan ukuran yang diinginkan
            child: child,
          ),
        );
      },
    );

    if (newDateRange == null) {
      return;
    } else {
      startDate.value = newDateRange.start;
      endDate.value = newDateRange.end;
    }

    // getDataAnggaran();
    getDataPengeluaran();
    getDataMasukKeluar();
    getDataPemasukan();
  }

  Future<void> getDataPemasukan() async {
    String uid = auth.currentUser!.uid;
    var snapshotsPendapatan = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .get();
    Map<String, int> kategoriTotal = {};

    snapshotsPendapatan.docs.forEach((doc) {
      String kategori = doc.data()['kategori'];
      int nominal = doc.data()['nominal'];

      if (kategoriTotal.containsKey(kategori)) {
        kategoriTotal[kategori] = kategoriTotal[kategori]! + nominal;
      } else {
        kategoriTotal[kategori] = nominal;
      }
    });

    List<ChartPemasukan> list = kategoriTotal.entries
        .map((e) => ChartPemasukan(
              kategori: e.key,
              nominal: e.value,
            ))
        .toList();

    list.sort((a, b) => b.nominal!.compareTo(a.nominal!.toInt()));

    chartPemasukan.assignAll(list);
    // print(chartPemasukan);
  }

  Future<void> getDataPengeluaran() async {
    String uid = auth.currentUser!.uid;
    var snapshotsPengeluaran = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pengeluaran")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .get();
    Map<String, int> kategoriTotal = {};

    snapshotsPengeluaran.docs.forEach((doc) {
      String kategori = doc.data()['kategori'];
      int nominal = doc.data()['nominal'];

      if (kategoriTotal.containsKey(kategori)) {
        kategoriTotal[kategori] = kategoriTotal[kategori]! + nominal;
      } else {
        kategoriTotal[kategori] = nominal;
      }
    });

    List<ChartPengeluaran> list = kategoriTotal.entries
        .map((e) => ChartPengeluaran(
              kategori: e.key,
              nominal: e.value,
            ))
        .toList();

    list.sort((a, b) => b.nominal!.compareTo(a.nominal!.toInt()));

    chartPengeluaran.clear();
    chartPengeluaran.addAll(list);
    // print(chartPemasukan);
  }

  Future<void> getDataMasukKeluar() async {
    String uid = auth.currentUser!.uid;
    var snapShotsPemasukan = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .orderBy("tanggalTransaksi")
        .get();

    int totalNominal = snapShotsPemasukan.docs.fold(0, (total, doc) {
      int nominal = doc.data()["nominal"] as int;
      return total + nominal;
    });

    totalPendapatan.value = totalNominal;

    List<LineChart> list = snapShotsPemasukan.docs
        .map((e) => LineChart(
              jenisTransaksi: e.data()['jenisTransaksi'],
              nominal: e.data()['nominal'],
              // tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
              tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
              color: const Color(0XFF0096C7),
            ))
        .toList();
    lineChartM.assignAll(list);

    var snapShotsPengeluaran = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pengeluaran")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .orderBy("tanggalTransaksi")
        .get();

    int totalNominal2 = snapShotsPengeluaran.docs.fold(0, (total, doc) {
      int nominal = doc.data()["nominal"] as int;
      return total + nominal;
    });

    totalPengeluaran.value = totalNominal2;

    List<LineChart> list2 = snapShotsPengeluaran.docs
        .map((e) => LineChart(
            jenisTransaksi: e.data()['jenisTransaksi'],
            nominal: e.data()['nominal'],
            // tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
            tanggalTransaksi: e.data()['tanggalTransaksi'].toDate(),
            color: const Color(0XFFCC444B)))
        .toList();
    lineChartK.assignAll(list2);
  }
}
