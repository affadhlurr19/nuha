import 'package:get/get.dart';

class MemulaiController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
}
