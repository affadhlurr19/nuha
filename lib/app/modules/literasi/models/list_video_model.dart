import 'dart:convert';

ListVideo listVideoFromJson(String str) => ListVideo.fromJson(json.decode(str));

String listVideoToJson(ListVideo data) => json.encode(data.toJson());

class ListVideo {
  int code;
  String message;
  int founded;
  List<Datum> data;

  ListVideo({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory ListVideo.fromJson(Map<String, dynamic> json) => ListVideo(
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
