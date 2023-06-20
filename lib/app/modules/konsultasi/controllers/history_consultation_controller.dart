import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class HistoryConsultationController extends GetxController {
  RxBool isSelected = false.obs;
  RxInt tag = RxInt(1);

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
  }
}
