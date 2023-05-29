import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuha/app/constant/styles.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:nuha/app/modules/cashflow/controllers/laporankeuangan_controller.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class CashflowController extends GetxController {
  LaporankeuanganController laporankeuanganController =
      Get.find<LaporankeuanganController>();

  TextEditingController nominalTransaksiC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();
  TextEditingController nomAnggaranC = TextEditingController();
  TextEditingController searchAnggaranC = TextEditingController();
  TextEditingController searchTransaksiC = TextEditingController();
  TextEditingController searchTransInAnggaranC = TextEditingController();
  TextEditingController namaTransaksiC = TextEditingController();
  RxBool isLoading = false.obs;

  late TabController tabController;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  var jenisC = "Pengeluaran".obs;
  var kategoriC = "Pilih Kategori".obs;
  var kategoriStat = "".obs;
  var selectDate = DateTime.now().obs;
  var currentTab = 0.obs;
  var totalNominal = 0.obs;
  var totalPendapatan = 0.obs;
  var totalPengeluaran = 0.obs;
  var angTerpakai = 0.obs;
  var sisaAnggaran = 0.obs;
  var persenAnggaran = "".obs;

  var queryAwal = [].obs; //list hasil search anggaran
  var tempSearch = [].obs; //list hasil search transaksi
  var querySearch = [].obs; //list hasil search transaksi pada anggaran tertentu
  var transaksiList = [].obs;

  String jenisKategori = "";
  String transaksiUrl = "";
  // var anggaranActive = true.obs;

  XFile? image;

  final GroupedItemScrollController itemScrollController =
      GroupedItemScrollController();

  @override
  void onInit() {
    super.onInit();
    totalNominalKategori();
    totalTransPendapatan();
    totalTransPengeluaran();
    countAnggaranTerpakai();
  }

  void changeTabIndex(int index) {
    currentTab.value = index;
    // print(currentTab);
    update();
  }

  void updateToPendapatan() {
    jenisC.value = "Pendapatan";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";
    Get.back();
  }

  void updateToPengeluaran() {
    jenisC.value = "Pengeluaran";
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";

    Get.back();
  }

  void updateKategori(text) {
    kategoriC.value = text;
    kategoriStat.value = "choosen";

    Get.back();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2024),
      cancelText: "BATAL",
      confirmText: "OK",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: buttonColor1,
              onPrimary: backgroundColor1,
              onSurface: grey900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: grey900,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectDate.value) {
      selectDate.value = pickedDate;
    }
  }

  void kategoriCheck() {
    if (kategoriC.value == "Asuransi" ||
        kategoriC.value == "Pendidikan" ||
        kategoriC.value == "Transportasi" ||
        kategoriC.value == "Sosial") {
      jenisKategori = "Umum";
    } else if (kategoriC.value == "Makan" ||
        kategoriC.value == "Belanja" ||
        kategoriC.value == "Hiburan" ||
        kategoriC.value == "Tagihan" ||
        kategoriC.value == "Kesehatan") {
      jenisKategori = "Biaya Hidup";
    } else {
      jenisKategori = "Lainnya";
    }
  }

  Color getProgressColor(double percent) {
    if (percent >= 0.95) {
      return Colors.red;
    } else if (percent >= 0.9) {
      return Colors.orange;
    } else if (percent >= 0.8) {
      return buttonColor2;
    } else {
      return buttonColor1;
    }
  }

  void addAnggaran(context) async {
    if (nomAnggaranC.text.isNotEmpty && kategoriC.isNotEmpty) {
      isLoading.value = true;
      try {
        String uid = auth.currentUser!.uid;
        kategoriCheck();
        String id = firestore.collection("users").doc().id;
        await firestore
            .collection("users")
            .doc(uid)
            .collection("anggaran")
            .doc(id)
            .set({
          "id": id,
          "kategori": kategoriC.value,
          "nominal": int.parse(nomAnggaranC.text.replaceAll('.', '')),
          "jenisAnggaran": jenisKategori,
          "nominalTerpakai": 0,
          "persentase": "0.0",
          "sisaLimit": int.parse(nomAnggaranC.text.replaceAll('.', '')),
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
        });
        isLoading.value = false;

        kategoriC.value = "Pilih Kategori";
        nomAnggaranC.text = "0";

        totalNominalKategori();
        countAnggaranDetail(kategoriC.value);

        Navigator.pop(context);
      } catch (e) {
        isLoading.value = false;
        // print(e);
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat menambahkan data");
      }
    } else {
      Get.snackbar("TERJADI KESALAHAN", "Kategori dan nominal wajib diisi");
    }
  }

  Future<Map<String, dynamic>?> getAnggaranById(String docId) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .get();
      // sisaTransAnggaran(doc.data()?["kategori"], doc.data()?["nominal"], docId);
      countAnggaranDetail(doc.data()?["kategori"]);

      return doc.data();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  void updateAnggaranById(context, String docId) async {
    isLoading.value = true;
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .get();

      countAnggaranDetail(doc.data()?["kategori"]);

      await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .update({
        "nominal": int.parse(nomAnggaranC.text.replaceAll('.', '')),
        "updatedAt": DateTime.now().toIso8601String(),
      });

      isLoading.value = false;
      totalNominalKategori();

      Navigator.pop(context);
    } catch (e) {
      // print(e);
      isLoading.value = false;
      Get.snackbar("TERJADI KESALAHAN", "Tidak mengubah data");
    }
  }

  void deleteAnggaranById(context, String docId) async {
    isLoading.value = true;
    try {
      String uid = auth.currentUser!.uid;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .doc(docId)
          .delete();
      isLoading.value = false;
      totalNominalKategori();
      countAnggaranTerpakai();

      Get.back();
      Navigator.pop(context);

      Get.snackbar("DELETE DATA BERHASIL",
          "Data Anda telah kami hapus dari database kami");
    } catch (e) {
      // print(e);
      isLoading.value = false;
      Get.snackbar("TERJADI KESALAHAN", "Tidak mengubah data");
    }
  }

  void checkAnggaranKategori(String text) async {
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .where("kategori", isEqualTo: text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // var anggaranActive = false;
        Get.back();
        Get.snackbar("Terjadi Kesalahan",
            "Anda sudah pernah membuat anggaran dengan kategori ini!");
      } else {
        updateKategori(text);
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSemuaAnggaran() async* {
    String uid = auth.currentUser!.uid;
    if (currentTab.value == 0) {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .snapshots();
    } else if (currentTab.value == 1) {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("jenisAnggaran", isEqualTo: "Umum")
          .snapshots();
    } else if (currentTab.value == 2) {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("jenisAnggaran", isEqualTo: "Biaya Hidup")
          .snapshots();
    } else {
      yield* firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("jenisAnggaran", isEqualTo: "Lainnya")
          .snapshots();
    }
  }

  pickImageTransaksi(String pickCam) async {
    final ImagePicker picker = ImagePicker();
    if (pickCam == "kamera") {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      update();
      Get.back();
    }
  }

  void resetImageTransaksi() async {
    image = null;
    update();
  }

  void updateImageTransaksi(String foto) async {
    image = null;
    update();
  }

  void resetTransaksi() async {
    kategoriC.value = "Pilih Kategori";
    kategoriStat.value = "";
    nominalTransaksiC.text = "0";
    namaTransaksiC.text = "";
    selectDate.value = DateTime.now();
    deskripsiC.text = "";
    resetImageTransaksi();
  }

  void addTransaksi(context) async {
    if (jenisC.isNotEmpty &&
        nominalTransaksiC.text.isNotEmpty &&
        kategoriC.isNotEmpty &&
        kategoriC.value != "Pilih Kategori" &&
        namaTransaksiC.text.isNotEmpty &&
        selectDate.toString().isNotEmpty) {
      isLoading.value = true;
      String uid = auth.currentUser!.uid;
      String random = DateTime.now().toIso8601String();
      String id = firestore.collection("users").doc().id;

      if (image != null) {
        String ext = image!.name.split(".").last;
        await storage
            .ref(uid)
            .child("tr$random.$ext")
            .putFile(File(image!.path));

        String urlTransaksi =
            await storage.ref(uid).child("tr$random.$ext").getDownloadURL();

        transaksiUrl = urlTransaksi;
      }

      // String formattedDate =
      //     DateFormat('dd MMMM yyyy').format(selectDate.value);

      // print(formattedDate);

      try {
        kategoriCheck();
        countAnggaranDetail(kategoriC.value);
        await firestore
            .collection("users")
            .doc(uid)
            .collection("transaksi")
            .doc(id)
            .set({
          "id": id,
          "jenisTransaksi": jenisC.value,
          "namaTransaksi": namaTransaksiC.text,
          "kategori": kategoriC.value,
          "nominal": int.parse(nominalTransaksiC.text.replaceAll('.', '')),
          "tanggalTransaksi": selectDate.value,
          "deskripsi": deskripsiC.text,
          "foto": transaksiUrl,
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
        });

        isLoading.value = false;

        resetTransaksi();
        totalTransPendapatan();
        totalTransPengeluaran();

        Navigator.pop(context);
      } catch (e) {
        isLoading.value = false;
        // print(e);
        Get.snackbar("TERJADI KESALAHAN", "Tidak dapat menambahkan data");
      }
    } else {
      Get.snackbar(
          "TERJADI KESALAHAN", "Kolom bertanda bintang(*) wajib diisi");
    }
  }

  void countAnggaranDetail(String kategori) async {
    String uid = auth.currentUser!.uid;
    int nomTotal = 0;
    String idData = "";
    int nominal = 0;
    int sisaLimit = 0;
    String persentaseLimit = "";

    firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("kategori", isEqualTo: kategori)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        int nominal = doc.data()['nominal'];
        nomTotal += nominal;
      }

      firestore
          .collection("users")
          .doc(uid)
          .collection("anggaran")
          .where("kategori", isEqualTo: kategori)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          idData = value.docs[0].data()["id"];
          nominal = value.docs[0].data()["nominal"];

          sisaLimit = nominal - nomTotal;
          persentaseLimit = (nomTotal / nominal).toStringAsFixed(2);

          firestore
              .collection("users")
              .doc(uid)
              .collection("anggaran")
              .doc(idData)
              .update({
            "nominalTerpakai": nomTotal,
            "sisaLimit": sisaLimit,
            "persentase": persentaseLimit,
          });
        }
      });
    });

    countAnggaranTerpakai();
  }

  void totalNominalKategori() async {
    totalNominal.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominal = doc.data()['nominal'];
        totalNominal += nominal;
      }

      countAnggaranSisa();
    });
  }

  void countAnggaranTerpakai() async {
    angTerpakai.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("anggaran")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominalTerpakai = doc.data()['nominalTerpakai'];
        angTerpakai += nominalTerpakai;
      }
      laporankeuanganController.getDataPengeluaran();
      laporankeuanganController.getDataMasukKeluar();
      laporankeuanganController.getDataPemasukan();
      countAnggaranSisa();
    });
  }

  void countAnggaranSisa() async {
    sisaAnggaran.value = totalNominal.value - angTerpakai.value;
    persenAnggaran.value =
        (angTerpakai.value / totalNominal.value).toStringAsFixed(2);
  }

  void totalTransPendapatan() async {
    totalPendapatan.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pendapatan")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominalTrans = doc.data()['nominal'];
        totalPendapatan += nominalTrans;
      }
      // print('Total nominal: $totalNominal');
    });
  }

  void totalTransPengeluaran() async {
    totalPengeluaran.value = 0;
    String uid = auth.currentUser!.uid;
    firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("jenisTransaksi", isEqualTo: "Pengeluaran")
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        int nominalTrans = doc.data()['nominal'];
        totalPengeluaran += nominalTrans;
      }
      // print('Total nominal: $totalNominal');
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSemuaTransaksi() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .orderBy("tanggalTransaksi", descending: true)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getTransaksiById(String docId) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("transaksi")
          .doc(docId)
          .get();
      return doc.data();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  void updateTransaksiById(context, String docId) async {
    isLoading.value = true;
    if (jenisC.isNotEmpty &&
        nominalTransaksiC.text.isNotEmpty &&
        kategoriC.isNotEmpty &&
        kategoriC.value != "Pilih Kategori" &&
        namaTransaksiC.text.isNotEmpty &&
        selectDate.toString().isNotEmpty) {
      String uid = auth.currentUser!.uid;

      if (image != null) {
        String ext = image!.name.split(".").last;
        await storage.ref(uid).child("$docId.$ext").putFile(File(image!.path));

        String urlTransaksi =
            await storage.ref(uid).child("$docId.$ext").getDownloadURL();

        transaksiUrl = urlTransaksi;
      }

      // String formattedDate =
      //     DateFormat('dd MMMM yyyy').format(selectDate.value);

      try {
        // print(kategoriC.value);

        countAnggaranDetail(kategoriC.value);

        await firestore
            .collection("users")
            .doc(uid)
            .collection("transaksi")
            .doc(docId)
            .update({
          "jenisTransaksi": jenisC.value,
          "namaTransaksi": namaTransaksiC.text,
          "kategori": kategoriC.value,
          "nominal": int.parse(nominalTransaksiC.text.replaceAll('.', '')),
          "tanggalTransaksi": selectDate.value,
          "deskripsi": deskripsiC.text,
          "foto": transaksiUrl,
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String(),
        });
        isLoading.value = false;

        resetTransaksi();
        totalTransPendapatan();
        totalTransPengeluaran();

        // Get.back();
        Navigator.pop(context);
      } catch (e) {
        // print(e);
        isLoading.value = false;
        Get.snackbar("TERJADI KESALAHAN", "Tidak mengubah data");
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTransaksiKategori(
      String katTransaksi) async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("transaksi")
        .where("kategori", isEqualTo: katTransaksi)
        .snapshots();
  }

  void searchAnggaran(String data) async {
    // print(data);
    String uid = auth.currentUser!.uid;

    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      var capitalize = data.capitalizeFirst;
      // print(capitalize);
      if (queryAwal.isEmpty && data.isNotEmpty) {
        CollectionReference anggaran =
            firestore.collection("users").doc(uid).collection("anggaran");
        final keyNameResult = await anggaran
            .where("kategori", isGreaterThanOrEqualTo: capitalize)
            .where("kategori", isLessThan: '${capitalize}z')
            .get();

        // print("Total data: ${keyNameResult.docs.length}");
        if (keyNameResult.docs.isNotEmpty) {
          queryAwal.value = [];
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          // print(queryAwal);
        }
      }
    }

    queryAwal.refresh();
    update();
  }

  void searchTransaksi(String data) async {
    // print(data);
    String uid = auth.currentUser!.uid;

    if (data.isEmpty) {
      tempSearch.value = [];
    } else {
      var capitalize = data.capitalizeFirst;
      // print(capitalize);
      if (tempSearch.isEmpty && data.isNotEmpty) {
        CollectionReference transaksi =
            firestore.collection("users").doc(uid).collection("transaksi");
        final keyNameResult = await transaksi
            .where("namaTransaksi", isGreaterThanOrEqualTo: capitalize)
            .where("namaTransaksi", isLessThan: '${capitalize}z')
            .get();

        // print("Total data: ${keyNameResult.docs.length}");
        if (keyNameResult.docs.isNotEmpty) {
          tempSearch.value = [];
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            tempSearch
                .add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          // print(tempSearch);
        }
      }
    }

    tempSearch.refresh();
    update();
  }

  void deleteTransaksiById(context, String docId) async {
    isLoading.value = true;
    String kategoriValue = "";
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("users")
          .doc(uid)
          .collection("transaksi")
          .doc(docId)
          .get();
      kategoriValue = doc.data()?["kategori"];

      countAnggaranDetail(kategoriValue);

      await firestore
          .collection("users")
          .doc(uid)
          .collection("transaksi")
          .doc(docId)
          .delete();
      isLoading.value = false;

      resetTransaksi();
      totalTransPendapatan();
      totalTransPengeluaran();

      Get.back();
      Navigator.pop(context);

      Get.snackbar("DELETE DATA BERHASIL",
          "Data Anda telah kami hapus dari database kami");
    } catch (e) {
      // print(e);
      isLoading.value = false;
      Get.snackbar("TERJADI KESALAHAN", "Tidak mengubah data");
    }
  }

  void searchTransInAnggaran(String data, String katTransaksi) async {
    // print(data);
    String uid = auth.currentUser!.uid;

    if (data.isEmpty) {
      querySearch.value = [];
    } else {
      var capitalize = data.capitalizeFirst;
      // print(capitalize);
      if (querySearch.isEmpty && data.isNotEmpty) {
        CollectionReference transInAnggaran =
            firestore.collection("users").doc(uid).collection("transaksi");
        final keyNameResult = await transInAnggaran
            .where("kategori", isEqualTo: katTransaksi)
            .where("namaTransaksi", isGreaterThanOrEqualTo: capitalize)
            .where("namaTransaksi", isLessThan: '${capitalize}z')
            .get();

        // print("Total data: ${keyNameResult.docs.length}");
        if (keyNameResult.docs.isNotEmpty) {
          querySearch.value = [];
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            querySearch
                .add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          // print(querySearch);
        }
      }
    }

    querySearch.refresh();
    update();
  }
}
