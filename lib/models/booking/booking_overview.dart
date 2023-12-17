import 'dart:convert';

BookingOverview bookingOverviewFromJson(String str) =>
    BookingOverview.fromJson(json.decode(str));

String bookingOverviewToJson(BookingOverview data) =>
    json.encode(data.toJson());

class BookingOverview {
  BookingOverview({
    required this.t,
    this.userId,
    this.message,
    this.error,
    required this.code,
  });

  T t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int code;

  factory BookingOverview.fromJson(Map<String, dynamic> json) =>
      BookingOverview(
        t: T.fromJson(json["t"]),
        userId: json["userId"],
        message: json["message"],
        error: json["error"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
        "userId": userId,
        "message": message,
        "error": error,
        "code": code,
      };
}

class T {
  T({
    required this.newBookings,
    required this.acceptedBookings,
    required this.confirmedBookings,
    required this.inProgressBookings,
    required this.declinedBookings,
  });

  int newBookings;
  int acceptedBookings;
  int confirmedBookings;
  int inProgressBookings;
  int declinedBookings;

  factory T.fromJson(Map<String, dynamic> json) => T(
        newBookings: json["newBookings"],
        acceptedBookings: json["acceptedBookings"],
        confirmedBookings: json["confirmedBookings"],
        inProgressBookings: json["inProgressBookings"],
        declinedBookings: json["declinedBookings"],
      );

  Map<String, dynamic> toJson() => {
        "newBookings": newBookings,
        "acceptedBookings": acceptedBookings,
        "confirmedBookings": confirmedBookings,
        "inProgressBookings": inProgressBookings,
        "declinedBookings": declinedBookings,
      };
}
