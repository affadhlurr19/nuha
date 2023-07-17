import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nuha/app/modules/literasi/models/list_video_model.dart';
import 'package:nuha/app/modules/literasi/providers/list_video_provider.dart';
import 'package:http/http.dart' as http;
import 'package:nuha/app/utility/result_state.dart';

class ListVideoController extends GetxController {
  final ListVideoProvider listVideoProvider;
  ListVideoController({required this.listVideoProvider});
  final scrollC = ScrollController();

  var resultState = ResultState.loading().obs;
  RxBool isSelected = false.obs;
  RxInt tag = 1.obs;

  late ListVideo _listVideo;
  ListVideo get result => _listVideo;

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
  RxInt key7 = 1.obs;

  final PagingController<int, Datum> pagingAllVideoController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingAsuransiSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingEkonomiSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingInvestasiSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingKeuanganSyariahController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingPengelolaanKeuanganController =
      PagingController(firstPageKey: 1);
  final PagingController<int, Datum> pagingPerencanaanKeuanganController =
      PagingController(firstPageKey: 1);

  Set<Datum> existingData = {};
  Set<Datum> existingData2 = {};
  Set<Datum> existingData3 = {};
  Set<Datum> existingData4 = {};
  Set<Datum> existingData5 = {};
  Set<Datum> existingData6 = {};
  Set<Datum> existingData7 = {};

  int lastPageAllLoaded = 0;
  int lastPageAsuransiSyariahLoaded = 0;
  int lastPageEkonomiSyariahLoaded = 0;
  int lastPageInvestasiSyariahLoaded = 0;
  int lastPageKeuanganSyariahLoaded = 0;
  int lastPagePengelolaanKeuanganLoaded = 0;
  int lastPagePerencanaanKeuanganLoaded = 0;

