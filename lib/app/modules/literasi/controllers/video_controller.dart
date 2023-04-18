import 'package:get/get.dart';

class VideoController extends GetxController {
  //TODO: Implement VideoControllerController

  final count = 10.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
