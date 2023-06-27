// To parse this JSON data, do
//
//     final recommendedVideo = recommendedVideoFromJson(jsonString);

import 'dart:convert';

RecommendedVideo recommendedVideoFromJson(String str) =>
    RecommendedVideo.fromJson(json.decode(str));

String recommendedVideoToJson(RecommendedVideo data) =>
    json.encode(data.toJson());

class RecommendedVideo {
  List<Datum> data;

  RecommendedVideo({
    required this.data,
  });

  factory RecommendedVideo.fromJson(Map<String, dynamic> json) =>
      RecommendedVideo(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int adminId;
  String category;
  String title;
  String video;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.adminId,
    required this.category,
    required this.title,
    required this.video,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        adminId: json["adminId"],
        category: json["category"],
        title: json["title"],
        video: json["video"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "category": category,
        "title": title,
        "video": video,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
