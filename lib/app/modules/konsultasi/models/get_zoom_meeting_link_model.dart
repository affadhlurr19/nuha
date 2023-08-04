import 'dart:convert';

ZoomMeetingLink zoomMeetingLinkFromJson(String str) =>
    ZoomMeetingLink.fromJson(json.decode(str));

String zoomMeetingLinkToJson(ZoomMeetingLink data) =>
    json.encode(data.toJson());

class ZoomMeetingLink {
  int code;
  String message;
  int founded;
  List<MeetingData> data;

  ZoomMeetingLink({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory ZoomMeetingLink.fromJson(Map<String, dynamic> json) =>
      ZoomMeetingLink(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: List<MeetingData>.from(
            json["data"].map((x) => MeetingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MeetingData {
  int id;
  String bookingId;
  DateTime startTime;
  String startUrl;
  String joinUrl;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  MeetingData({
    required this.id,
    required this.bookingId,
    required this.startTime,
    required this.startUrl,
    required this.joinUrl,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MeetingData.fromJson(Map<String, dynamic> json) => MeetingData(
        id: json["id"],
        bookingId: json["booking_id"],
        startTime: DateTime.parse(json["start_time"]),
        startUrl: json["start_url"],
        joinUrl: json["join_url"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "start_time": startTime.toIso8601String(),
        "start_url": startUrl,
        "join_url": joinUrl,
        "password": password,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
