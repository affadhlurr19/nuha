import 'package:get/get.dart';
import 'package:nuha/app/modules/cashflow/controllers/anggaran_detail_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/transaksi_controller.dart';
import 'package:nuha/app/modules/home/controllers/home_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/laporankeuangan_controller.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_darurat_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_kendaraan_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pendidikan_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pensiun_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_pernikahan_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_rumah_controller.dart';
import 'package:nuha/app/modules/perencanaan_keuangan/controllers/pk_umroh_controller.dart';
import '../controllers/perencanaan_keuangan_controller.dart';

class PerencanaanKeuanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PkUmrohController>(
      () => PkUmrohController(),
    );
    Get.lazyPut<PkRumahController>(
      () => PkRumahController(),
    );
    Get.lazyPut<PkPernikahanController>(
      () => PkPernikahanController(),
    );
    Get.lazyPut<PkPensiunController>(
      () => PkPensiunController(),
    );
    Get.lazyPut<PkPendidikanController>(
      () => PkPendidikanController(),
    );
    Get.lazyPut<PkKendaraanController>(
      () => PkKendaraanController(),
    );
    Get.lazyPut<PkDaruratController>(
      () => PkDaruratController(),
    );
    Get.lazyPut<PerencanaanKeuanganController>(
      () => PerencanaanKeuanganController(),
    );
    Get.lazyPut<AnggaranDetailController>(
      () => AnggaranDetailController(),
    );
    Get.lazyPut<TransaksiController>(
      () => TransaksiController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<CashflowController>(
      () => CashflowController(),
    );
    Get.lazyPut<LaporankeuanganController>(
      () => LaporankeuanganController(),
    );
  }
}
