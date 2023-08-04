import 'dart:convert';

PostPaymentWithMidtrans postPaymentWithMidtransFromJson(String str) =>
    PostPaymentWithMidtrans.fromJson(json.decode(str));

String postPaymentWithMidtransToJson(PostPaymentWithMidtrans data) =>
    json.encode(data.toJson());

class PostPaymentWithMidtrans {
  int code;
  String message;
  int founded;
  List<PostPayment> data;

  PostPaymentWithMidtrans({
    required this.code,
    required this.message,
    required this.founded,
    required this.data,
  });

  factory PostPaymentWithMidtrans.fromJson(Map<String, dynamic> json) =>
      PostPaymentWithMidtrans(
        code: json["code"],
        message: json["message"],
        founded: json["founded"],
        data: List<PostPayment>.from(
            json["data"].map((x) => PostPayment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "founded": founded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PostPayment {
  String bookingId;
  String consultantId;
  String consultantName;
  String mailConsultant;
  String mailUser;
  String kategori;
  String imageUrl;
  String userId;
  int grossAmount;
  String paymentMethod;
  String vaNumber;
  DateTime startDateTime;
  DateTime endDateTime;

  PostPayment({
    required this.bookingId,
    required this.consultantId,
    required this.consultantName,
    required this.mailConsultant,
    required this.mailUser,
    required this.kategori,
    required this.imageUrl,
    required this.userId,
    required this.grossAmount,
    required this.paymentMethod,
    required this.vaNumber,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory PostPayment.fromJson(Map<String, dynamic> json) => PostPayment(
        bookingId: json["booking_id"],
        consultantId: json["consultant_id"],
        consultantName: json["consultant_name"],
        mailConsultant: json["mail_consultant"],
        mailUser: json["mail_user"],
        kategori: json["kategori"],
        imageUrl: json["imageUrl"],
        userId: json["user_id"],
        grossAmount: int.parse(json["gross_amount"]),
        paymentMethod: json["payment_method"],
        vaNumber: json["va_number"],
        startDateTime: DateTime.parse(json["startDateTime"]),
        endDateTime: DateTime.parse(json["endDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "consultant_id": consultantId,
        "consultant_name": consultantName,
        "mail_consultant": mailConsultant,
        "mail_user": mailUser,
        "kategori": kategori,
        "imageUrl": imageUrl,
        "user_id": userId,
        "total_amount": grossAmount,
        "payment_method": paymentMethod,
        "va_number": vaNumber,
        "startDateTime": startDateTime.toIso8601String(),
        "endDateTime": endDateTime.toIso8601String(),
      };
}
