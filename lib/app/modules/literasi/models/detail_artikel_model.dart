import 'dart:convert';

DetailArtikel detailArtikelFromJson(String str) =>
    DetailArtikel.fromJson(json.decode(str));

String detailArtikelToJson(DetailArtikel data) => json.encode(data.toJson());

class DetailArtikel {
  int code;
  String message;
  int founded;
  Data data;

  DetailArtikel({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory DetailArtikel.fromJson(Map<String, dynamic> json) => DetailArtikel(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  int adminId;
  String title;
  String category;
  String content;
  String imageUrl;
  String writer;
  int readTime;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        adminId: json["adminId"],
        title: json["title"],
        category: json["category"],
        content: json["content"],
        imageUrl: json["image_url"],
        writer: json["writer"],
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
        "writer": writer,
        "read_time": readTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
