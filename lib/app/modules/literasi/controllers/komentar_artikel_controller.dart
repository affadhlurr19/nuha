import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/balasan_komentar_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/komentar_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/pengguna_model.dart';
import 'package:nuha/app/utility/dialog_message.dart';
import 'package:rxdart/rxdart.dart';

class KomentarArtikelController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final String idArtikel;
  final comments = <Komentar>[].obs;
  final pengguna = <Pengguna>[].obs;
  final replys = <Reply>[].obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController descC = TextEditingController();
  TextEditingController replyDescC = TextEditingController();
  DialogMessage dialogMessage = DialogMessage();

  //inisialisasi animasi transisi
  late AnimationController animationController;
  late Animation<double> animation;

  KomentarArtikelController({required this.idArtikel});

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Stream<List<Komentar>> loadComments() {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final commentsCollection =
        FirebaseFirestore.instance.collection('comments');
    final usersSubject = BehaviorSubject<QuerySnapshot>();

    usersCollection.snapshots().listen((usersSnapshot) {
      usersSubject.add(usersSnapshot);
    });

    return usersSubject.switchMap((usersSnapshot) {
      return commentsCollection
          .where('idArtikel', isEqualTo: idArtikel)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((commentQuerySnapshot) {
        // Membersihkan data sebelum memuat perubahan data baru
        comments.clear();
        var usersDocs = usersSnapshot.docs;
        var commentsDocs = commentQuerySnapshot.docs;
        var uniqueComments = commentsDocs
            .map((commentDoc) {
              var commentData = commentDoc.data();

              for (var userDoc in usersDocs) {
                var userData = userDoc.data() as Map<String, dynamic>;
                var uid = userData['uid'] as String?;
                if (uid == commentData['idUser']) {
                  if (userData['profile'] != null) {
                    var profile = userData['profile'] as String;
                    return Komentar(
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: profile,
                      descKomentar: commentData['descKomentar'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  } else {
                    // var linkProfile = userData['name'];
                    // var profile =
                    //     "https://ui-avatars.com/api/?name=$linkProfile";
                    return Komentar(
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: "",
                      descKomentar: commentData['descKomentar'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  }
                }
              }

              return null;
            })
            .whereType<Komentar>()
            .toList();

        comments.addAll(uniqueComments);
        return comments.toList();
      });
    });
  }

  Stream<List<Reply>> loadReplyComments(String idKomentar) {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final commentsCollection =
        FirebaseFirestore.instance.collection('comments');
    final usersSubject = BehaviorSubject<QuerySnapshot>();

    usersCollection.snapshots().listen((usersSnapshot) {
      usersSubject.add(usersSnapshot);
    });

    return usersSubject.switchMap((usersSnapshot) {
      return commentsCollection
          .doc(idKomentar)
          .collection('reply_comment_article')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((commentQuerySnapshot) {
        // membersihkan data sebelum memuat perubahan data baru
        replys.clear();
        var usersDocs = usersSnapshot.docs;
        var commentsDocs = commentQuerySnapshot.docs;
        var uniqueComments = commentsDocs
            .map((commentDoc) {
              var commentData = commentDoc.data();

              for (var userDoc in usersDocs) {
                var userData = userDoc.data() as Map<String, dynamic>;
                var uid = userData['uid'] as String?;
                if (uid == commentData['idUser']) {
                  if (userData['profile'] != null) {
                    var profile = userData['profile'] as String;
                    return Reply(
                      idReply: commentDoc.id,
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: profile,
                      descBalasan: commentData['descBalasan'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  } else {
                    // var linkProfile = userData['name'];
                    // var profile =
                    //     "https://ui-avatars.com/api/?name=$linkProfile]";
                    return Reply(
                      idReply: commentDoc.id,
                      idKomentar: commentDoc.id,
                      idArtikel: commentData['idArtikel'],
                      idUser: commentData['idUser'],
                      name: userData['name'],
                      imageURL: "",
                      descBalasan: commentData['descBalasan'],
                      createdAt: commentData['createdAt'].toDate(),
                    );
                  }
                }
              }

              return null;
            })
            .whereType<Reply>()
            .toList();

        replys.addAll(uniqueComments);
        return replys.toList();
      });
    });
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      return docUser.data();
    } catch (e) {
      // ignore: avoid_print
      print('Tidak dapat get data user');
      return null;
    }
  }

  Future<void> addComment(String descKomentar) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('comments').add({
      'idArtikel': idArtikel,
      'idUser': currentUser!.uid,
      'descKomentar': descKomentar,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> addReplyComment(String idKomentar, String descBalasan) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(idKomentar)
        .collection('reply_comment_article')
        .add({
      'idArtikel': idArtikel,
      'idUser': currentUser!.uid,
      'descBalasan': descBalasan,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> deleteComment(String id) async {
    await FirebaseFirestore.instance.collection('comments').doc(id).delete();
    comments.removeWhere((comment) => comment.idKomentar == id);
  }
}
