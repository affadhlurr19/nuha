import 'package:get/get.dart';

import '../controllers/perencanaan_keuangan_controller.dart';

class PerencanaanKeuanganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerencanaanKeuanganController>(
      () => PerencanaanKeuanganController(),
    );
  }
}
