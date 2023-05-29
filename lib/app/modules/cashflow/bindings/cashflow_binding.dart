import 'package:get/get.dart';

import 'package:nuha/app/modules/cashflow/controllers/laporankeuangan_controller.dart';
import 'package:nuha/app/modules/navbar/controllers/navbar_controller.dart';

import '../controllers/cashflow_controller.dart';

class CashflowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporankeuanganController>(
      () => LaporankeuanganController(),
    );
    Get.lazyPut<CashflowController>(
      () => CashflowController(),
    );

    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );
    Get.lazyPut<LaporankeuanganController>(
      () => LaporankeuanganController(),
    );
  }
}
