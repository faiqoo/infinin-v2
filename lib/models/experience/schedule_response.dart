import 'dart:convert';

ScheduleResponse scheduleResponseFromJson(String str) =>
    ScheduleResponse.fromJson(json.decode(str));

String scheduleResponseToJson(ScheduleResponse data) =>
    json.encode(data.toJson());

class ScheduleResponse {
  ScheduleResponse({
    required this.t,
    this.userId,
    required this.message,
    this.error,
    required this.code,
  });

  T t;
  dynamic userId;
  String message;
  dynamic error;
  int code;

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      ScheduleResponse(
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
    required this.id,
    required this.experienceId,
    required this.hourId,
    this.hourOfDay,
    this.hourStartTime,
    this.hourEndTime,
    required this.chefId,
    required this.scheduledDate,
    required this.dayOfMonth,
    required this.reservedStatus,
  });

  int id;
  int experienceId;
  int hourId;
  dynamic hourOfDay;
  dynamic hourStartTime;
  dynamic hourEndTime;
  int chefId;
  DateTime scheduledDate;
  int dayOfMonth;
  String reservedStatus;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        experienceId: json["experienceId"],
        hourId: json["hourId"],
        hourOfDay: json["hourOfDay"],
        hourStartTime: json["hourStartTime"],
        hourEndTime: json["hourEndTime"],
        chefId: json["chefId"],
        scheduledDate: DateTime.parse(json["scheduledDate"]),
        dayOfMonth: json["dayOfMonth"],
        reservedStatus: json["reservedStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "experienceId": experienceId,
        "hourId": hourId,
        "hourOfDay": hourOfDay,
        "hourStartTime": hourStartTime,
        "hourEndTime": hourEndTime,
        "chefId": chefId,
        "scheduledDate":
            "${scheduledDate.year.toString().padLeft(4, '0')}-${scheduledDate.month.toString().padLeft(2, '0')}-${scheduledDate.day.toString().padLeft(2, '0')}",
        "dayOfMonth": dayOfMonth,
        "reservedStatus": reservedStatus,
      };
}
