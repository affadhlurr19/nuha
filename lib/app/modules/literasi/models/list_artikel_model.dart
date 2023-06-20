import 'dart:convert';

ListArtikel listArtikelFromJson(String str) =>
    ListArtikel.fromJson(json.decode(str));

String listArtikelToJson(ListArtikel data) => json.encode(data.toJson());

class ListArtikel {
  int code;
  String message;
  int founded;
  List<Article> data;

  ListArtikel({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory ListArtikel.fromJson(Map<String, dynamic> json) => ListArtikel(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: List<Article>.from(json["data"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Article {
  int id;
  int adminId;
  String title;
  String category;
  String content;
  String imageUrl;
  Writer writer;
  int readTime;
  DateTime createdAt;
  DateTime updatedAt;

  Article({
    required this.id,
    required this.adminId,
    required this.title,
    required this.category,
    required this.content,
    required this.imageUrl,
    required this.writer,
    required this.readTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        adminId: json["adminId"],
        title: json["title"],
        category: json["category"],
        content: json["content"],
        imageUrl: json["image_url"],
        writer: writerValues.map[json["writer"]]!,
        readTime: json["read_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "title": title,
        "category": category,
        "content": content,
        "image_url": imageUrl,
        "writer": writerValues.reverse[writer],
        "read_time": readTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Writer { AHMAD, FITRIA }

final writerValues =
    EnumValues({"Ahmad": Writer.AHMAD, "Fitria": Writer.FITRIA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
