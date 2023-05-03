import 'package:get/get.dart';
import 'package:nuha/app/modules/cashflow/controllers/cashflow_controller.dart';
import 'package:nuha/app/modules/fincheck/controllers/fincheck_controller.dart';

import '../controllers/navbar_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(
      () => NavbarController(),
    );

    Get.lazyPut<FincheckController>(
      () => FincheckController(),
    );    
  }
}
