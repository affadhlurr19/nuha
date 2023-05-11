import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/komentar_artikel_model.dart';

class KomentarArtikelController extends GetxController {
  final String idArtikel;
  final comments = <Komentar>[].obs;
  TextEditingController descC = TextEditingController();

  KomentarArtikelController({required this.idArtikel});

  @override
  void onInit() {
    loadComments();
    super.onInit();
  }

  Future<void> loadComments() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('comments')
        .where('idArtikel', isEqualTo: idArtikel)
        .orderBy('createdAt', descending: true)
        .get();

    comments.value = querySnapshot.docs.map((doc) {
      return Komentar(
        idKomentar: doc.id,
        idArtikel: doc.data()['idArtikel'],
        idUser: doc.data()['idUser'],
        descKomentar: doc.data()['descKomentar'],
        createdAt: doc.data()['createdAt'].toDate(),
      );
    }).toList();
  }

  Future<void> addComment(String descKomentar) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final docRef = await FirebaseFirestore.instance.collection('comments').add({
      'idArtikel': idArtikel,
      'idUser': currentUser!.uid,
      'descKomentar': descKomentar,
      'createdAt': DateTime.now(),
    });

    final comment = Komentar(
      idKomentar: docRef.id,
      idArtikel: idArtikel,
      idUser: currentUser.uid,
      descKomentar: descKomentar,
      createdAt: DateTime.now(),
    );

    comments.insert(0, comment);
  }

  Future<void> deleteComment(String id) async {
    await FirebaseFirestore.instance.collection('comments').doc(id).delete();
    comments.removeWhere((comment) => comment.idKomentar == id);
  }
}
