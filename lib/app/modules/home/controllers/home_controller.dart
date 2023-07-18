import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuha/app/modules/literasi/models/notifikasi_artikel_model.dart';

import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/routes/app_pages.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/utility/result_state.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  //Google Sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();

  var startDate = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .obs;
  var endDate = DateTime.now().obs;
  var totalNominal = 0;
  var rekomendasiZakat = 0.0.obs;
  var dataAnggaran = 0.obs;

  var resultState = ResultState.loading().obs;
  ListArtikelProvider _listArtikelProvider = ListArtikelProvider();

  String _message = '';
  late NotifikasiArtikel _notifikasiArtikel;

  NotifikasiArtikel get result => _notifikasiArtikel;
  String get message => _message;

  @override
  void onInit() {
    super.onInit();
    getRekomendasiZakat();
    checkAnggaranCollectionExist();
  }

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

    yield* firestore
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

    yield* firestore.collection("users").doc(uid).snapshots();
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

  Future<void> getRekomendasiZakat() async {
    String uid = auth.currentUser!.uid;
    var snapshotsPendapatan = await firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .where("tanggalTransaksi",
            isGreaterThanOrEqualTo: startDate.value,
            isLessThanOrEqualTo: endDate.value)
        .get();

    snapshotsPendapatan.docs.forEach((doc) {
      int nominal = doc.data()['nominal'];

      totalNominal += nominal;
    });

    rekomendasiZakat.value = 0.025 * totalNominal.toDouble();
  }

  Future<bool> checkAnggaranCollectionExist() async {
    String uid = auth.currentUser!.uid;

    try {
      CollectionReference anggaranCollection =
          firestore.collection("users").doc(uid).collection("anggaran");
      QuerySnapshot querySnapshot = await anggaranCollection.get();

      dataAnggaran.value = querySnapshot.docs.length;

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      print('Terjadi kesalahan: $error');
      return false;
    }
  }

  Future<dynamic> fetchArticleInformation() async {
    try {
      final inform =
          await _listArtikelProvider.getNotificationArticle(http.Client());
      if (inform.data.isEmpty) {
        resultState.value = ResultState.noData();
        return _message = 'Data Kosong';
      } else {
        resultState.value = ResultState.hasData(inform);
        return _notifikasiArtikel = inform;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      return _message = '$e';
    }
  }
}
