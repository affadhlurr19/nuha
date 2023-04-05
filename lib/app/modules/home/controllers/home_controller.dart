import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuha/app/routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Google Sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> logoutGoogle() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      Get.offAllNamed(Routes.LANDING);
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(Routes.LANDING);
    } catch (e) {
      print('Gagal Logout. $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotes() async* {
    String uid = auth.currentUser!.uid;

    yield* await firestore
        .collection("users")
        .doc(uid)
        .collection("notes")
        .orderBy(
          "created_at",
          descending: true,
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile() async* {
    String uid = auth.currentUser!.uid;

    yield* await firestore.collection("users").doc(uid).snapshots();
  }

  void deleteNote(String docID) async {
    try {
      String uid = auth.currentUser!.uid;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("notes")
          .doc(docID)
          .delete();
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Gagal Hapus note");
    }
  }
}
