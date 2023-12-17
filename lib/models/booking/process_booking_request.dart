import 'dart:convert';

ProcessBookingRequest processBookingRequestFromJson(String str) =>
    ProcessBookingRequest.fromJson(json.decode(str));

String processBookingRequestToJson(ProcessBookingRequest data) =>
    json.encode(data.toJson());

class ProcessBookingRequest {
  T t;
  int? userId;

  ProcessBookingRequest({
    required this.t,
    this.userId,
  });

  factory ProcessBookingRequest.fromJson(Map<String, dynamic> json) =>
      ProcessBookingRequest(
        t: T.fromJson(json["t"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
        "userId": userId,
      };
}

class T {
  int bookingId;
  int chefId;
  int experienceId;
  int foodieId;
  int verificationCode;

  T({
    required this.bookingId,
    required this.chefId,
    required this.experienceId,
    required this.foodieId,
    required this.verificationCode,
  });

  factory T.fromJson(Map<String, dynamic> json) => T(
        bookingId: json["bookingId"],
        chefId: json["chefId"],
        experienceId: json["experienceId"],
        foodieId: json["foodieId"],
        verificationCode: json["verificationCode"],
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "chefId": chefId,
        "experienceId": experienceId,
        "foodieId": foodieId,
        "verificationCode": verificationCode,
      };
}