  @override
  Future<void> onInit() async {
    pagingAllVideoController.addPageRequestListener((pageKey) {
      key.value = pageKey;
      getListVideo(pageKey);
    });
    pagingAllVideoController.addPageRequestListener((pageKey) {
      key2.value = pageKey;
      getListAsuransiSyariahVideo(pageKey);
    });
    pagingEkonomiSyariahController.addPageRequestListener((pageKey) {
      key3.value = pageKey;
      getListEkonomiSyariahVideo(pageKey);
    });
    pagingInvestasiSyariahController.addPageRequestListener((pageKey) {
      key4.value = pageKey;
      getListInvestasiSyariahVideo(pageKey);
    });
    pagingKeuanganSyariahController.addPageRequestListener((pageKey) {
      key5.value = pageKey;
      getListKeuanganSyariahVideo(pageKey);
    });
    pagingPengelolaanKeuanganController.addPageRequestListener((pageKey) {
      key6.value = pageKey;
      getListPengelolaanKeuanganVideo(pageKey);
    });
    pagingPerencanaanKeuanganController.addPageRequestListener((pageKey) {
      key7.value = pageKey;
      getListPerencanaanKeuanganVideo(pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingAllVideoController.dispose();
    pagingAsuransiSyariahController.dispose();
    pagingEkonomiSyariahController.dispose();
    pagingInvestasiSyariahController.dispose();
    pagingKeuanganSyariahController.dispose();
    pagingPengelolaanKeuanganController.dispose();
    pagingPerencanaanKeuanganController.dispose();
    super.dispose();
  }

  Future<void> getListVideo(int pageKey) async {
    try {
      if (pageKey <= lastPageAllLoaded) {
        return;
      }

      final video =
          await listVideoProvider.getListVideo(http.Client(), pageKey, limit);
      final isLastPage = video.data.length < limit;

      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        if (isLastPage) {
          pagingAllVideoController.appendLastPage(video.data);
        } else {
          final newData =
              video.data.where((item) => !existingData.contains(item));
          pagingAllVideoController.appendPage(newData.toList(), pageKey + 1);
          existingData.addAll(newData);
        }
      }
      lastPageAllLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingAllVideoController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<void> getListAsuransiSyariahVideo(int pageKey) async {
    try {
      if (pageKey <= lastPageAsuransiSyariahLoaded) {
        return;
      }

      final video = await listVideoProvider.getListAsuransiSyariahVideo(
          http.Client(), pageKey, limit);
      final isLastPage = video.data.length < limit;

      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        if (isLastPage) {
          pagingAsuransiSyariahController.appendLastPage(video.data);
        } else {
          final newData =
              video.data.where((item) => !existingData2.contains(item));
          pagingAsuransiSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData2.addAll(newData);
        }
      }
      lastPageAsuransiSyariahLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingAsuransiSyariahController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<void> getListEkonomiSyariahVideo(int pageKey) async {
    try {
      if (pageKey <= lastPageEkonomiSyariahLoaded) {
        return;
      }

      final video = await listVideoProvider.getListEkonomiSyariahVideo(
          http.Client(), pageKey, limit);
      final isLastPage = video.data.length < limit;

      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        if (isLastPage) {
          pagingEkonomiSyariahController.appendLastPage(video.data);
        } else {
          final newData =
              video.data.where((item) => !existingData3.contains(item));
          pagingEkonomiSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData3.addAll(newData);
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

  Future<void> getListInvestasiSyariahVideo(int pageKey) async {
    try {
      if (pageKey <= lastPageInvestasiSyariahLoaded) {
        return;
      }

      final video = await listVideoProvider.getListInvestasiSyariahVideo(
          http.Client(), pageKey, limit);
      final isLastPage = video.data.length < limit;

      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        if (isLastPage) {
          pagingInvestasiSyariahController.appendLastPage(video.data);
        } else {
          final newData =
              video.data.where((item) => !existingData4.contains(item));
          pagingInvestasiSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData4.addAll(newData);
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

  Future<void> getListKeuanganSyariahVideo(int pageKey) async {
    try {
      if (pageKey <= lastPageKeuanganSyariahLoaded) {
        return;
      }

      final video = await listVideoProvider.getListKeuanganSyariahVideo(
          http.Client(), pageKey, limit);
      final isLastPage = video.data.length < limit;

      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        if (isLastPage) {
          pagingKeuanganSyariahController.appendLastPage(video.data);
        } else {
          final newData =
              video.data.where((item) => !existingData5.contains(item));
          pagingKeuanganSyariahController.appendPage(
              newData.toList(), pageKey + 1);
          existingData5.addAll(newData);
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

  Future<void> getListPengelolaanKeuanganVideo(int pageKey) async {
    try {
      if (pageKey <= lastPagePengelolaanKeuanganLoaded) {
        return;
      }

      final video = await listVideoProvider.getListPengelolaanKeuanganVideo(
          http.Client(), pageKey, limit);
      final isLastPage = video.data.length < limit;

      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        if (isLastPage) {
          pagingPengelolaanKeuanganController.appendLastPage(video.data);
        } else {
          final newData =
              video.data.where((item) => !existingData6.contains(item));
          pagingPengelolaanKeuanganController.appendPage(
              newData.toList(), pageKey + 1);
          existingData6.addAll(newData);
        }
      }
      lastPagePengelolaanKeuanganLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingPengelolaanKeuanganController.error = _message;
    } finally {
      http.Client().close();
    }
  }

  Future<void> getListPerencanaanKeuanganVideo(int pageKey) async {
    try {
      if (pageKey <= lastPagePerencanaanKeuanganLoaded) {
        return;
      }

      final video = await listVideoProvider.getListPerencanaanKeuanganVideo(
          http.Client(), pageKey, limit);
      final isLastPage = video.data.length < limit;

      if (video.data.isEmpty) {
        resultState.value = ResultState.noData();
      } else {
        resultState.value = ResultState.hasData(video);
        if (isLastPage) {
          pagingPerencanaanKeuanganController.appendLastPage(video.data);
        } else {
          final newData =
              video.data.where((item) => !existingData7.contains(item));
          pagingPerencanaanKeuanganController.appendPage(
              newData.toList(), pageKey + 1);
          existingData7.addAll(newData);
        }
      }
      lastPagePerencanaanKeuanganLoaded = pageKey;
    } catch (e) {
      resultState.value = ResultState.error('An error occurred: $e');
      pagingPerencanaanKeuanganController.error = _message;
    } finally {
      http.Client().close();
    }
  }
}
