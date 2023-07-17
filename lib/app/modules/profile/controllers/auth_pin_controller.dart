import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class AuthPinController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  DialogMessage dialogMessage = DialogMessage();

  void logout() async {
    try {
      await auth.signOut();
      Get.offAndToNamed(Routes.MEMULAI);
    } catch (e) {
      dialogMessage.errMsg('$e');
    }
  }

  Future<void> logoutGoogle() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      Get.offAndToNamed(Routes.MEMULAI);
    } catch (e) {
      dialogMessage.errMsg('$e');
    }
  }
}
