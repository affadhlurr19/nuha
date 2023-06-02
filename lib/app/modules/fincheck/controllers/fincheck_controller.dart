import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_result_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:nuha/mobile.dart';
import 'package:screenshot/screenshot.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FincheckController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();

  //fincheck page 1, data pemasukan per bulan
  TextEditingController? pendapatanAktif = TextEditingController();
  TextEditingController? pendapatanPasif = TextEditingController();
  TextEditingController? bisnisUsaha = TextEditingController();
  TextEditingController? hasilInvestasi = TextEditingController();
  TextEditingController? lainnya = TextEditingController();

  //fincheck page 2, data menabung per bulan
  TextEditingController? nabungInvestasi = TextEditingController();
  TextEditingController? totalTabungan = TextEditingController();

  //fincheck page 3, data investasi per bulan
  TextEditingController? reksadana = TextEditingController();
  TextEditingController? saham = TextEditingController();
  TextEditingController? obligasi = TextEditingController();
  TextEditingController? unitLink = TextEditingController();
  TextEditingController? deposito = TextEditingController();
  TextEditingController? crowdFunding = TextEditingController();
  TextEditingController? ebaRitel = TextEditingController();
  TextEditingController? logamMulia = TextEditingController();

  //fincheck page 4, data pengeluaran per bulan
  TextEditingController? belanja = TextEditingController();
  TextEditingController? transportasi = TextEditingController();
  TextEditingController? sedekah = TextEditingController();
  TextEditingController? pendidikan = TextEditingController();
  TextEditingController? pajak = TextEditingController();
  TextEditingController? premiAsuransi = TextEditingController();
  TextEditingController? lainnyaP = TextEditingController();

  //fincheck page 5, data hutang dan aset per bulan
  TextEditingController? aset = TextEditingController();
  TextEditingController? hutang = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isVisible = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  String resultStatus = "";
  String toDo = "";
  String description = "";
  String title = "";
  int idealNum = 0;
  int selisih = 0;
  int nominal = 0;
  double idealPoint = 0;
  double point = 0;

  int totalPenghasilan = 0;
  int totalPengeluaran = 0;
  int totalInvestasi = 0;
  double gaugePoint = 0.0;

  void toggleDescriptionVisibility() {
    isVisible.toggle();
  }

  void result() async {
    pengeluaranBulanan();
    penghasilanBulanan();
    totInvestasi();
    await deleteData();
    await countStatusData();

    await Future.wait([
      cashflow(),
      tabungan(),
      pendapatPasif(),
      danaDarurat(),
      investasi(),
      kekayaanBersih(),
      asetLikuid(),
      sedekahOk(),
    ]);

    final int count = await countStatusData();
    gaugePoint = count.toDouble() / 8 * 100;

    Get.to(() => FincheckResultView());
  }

  void penghasilanBulanan() async {
    totalPenghasilan = int.parse(pendapatanAktif!.text.replaceAll('.', '')) +
        int.parse(pendapatanPasif!.text.replaceAll('.', '')) +
        int.parse(bisnisUsaha!.text.replaceAll('.', '')) +
        int.parse(hasilInvestasi!.text.replaceAll('.', '')) +
        int.parse(lainnya!.text.replaceAll('.', ''));
  }

  void pengeluaranBulanan() async {
    totalPengeluaran = int.parse(belanja!.text.replaceAll('.', '')) +
        int.parse(transportasi!.text.replaceAll('.', '')) +
        int.parse(sedekah!.text.replaceAll('.', '')) +
        int.parse(pendidikan!.text.replaceAll('.', '')) +
        int.parse(pajak!.text.replaceAll('.', '')) +
        int.parse(premiAsuransi!.text.replaceAll('.', '')) +
        int.parse(lainnyaP!.text.replaceAll('.', ''));
  }

  void totInvestasi() async {
    totalInvestasi = int.parse(reksadana!.text.replaceAll('.', '')) +
        int.parse(saham!.text.replaceAll('.', '')) +
        int.parse(obligasi!.text.replaceAll('.', '')) +
        int.parse(unitLink!.text.replaceAll('.', '')) +
        int.parse(deposito!.text.replaceAll('.', '')) +
        int.parse(crowdFunding!.text.replaceAll('.', '')) +
        int.parse(ebaRitel!.text.replaceAll('.', '')) +
        int.parse(logamMulia!.text.replaceAll('.', ''));
  }

  Future<void> cashflow() async {
    nominal = totalPengeluaran;

    if (totalPenghasilan >= totalPengeluaran) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Total pemasukanmu lebih besar atau sama dengan total pengeluaranmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Kurangi total pengengeluaranmu atau tingkatkan pemasukanmu.";
      description =
          "Total pengeluaranmu lebih besar daripada total pendapatanmu.";
    }

    title = "Alur Kas";

    idealNum = totalPenghasilan;

    idealPoint = 50;

    point = (idealNum.toDouble() / nominal.toDouble() * 100);

    if (point > 100) {
      point = 100;
    }

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> tabungan() async {
    nominal = int.parse(nabungInvestasi!.text.replaceAll(".", ""));
    idealNum = (totalPenghasilan * 0.2).round();

    title = "Tabungan";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah dana yang kamu tabung perbulannya sudah mematuhi minimal 20% dari pemasukan.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambahkan tabunganmu sebesar";
      selisih = idealNum - nominal;
      description =
          "Minimal dana yang kamu tabung perbulannya minimal 20% dari pemasukan.";
    }

    idealPoint = 20;
    point = (nominal / totalPenghasilan * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> pendapatPasif() async {
    nominal = int.parse(pendapatanPasif!.text.replaceAll(".", ""));
    idealNum = (totalPenghasilan * 0.5).round();

    title = "Pendapatan Pasif";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah pendapatan pasifmu sudah 50% dari total pemasukanmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Tingkatkan pendapatan pasifmu sebesar ";
      selisih = idealNum - nominal;
      description =
          "Minimal pendapatan pasifmu harus 50% dari total seluruh pemasukanmu.";
    }

    idealPoint = 50;
    point = (nominal / totalPenghasilan * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> danaDarurat() async {
    nominal =
        totalInvestasi + int.parse(totalTabungan!.text.replaceAll(".", ""));

    idealNum = totalPengeluaran * 6;

    title = "Dana Darurat";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah dana darurat sudah memenuhi minimal 6 kali jumlah pengeluaranmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Tingkatkan tabungan atau investasimu sebesar ";
      selisih = idealNum - nominal;
      description =
          "Minimal dana darurat yang perlu kamu siapkan, yaitu 6 kali jumlah pengeluaranmu.";
    }

    point = (nominal.toDouble() / idealNum.toDouble() * 100);
    idealPoint = 100;

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> investasi() async {
    nominal = totalInvestasi;

    idealNum = (int.parse(aset!.text.replaceAll(".", "")) * 0.5).round();

    title = "Investasi";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Jumlah investasi sudah melebihi 50% aset yang kamu miliki.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambah investasimu sebesar ";
      selisih = idealNum - nominal;
      description =
          "Minimal investasi yang perlu kamu miliki, yaitu 50% dari asetmu.";
    }

    idealPoint = 50;
    point = (nominal / idealNum * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> kekayaanBersih() async {
    int utang = int.parse(hutang!.text.replaceAll(".", ""));
    int set = int.parse(aset!.text.replaceAll(".", ""));
    nominal = int.parse(aset!.text.replaceAll(".", "")) -
        int.parse(hutang!.text.replaceAll(".", ""));

    idealNum = (int.parse(aset!.text.replaceAll(".", "")) * 0.5).round();

    title = "Kekayaan Bersih";

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description =
          "Aset yang kamu miliki sudah lebih besar atau sama dengan jumlah hutang.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambah asetmu sebesar ";
      selisih = set - nominal;
      description = "Hutangmu lebih banyak dibandingkan aset yang kamu miliki.";
    }

    idealPoint = 50;
    point = (idealNum / utang * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> asetLikuid() async {
    idealNum =
        ((int.parse(totalTabungan!.text.replaceAll(".", "")) + totalInvestasi) *
                0.15)
            .round();

    nominal = int.parse(totalTabungan!.text.replaceAll(".", ""));

    if (idealNum >= nominal) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description = "Jumlah aset likuid kamu sudah baik, tidak melebihi 15%.";
    } else {
      resultStatus = "Bad";
      toDo = "Investasikan sebagian uang tabunganmu sebesar ";
      selisih = nominal - idealNum;
      description = "Jumlah aset likuid kamu melebihi 15%.";
    }

    title = "Aset Likuid";

    idealPoint = 15;
    point = (idealNum / nominal * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> sedekahOk() async {
    idealNum = (totalPenghasilan * 0.025).round();

    nominal = int.parse(sedekah!.text.replaceAll(".", ""));

    if (nominal >= idealNum) {
      resultStatus = "Good";
      toDo = "Lanjutkan kebiasaan baikmu!";
      description = "Jumlah sedekahmu sudah melebihi 2.5% dari penghasilanmu.";
    } else {
      resultStatus = "Bad";
      toDo = "Tambahkan jumlah sedekahmu sebanyak ";
      selisih = idealNum - nominal;
      description = "Jumlah sedekahmu kurang dari 2.5% dari penghasilanmu";
    }

    title = "Sedekah";

    idealPoint = 2.5;
    point = (nominal / totalPenghasilan * 100);

    await addData({
      "title": title,
      "description": description,
      "nominal": nominal,
      "resultStatus": resultStatus,
      "toDo": toDo,
      "selisih": selisih,
      "idealPoint": idealPoint,
      "point": point,
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteData() async {
    String uid = auth.currentUser!.uid;
    var collectionRef =
        firestore.collection("users").doc(uid).collection("fincheck");
    var querySnapshot = await collectionRef.get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> addData(Map<String, dynamic> data) async {
    isLoading.value = true;

    String uid = auth.currentUser!.uid;
    try {
      String id = firestore.collection("users").doc().id;
      await firestore
          .collection("users")
          .doc(uid)
          .collection("fincheck")
          .doc(id)
          .set(data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection("users")
        .doc(uid)
        .collection("fincheck")
        .snapshots();
  }

  Future<int> countStatusData() async {
    String uid = auth.currentUser!.uid;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("fincheck")
        .where('resultStatus',
            isEqualTo: 'Good') // Ganti dengan nama field kategori
        .get();

    return snapshot.size; // Jumlah dokumen dengan kategori "a"
  }

  Future<void> getPdf(Uint8List capturedImage, String name) async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    final Size pageSize = page.getClientSize();

    final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    //Draw the image
    page.graphics
        .drawImage(PdfBitmap(capturedImage), const Rect.fromLTWH(20, 0, 0, 0));

    page.graphics.drawImage(PdfBitmap(await readImageData('NUHA.png')),
        const Rect.fromLTWH(20, 690, 200, 50));

    drawFooter(page, pageSize);

    //Save the document
    List<int> bytes = await document.save();

    saveAndLaunchFile(bytes, '${name}_$time.pdf');
    document.dispose();
  }

  void drawFooter(PdfPage page, Size pageSize) async {
    final time = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

    final PdfPen linePen =
        PdfPen(PdfColor(27, 30, 35), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    String footerContent =
        // ignore: leading_newlines_in_multiline_strings
        '''Dihitung, dibuat, dan disusun
        oleh Nuha\r\n\r\n $time''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  Future<Uint8List> readImageData(String name) async {
    final data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
