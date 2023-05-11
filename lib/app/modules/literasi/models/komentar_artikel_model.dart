import 'package:cloud_firestore/cloud_firestore.dart';

class Komentar {
  final String idKomentar;
  final String idArtikel;
  final String idUser;
  final String descKomentar;
  final DateTime createdAt;

  Komentar({
    required this.idKomentar,
    required this.idArtikel,
    required this.idUser,
    required this.descKomentar,
    required this.createdAt,
  });
}
