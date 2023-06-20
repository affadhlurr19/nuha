import 'dart:convert';

DetailVideo detailVideoFromJson(String str) =>
    DetailVideo.fromJson(json.decode(str));

String detailVideoToJson(DetailVideo data) => json.encode(data.toJson());

class DetailVideo {
  int code;
  String message;
  int founded;
  Data data;

  DetailVideo({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory DetailVideo.fromJson(Map<String, dynamic> json) => DetailVideo(
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
  String category;
  String title;
  String video;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.adminId,
    required this.category,
    required this.title,
    required this.video,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
