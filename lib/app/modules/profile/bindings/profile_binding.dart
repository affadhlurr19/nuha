import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      tag: 'edit-profile',      
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      tag: 'ganti-kata-sandi',      
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      tag: 'ganti-foto-profil',      
    );
  }
}
