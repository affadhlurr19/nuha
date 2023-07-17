import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/literasi/models/cari_video_model.dart';
import 'package:nuha/app/modules/literasi/models/detail_video_model.dart';
import 'package:nuha/app/modules/literasi/models/list_video_model.dart';
import 'package:nuha/app/modules/literasi/models/recommended_video_model.dart';

class ListVideoProvider {
  static const String _baseUrl = 'https://nuha.my.id/api/';

  Future<ListVideo> getListVideo(
      http.Client client, int page, int limit) async {
    try {
      final response = await client
          .get(Uri.parse("${_baseUrl}video?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list video');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListVideo> getListAsuransiSyariahVideo(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}video/category/Asuransi%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list video');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListVideo> getListEkonomiSyariahVideo(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}video/category/Ekonomi%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list video');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListVideo> getListInvestasiSyariahVideo(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}video/category/Investasi%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list video');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListVideo> getListKeuanganSyariahVideo(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}video/category/Keuangan%20Syariah?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list video');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListVideo> getListPengelolaanKeuanganVideo(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}video/category/Pengelolaan%20Keuangan?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list video');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<ListVideo> getListPerencanaanKeuanganVideo(
      http.Client client, int page, int limit) async {
    try {
      final response = await client.get(Uri.parse(
          "${_baseUrl}video/category/Perencanaan%20Keuangan?page=$page&page_size=$limit"));
      if (response.statusCode == 200) {
        return ListVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data list video');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<CariVideo> cariVideo(String keyword) async {
    try {
      final response =
          await http.get(Uri.parse("${_baseUrl}video/search/$keyword"));
      if (response.statusCode == 200) {
        return CariVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data video yang dicari');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailVideo> getDetailVideo(String idVideo) async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}video/$idVideo"));
      if (response.statusCode == 200) {
        return DetailVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data detail video!!!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RecommendedVideo> getRecommendVideoById(String idVideo) async {
    try {
      final response = await http.get(Uri.parse(
          "https://web-production-6274.up.railway.app/recommend/video?id=$idVideo"));
      if (response.statusCode == 200) {
        return RecommendedVideo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Gagal mengambil data detail video!!!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
