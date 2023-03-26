import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nuha/app/modules/fincheck/views/fincheck_result_view.dart';

class FincheckController extends GetxController {
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

  int? totalPemasukan,
      totalPengeluaran,
      totalSemuaTabungan,
      totalnvestasi,
      kekayaanBersih;
  String? nilaiKekayaan;

  result() {
    totalPemasukan = int.parse(pendapatanAktif!.text.replaceAll('.', '')) +
        int.parse(pendapatanPasif!.text.replaceAll('.', '')) +
        int.parse(bisnisUsaha!.text.replaceAll('.', '')) +
        int.parse(hasilInvestasi!.text.replaceAll('.', '')) +
        int.parse(lainnya!.text.replaceAll('.', ''));

    totalPengeluaran = int.parse(belanja!.text.replaceAll('.', '')) +
        int.parse(transportasi!.text.replaceAll('.', '')) +
        int.parse(sedekah!.text.replaceAll('.', '')) +
        int.parse(pendidikan!.text.replaceAll('.', '')) +
        int.parse(pajak!.text.replaceAll('.', '')) +
        int.parse(premiAsuransi!.text.replaceAll('.', '')) +
        int.parse(lainnyaP!.text.replaceAll('.', ''));

    totalSemuaTabungan = int.parse(nabungInvestasi!.text.replaceAll('.', '')) +
        int.parse(totalTabungan!.text.replaceAll('.', ''));

    totalnvestasi = int.parse(reksadana!.text.replaceAll('.', '')) +
        int.parse(saham!.text.replaceAll('.', '')) +
        int.parse(obligasi!.text.replaceAll('.', '')) +
        int.parse(unitLink!.text.replaceAll('.', '')) +
        int.parse(deposito!.text.replaceAll('.', '')) +
        int.parse(crowdFunding!.text.replaceAll('.', '')) +
        int.parse(ebaRitel!.text.replaceAll('.', '')) +
        int.parse(logamMulia!.text.replaceAll('.', ''));

    kekayaanBersih = int.parse(aset!.text.replaceAll('.', '')) -
        int.parse(hutang!.text.replaceAll('.', ''));
    if (kekayaanBersih! > int.parse(hutang!.text.replaceAll('.', ''))) {
      nilaiKekayaan =
          "Kekayaan bersih Anda positif karena aset telah lebih besar daripada hutang";
    } else {
      nilaiKekayaan =
          "Kekayaan bersih Anda negatif karena aset lebih kecil daripada hutang. Silahkan perbaiki!";
    }

    Get.to(FincheckResultView());
  }
}
