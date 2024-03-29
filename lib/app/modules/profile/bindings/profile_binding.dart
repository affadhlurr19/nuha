import 'package:get/get.dart';

import 'package:nuha/app/modules/profile/controllers/auth_pin_controller.dart';
import 'package:nuha/app/modules/profile/controllers/delete_account_controller.dart';
import 'package:nuha/app/modules/profile/controllers/edit_pin_controller.dart';
import 'package:nuha/app/modules/profile/controllers/notification_controller.dart';
import 'package:nuha/app/modules/profile/controllers/pin_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPinController>(
      () => EditPinController(),
      tag: 'setel-ulang-pin-on-auth',
    );
    Get.lazyPut<EditPinController>(
      () => EditPinController(),
      tag: 'setel-ulang-pin',
    );
    Get.lazyPut<DeleteAccountController>(
      () => DeleteAccountController(),
    );
    Get.lazyPut<AuthPinController>(
      () => AuthPinController(),
    );
    Get.lazyPut<EditPinController>(
      () => EditPinController(),
    );
    Get.lazyPut<PinController>(
      () => PinController(),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
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
