class PostZoomMeeting {
  String bookingId;
  DateTime startTime;
  String mailConsultant;
  String mailUser;
  int totalAmount;

  PostZoomMeeting({
    required this.bookingId,
    required this.startTime,
    required this.mailConsultant,
    required this.mailUser,
    required this.totalAmount,
  });

  factory PostZoomMeeting.fromJson(Map<String, dynamic> json) =>
      PostZoomMeeting(
        bookingId: json["booking_id"],
        startTime: DateTime.parse(json["start_time"]),
        mailConsultant: json["mail_consultant"],
        mailUser: json["mail_user"],
        totalAmount: int.parse(json["total_amount"]),
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "start_time": startTime.toIso8601String(),
        "mail_consultant": mailConsultant,
        "mail_user": mailUser,
        "total_amount": totalAmount,
      };
}
