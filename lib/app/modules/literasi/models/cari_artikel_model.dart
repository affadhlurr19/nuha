// To parse this JSON data, do
//
//     final cariArtikel = cariArtikelFromJson(jsonString);

import 'dart:convert';

CariArtikel cariArtikelFromJson(String str) =>
    CariArtikel.fromJson(json.decode(str));

String cariArtikelToJson(CariArtikel data) => json.encode(data.toJson());

class CariArtikel {
  int code;
  String message;
  int founded;
  List<Datum> data;

  CariArtikel({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory CariArtikel.fromJson(Map<String, dynamic> json) => CariArtikel(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int adminId;
  String title;
  String category;
  String content;
  String imageUrl;
  String writer;
  int readTime;
  DateTime publishedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Datum({
    required this.id,
    required this.adminId,
    required this.title,
    required this.category,
    required this.content,
    required this.imageUrl,
    required this.writer,
    required this.readTime,
    required this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        adminId: json["adminId"],
        title: json["title"],
        category: json["category"],
        content: json["content"],
        imageUrl: json["image_url"],
        writer: json["writer"],
        readTime: json["read_time"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "title": title,
        "category": category,
        "content": content,
        "image_url": imageUrl,
        "writer": writer,
        "read_time": readTime,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
