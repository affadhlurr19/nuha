import 'package:get/get.dart';

class VideoController extends GetxController {
  final count = 10.obs;

  void increment() => count.value++;
}
