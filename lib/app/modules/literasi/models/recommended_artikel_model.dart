// To parse this JSON data, do
//
//     final recommendedArticle = recommendedArticleFromJson(jsonString);

import 'dart:convert';

RecommendedArticle recommendedArticleFromJson(String str) =>
    RecommendedArticle.fromJson(json.decode(str));

String recommendedArticleToJson(RecommendedArticle data) =>
    json.encode(data.toJson());

class RecommendedArticle {
  List<Datum> data;

  RecommendedArticle({
    required this.data,
  });

  factory RecommendedArticle.fromJson(Map<String, dynamic> json) =>
      RecommendedArticle(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
