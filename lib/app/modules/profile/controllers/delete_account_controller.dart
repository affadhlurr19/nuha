import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/profile/controllers/profile_controller.dart';
import 'package:nuha/app/utility/dialog_message.dart';

class DeleteAccountController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DialogMessage dialogMessage = DialogMessage();
  RxBool isLoading = false.obs;
  RxString accountDeleted = ''.obs;
  final ProfileController _profileController = ProfileController();

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;
      var user = auth.currentUser;
      String uid = auth.currentUser!.uid;
      accountDeleted.value = uid;

      user!.delete();

      auth.currentUser!.providerData[0].providerId == 'google.com'
          ? _profileController.logoutGoogle()
          : _profileController.logout();
      // Get.back();
      // Get.back();

      QuerySnapshot deleteUsersCollection = await firestore
          .collection('users')
          .where('uid', isEqualTo: accountDeleted.value)
          .get();
      QuerySnapshot deleteArticleCommentCollection = await firestore
          .collection('comments')
          .where('idUser', isEqualTo: accountDeleted.value)
          .get();
      QuerySnapshot deleteVideoCommentCollection = await firestore
          .collection('comments_video')
          .where('idUser', isEqualTo: accountDeleted.value)
          .get();
      QuerySnapshot deletetransactionCollection = await firestore
          .collection('consultation_transaction')
          .where('userId', isEqualTo: accountDeleted.value)
          .get();

      if (deleteUsersCollection.docs.isNotEmpty) {
        for (var doc1 in deleteUsersCollection.docs) {
          await doc1.reference.delete();
        }
      }

      if (deleteArticleCommentCollection.docs.isNotEmpty) {
        for (var doc2 in deleteArticleCommentCollection.docs) {
          await doc2.reference.delete();
        }
      }

      if (deleteVideoCommentCollection.docs.isNotEmpty) {
        for (var doc3 in deleteVideoCommentCollection.docs) {
          await doc3.reference.delete();
        }
      }

      if (deletetransactionCollection.docs.isNotEmpty) {
        for (var doc4 in deletetransactionCollection.docs) {
          await doc4.reference.delete();
        }
      }

      dialogMessage.successMsg('Akun anda berhasil dihapus');

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      dialogMessage.errMsg(e.toString());
    }
  }
}
