import 'package:get/get.dart';

import 'package:nuha/app/modules/konsultasi/controllers/generate_meeting_controller.dart';
import 'package:nuha/app/modules/konsultasi/controllers/history_consultation_controller.dart';
import 'package:nuha/app/modules/konsultasi/controllers/schedule_consultation_controller.dart';

import '../controllers/konsultasi_controller.dart';

class KonsultasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryConsultationController>(
      () => HistoryConsultationController(),
    );
    Get.lazyPut<GenerateMeetingController>(
      () => GenerateMeetingController(),
    );
    Get.lazyPut<KonsultasiController>(
      () => KonsultasiController(),
    );
    Get.lazyPut<ScheduleConsultationController>(
      () => ScheduleConsultationController(consultantId: Get.arguments),
    );
  }
}
