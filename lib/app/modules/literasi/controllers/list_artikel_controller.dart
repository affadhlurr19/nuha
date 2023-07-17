import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nuha/app/modules/literasi/models/list_artikel_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';
import 'package:http/http.dart' as http;
import 'package:nuha/app/utility/result_state.dart';

class ListArtikelController extends GetxController {
  final ListArtikelProvider listArtikelProvider;
  ListArtikelController({required this.listArtikelProvider});

  var resultState = ResultState.loading().obs;
  RxBool isSelected = false.obs;
  RxInt tag = 1.obs;
  var isDataLoading = false.obs;

  String _message = '';
  String get message => _message;

  int limit = 5;
  int page = 1;
  RxInt key = 1.obs;
  RxInt key2 = 1.obs;
  RxInt key3 = 1.obs;
  RxInt key4 = 1.obs;
  RxInt key5 = 1.obs;
  RxInt key6 = 1.obs;

  final PagingController<int, Datum> pagingAllArticleController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingKeuanganSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingTabunganSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingEkonomiSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingInvestasiSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingLainnyaController =
      PagingController(firstPageKey: 1);

  Set<Datum> existingData = {};
  Set<Datum> existingData2 = {};
  Set<Datum> existingData3 = {};
  Set<Datum> existingData4 = {};
  Set<Datum> existingData5 = {};
  Set<Datum> existingData6 = {};
  int lastPageAllLoaded = 0;
  int lastPageKeuanganSyariahLoaded = 0;
  int lastPageTabunganSyariahLoaded = 0;
  int lastPageEkonomiSyariahLoaded = 0;
  int lastPageInvestasiSyariahLoaded = 0;
  int lastPageLainnyaLoaded = 0;

  @override
  Future<void> onInit() async {
    pagingAllArticleController.addPageRequestListener((pageKey) {
      key.value = pageKey;
      getListArtikel(pageKey);
    });
    pagingKeuanganSyariahController.addPageRequestListener((pageKey) {
      key2.value = pageKey;
      getListKeuanganSyariahArtikel(pageKey);
    });
    pagingTabunganSyariahController.addPageRequestListener((pageKey) {
      key3.value = pageKey;
      getListTabunganSyariahArtikel(pageKey);
    });
    pagingEkonomiSyariahController.addPageRequestListener((pageKey) {
      key4.value = pageKey;
      getListEkonomiSyariahArtikel(pageKey);
    });
    pagingInvestasiSyariahController.addPageRequestListener((pageKey) {
      key5.value = pageKey;
      getListInvestasiSyariahArtikel(pageKey);
    });
    pagingLainnyaController.addPageRequestListener((pageKey) {
      key6.value = pageKey;
      getListArtikelLainnya(pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingAllArticleController.dispose();
    pagingKeuanganSyariahController.dispose();
    pagingTabunganSyariahController.dispose();
    pagingEkonomiSyariahController.dispose();
    pagingInvestasiSyariahController.dispose();
    pagingLainnyaController.dispose();
    super.dispose();
  }

  Future<void> getListArtikel(int pageKey) async {
    try {
      if (pageKey <= lastPageAllLoaded) {
        return;
      }

      final artikel = await listArtikelProvider.getListArtikel(
          http.Client(), pageKey, limit);
      final isLastPage = artikel.data.length < limit;

      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        if (isLastPage) {
          pagingAllArticleController.appendLastPage(artikel.data);
        } else {
          final newData =
              artikel.data.where((item) => !existingData.contains(item));
          pagingAllArticleController.appendPage(newData.toList(), pageKey + 1);
          existingData.addAll(newData);
        }
      }
      lastPageAllLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingAllArticleController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<dynamic> getListKeuanganSyariahArtikel(int pageKey) async {
    try {
      if (pageKey <= lastPageKeuanganSyariahLoaded) {
        return;
      }

      final artikel = await listArtikelProvider.getListKeuanganSyariahArtikel(
          http.Client(), pageKey, limit);
      final isLastPage = artikel.data.length < limit;

      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        if (isLastPage) {
          pagingKeuanganSyariahController.appendLastPage(artikel.data);
        } else {
          final newData =
              artikel.data.where((item) => !existingData2.contains(item));
          pagingKeuanganSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData2.addAll(newData);
        }
      }
      lastPageKeuanganSyariahLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingKeuanganSyariahController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<dynamic> getListTabunganSyariahArtikel(int pageKey) async {
    try {
      if (pageKey <= lastPageTabunganSyariahLoaded) {
        return;
      }

      final artikel = await listArtikelProvider.getListTabunganSyariahArtikel(
          http.Client(), pageKey, limit);
      final isLastPage = artikel.data.length < limit;

      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        if (isLastPage) {
          pagingTabunganSyariahController.appendLastPage(artikel.data);
        } else {
          final newData =
              artikel.data.where((item) => !existingData3.contains(item));
          pagingTabunganSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData3.addAll(newData);
        }
      }
      lastPageTabunganSyariahLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingTabunganSyariahController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<dynamic> getListEkonomiSyariahArtikel(int pageKey) async {
    try {
      if (pageKey <= lastPageEkonomiSyariahLoaded) {
        return;
      }

      final artikel = await listArtikelProvider.getListEkonomiSyariahArtikel(
          http.Client(), pageKey, limit);
      final isLastPage = artikel.data.length < limit;

      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        if (isLastPage) {
          pagingEkonomiSyariahController.appendLastPage(artikel.data);
        } else {
          final newData =
              artikel.data.where((item) => !existingData4.contains(item));
          pagingEkonomiSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData4.addAll(newData);
        }
      }
      lastPageEkonomiSyariahLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingEkonomiSyariahController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<dynamic> getListInvestasiSyariahArtikel(int pageKey) async {
    try {
      if (pageKey <= lastPageInvestasiSyariahLoaded) {
        return;
      }

      final artikel = await listArtikelProvider.getListInvestasiSyariahArtikel(
          http.Client(), pageKey, limit);
      final isLastPage = artikel.data.length < limit;

      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);
        if (isLastPage) {
          pagingInvestasiSyariahController.appendLastPage(artikel.data);
        } else {
          final newData =
              artikel.data.where((item) => !existingData5.contains(item));
          pagingInvestasiSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData5.addAll(newData);
        }
      }
      lastPageInvestasiSyariahLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingInvestasiSyariahController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<dynamic> getListArtikelLainnya(int pageKey) async {
    try {
      if (pageKey <= lastPageLainnyaLoaded) {
        return;
      }

      final artikel = await listArtikelProvider.getListArtikelLainnya(
        http.Client(),
        pageKey,
        limit,
      );

      final isLastPage = artikel.data.length < limit;

      if (artikel.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(artikel);

        if (isLastPage) {
          pagingLainnyaController.appendLastPage(artikel.data);
        } else {
          final newData =
              artikel.data.where((item) => !existingData6.contains(item));
          pagingLainnyaController.appendPage(newData.toList(), pageKey + 1);
          existingData6.addAll(newData);
        }
      }

      lastPageLainnyaLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingLainnyaController.error = _message;
    }
  }
}
