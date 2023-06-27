import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/literasi/models/cari_video_model.dart';
import 'package:nuha/app/modules/literasi/models/detail_video_model.dart';
import 'package:nuha/app/modules/literasi/models/list_video_model.dart';
import 'package:nuha/app/modules/literasi/models/recommended_video_model.dart';

class ListVideoProvider {
  static const String _baseUrl = 'https://nuha.my.id/api/';

  Future<ListVideo> getListVideo(http.Client client) async {
    try {
      final response = await client.get(Uri.parse("${_baseUrl}video"));
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
