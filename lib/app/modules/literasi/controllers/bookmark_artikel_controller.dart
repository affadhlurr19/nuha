import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookmarkArtikelController extends GetxController {
  final RxBool isBookmarked = false.obs;
  final RxInt bookmarkCount = 0.obs;
  late String bookmarkId;
  final CollectionReference bookmarksCollection =
      FirebaseFirestore.instance.collection('likes');

  void toggleBookmark(String artikelId, String uId) async {
    isBookmarked.value = !isBookmarked.value;
    bookmarkCount.value =
        isBookmarked.value ? bookmarkCount.value + 1 : bookmarkCount.value - 1;

    if (isBookmarked.value) {
      final docRef = await bookmarksCollection.add({
        'artikelId': artikelId,
        'uId': uId,
      });
      bookmarkId = docRef.id;
    } else {
      await bookmarksCollection.doc(bookmarkId).delete();
    }
  }
}
