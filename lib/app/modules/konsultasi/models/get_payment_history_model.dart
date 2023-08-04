import 'dart:convert';

PaymentHistory paymentHistoryFromJson(String str) =>
    PaymentHistory.fromJson(json.decode(str));

String paymentHistoryToJson(PaymentHistory data) => json.encode(data.toJson());

class PaymentHistory {
  int code;
  String message;
  int founded;
  List<PaymentData> data;

  PaymentHistory({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: List<PaymentData>.from(
            json["data"].map((x) => PaymentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PaymentData {
  int id;
  String bookingId;
  String transactionId;
  String consultantId;
  String userId;
  int grossAmount;
  String status;
  String paymentMethod;
  String vaNumber;
  String consultantName;
  String kategori;
  String imageUrl;
  DateTime startDateTime;
  DateTime endDateTime;
  bool isConsultationDone;
  String mailConsultant;
  String mailUser;
  DateTime createdAt;
  DateTime updatedAt;

  PaymentData({
    required this.id,
    required this.bookingId,
    required this.transactionId,
    required this.consultantId,
    required this.userId,
    required this.grossAmount,
    required this.status,
    required this.paymentMethod,
    required this.vaNumber,
    required this.consultantName,
    required this.kategori,
    required this.imageUrl,
    required this.startDateTime,
    required this.endDateTime,
    required this.isConsultationDone,
    required this.mailConsultant,
    required this.mailUser,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        id: json["id"],
        bookingId: json["booking_id"],
        transactionId: json["transaction_id"],
        consultantId: json["consultant_id"],
        userId: json["user_id"],
        grossAmount: json["gross_amount"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        vaNumber: json["va_number"],
        consultantName: json["consultant_name"],
        kategori: json["kategori"],
        imageUrl: json["imageUrl"],
        startDateTime: DateTime.parse(json["startDateTime"]),
        endDateTime: DateTime.parse(json["endDateTime"]),
        isConsultationDone: json["isConsultationDone"],
        mailConsultant: json["mail_consultant"],
        mailUser: json["mail_user"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "transaction_id": transactionId,
        "consultant_id": consultantId,
        "user_id": userId,
        "gross_amount": grossAmount,
        "status": status,
        "payment_method": paymentMethod,
        "va_number": vaNumber,
        "consultant_name": consultantName,
        "kategori": kategori,
        "imageUrl": imageUrl,
        "startDateTime": startDateTime.toIso8601String(),
        "endDateTime": endDateTime.toIso8601String(),
        "isConsultationDone": isConsultationDone,
        "mail_consultant": mailConsultant,
        "mail_user": mailUser,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
