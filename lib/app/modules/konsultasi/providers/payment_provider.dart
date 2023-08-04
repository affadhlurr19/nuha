// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nuha/app/modules/konsultasi/models/get_payment_history_model.dart';
import 'package:nuha/app/modules/konsultasi/models/post_payment_with_midtrans_model.dart';

class PaymentProvider {
  static const String _baseUrl =
      'https://starfish-app-pua4v.ondigitalocean.app/api';

  Future<void> postPayment(PostPayment data) async {
    try {
      final jsonData = jsonEncode(data.toJson());
      final response = await http.post(
        Uri.parse("$_baseUrl/booking"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if (response.statusCode == 200) {
        print('Data transaksi konsultasi berhasil ditambahkan');
      } else {
        throw Exception(
            'Gagal post data. Status code: ${response.statusCode}. Pesan: ${response.body}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat POST data: $e');
      rethrow;
    }
  }

  Future<PaymentHistory> getPendingPayment(String userId) async {
    try {
      final response =
          await http.get(Uri.parse("$_baseUrl/booking/user/$userId"));
      if (response.statusCode == 200) {
        final data = PaymentHistory.fromJson(json.decode(response.body));
        return data;
      } else {
        throw Exception('Gagal mengambil data payment');
      }
    } on SocketException {
      throw Exception('Koneksi internet tidak tersedia');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> consultationDoneStatusUpdate(String bookingId) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/booking/isConsultationDone/$bookingId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bookingId,
      );
      if (response.statusCode == 200) {
        print('Berhasil mengubah status konsultasi menjadi selesai');
      } else {
        throw Exception(
            'Gagal post data. Status code: ${response.statusCode}. Pesan: ${response.body}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat PUT data: $e');
      rethrow;
    }
  }
}
