import 'package:get/get.dart';
import 'package:nuha/app/modules/literasi/models/detail_artikel_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:nuha/app/utility/result_state.dart';

class DetailArtikelController extends GetxController {
  ListArtikelProvider listArtikelProvider;
  DetailArtikelController({
    required this.listArtikelProvider,
    required String idArtikel
  }) {
    fetchDetailArtikel(idArtikel);
  }

  var resultState = ResultState.loading().obs;

  String _message = '';
  late DetailArtikel _detailArtikel ;

  DetailArtikel get resultDetailArtikel => _detailArtikel;
  String get message => _message;

  Future<dynamic> fetchDetailArtikel(idArtikel) async {
    try {
      final artikel = await listArtikelProvider.getDetailArtikel(idArtikel);
      if (artikel.article.toJson().isEmpty) {
        resultState.value = ResultState.noData();
        return _message = 'Data Kosong';
      } else {
        resultState.value = ResultState.hasData(artikel);
        return _detailArtikel = artikel;
      }
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      return _message = '$e';
    }
  }
}
