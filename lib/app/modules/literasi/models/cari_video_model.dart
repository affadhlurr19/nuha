// To parse this JSON data, do
//
//     final cariVideo = cariVideoFromJson(jsonString);

import 'dart:convert';

CariVideo cariVideoFromJson(String str) => CariVideo.fromJson(json.decode(str));

String cariVideoToJson(CariVideo data) => json.encode(data.toJson());

class CariVideo {
  int code;
  String message;
  int founded;
  List<Datum> data;

  CariVideo({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory CariVideo.fromJson(Map<String, dynamic> json) => CariVideo(
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
  String adminId;
  Category category;
  String title;
  String video;
  String description;
  DateTime publishedAt;
  dynamic createdAt;
  dynamic updatedAt;

  Datum({
    required this.id,
    required this.adminId,
    required this.category,
    required this.title,
    required this.video,
    required this.description,
    required this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        adminId: json["adminId"],
        category: categoryValues.map[json["category"]]!,
        title: json["title"],
        video: json["video"],
        description: json["description"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "category": categoryValues.reverse[category],
        "title": title,
        "video": video,
        "description": description,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

enum Category {
  ASURANSI_SYARIAH,
  EKONOMI_SYARIAH,
  INVESTASI_SYARIAH,
  KEUANGAN_SYARIAH,
  PENGELOLAAN_KEUANGAN,
  PERENCANAAN_KEUANGAN,
}

final categoryValues = EnumValues({
  "Asuransi Syariah": Category.ASURANSI_SYARIAH,
  "Ekonomi Syariah": Category.EKONOMI_SYARIAH,
  "Investasi Syariah": Category.INVESTASI_SYARIAH,
  "Keuangan Syariah": Category.KEUANGAN_SYARIAH,
  "Pengelolaan Keuangan": Category.PENGELOLAAN_KEUANGAN,
  "Perencanaan Keuangan": Category.PERENCANAAN_KEUANGAN,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
