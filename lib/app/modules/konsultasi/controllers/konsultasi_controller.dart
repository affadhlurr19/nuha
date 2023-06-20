import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class KonsultasiController extends GetxController {
  RxBool isSelected = false.obs;
  RxInt tag = RxInt(1);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> consultants = RxList<DocumentSnapshot>([]);
  RxList<DocumentSnapshot> detailConsultant = RxList<DocumentSnapshot>([]);
  RxBool shouldUpdate = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id', null);
    fetchData();
  }

  void fetchData() {
    ever(tag, (_) {
      updateData([]);
      getConsultant().listen((snapshot) {
        updateData(snapshot.docs);
      });
    });
  }

  void updateData(List<DocumentSnapshot> data) {
    consultants.assignAll(data);
  }

  Stream<QuerySnapshot> getConsultant() {
    if (tag.value == 1) {
      return firestore.collection('consultant').snapshots()
        ..where((_) => shouldUpdate.value);
    } else if (tag.value == 2) {
      return firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Dana Pensiun')
          .snapshots()
          .where((_) => shouldUpdate.value);
    } else if (tag.value == 3) {
      return firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Pajak')
          .snapshots()
          .where((_) => shouldUpdate.value);
    } else if (tag.value == 4) {
      return firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Perencanaan Keuangan')
          .snapshots()
          .where((_) => shouldUpdate.value);
    } else {
      return firestore
          .collection('consultant')
          .where('category', isEqualTo: 'Review Keuangan')
          .snapshots()
          .where((_) => shouldUpdate.value);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetailConsultant(
      String id) async {
    return FirebaseFirestore.instance.collection('consultant').doc(id).get();
  }
}
