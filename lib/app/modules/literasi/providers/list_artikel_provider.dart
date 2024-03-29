import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/literasi/models/cari_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/detail_artikel_model.dart';
import 'dart:convert';
import 'package:nuha/app/modules/literasi/models/list_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/notifikasi_artikel_model.dart';
import 'package:nuha/app/modules/literasi/models/recommended_artikel_model.dart';

class ListArtikelProvider {
  static const String _baseUrl =
      'https://starfish-app-pua4v.ondigitalocean.app/api/';

  Future<ListArtikel> getListArtikel(
      http.Client client, int page, int limit) async {
    try {
      final response = await client
          .get(Uri.parse("${_baseUrl}article?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        final data = ListArtikel.fromJson(json.decode(response.body));
        return data;
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListArtikel> getListKeuanganSyariahArtikel(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}article/category/Keuangan%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListArtikel> getListTabunganSyariahArtikel(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}article/category/Tabungan%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListArtikel> getListEkonomiSyariahArtikel(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}article/category/Ekonomi%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListArtikel> getListInvestasiSyariahArtikel(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}article/category/Investasi%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListArtikel> getListArtikelLainnya(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}article/category/Lainnya?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<CariArtikel> cariArtikel(String keyword) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}article/search/$keyword"));
      if (response.statusCode == 200) {
        return CariArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data artikel yang dicari');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailArtikel> getDetailArtikel(String idArtikel) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}article/$idArtikel"));
      if (response.statusCode == 200) {
        return DetailArtikel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data detail artikel!!!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RecommendedArticle> getRecommendArticleById(String idArtikel) async {
    try {
      final response = await http.get(Uri.parse(
          "http://167.172.90.92:8000/recommend/article?id=$idArtikel"));
      if (response.statusCode == 200) {
        return RecommendedArticle.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data detail artikel!!!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<NotifikasiArtikel> getNotificationArticle(http.Client client) async {
    try {
      final response =
          await client.get(Uri.parse("${_baseUrl}article/allData"));
      if (response.statusCode == 200) {
        final data = NotifikasiArtikel.fromJson(json.decode(response.body));
        return data;
      } else {
        throw Exception('Gagal mengambil data list artikel');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }
}
