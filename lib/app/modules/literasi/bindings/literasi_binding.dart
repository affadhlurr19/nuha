import 'package:get/get.dart';

import 'package:nuha/app/modules/literasi/controllers/bookmark_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/bookmarked_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/cari_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/detail_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/komentar_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/list_artikel_controller.dart';
import 'package:nuha/app/modules/literasi/controllers/video_controller.dart';
import 'package:nuha/app/modules/literasi/providers/list_artikel_provider.dart';

import '../controllers/literasi_controller.dart';

class LiterasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomentarArtikelController>(
      () => KomentarArtikelController(idArtikel: Get.arguments),
    );
    Get.lazyPut<BookmarkArtikelController>(
      () => BookmarkArtikelController(artikelId: Get.arguments),
    );
    Get.lazyPut<LiterasiController>(
      () => LiterasiController(),
    );
    Get.lazyPut<BookmarkedArtikelController>(
      () => BookmarkedArtikelController(),
    );
    Get.lazyPut<VideoController>(
      () => VideoController(),
    );
    Get.lazyPut<ListArtikelController>(
      () => ListArtikelController(listArtikelProvider: ListArtikelProvider()),
    );
    Get.lazyPut<CariArtikelController>(
      () => CariArtikelController(listArtikelProvider: ListArtikelProvider()),
    );
    Get.lazyPut<DetailArtikelController>(
      () => DetailArtikelController(
          listArtikelProvider: ListArtikelProvider(), idArtikel: Get.arguments),
    );
  }
}
