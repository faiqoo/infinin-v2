import 'dart:convert';

ScheduleRequest ScheduleRequestFromJson(String str) =>
    ScheduleRequest.fromJson(json.decode(str));

String ScheduleRequestToJson(ScheduleRequest data) =>
    json.encode(data.toJson());

class ScheduleRequest {
  ScehduleData? t;

  ScheduleRequest({this.t});

  ScheduleRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? new ScehduleData.fromJson(json['t']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    return data;
  }
}

class ScehduleData {
  int? chefId;
  int? dayOfMonth;
  int? experienceId;
  int? hourId;
  int? hourOfDay;
  String? reservedStatus;
  String? scheduledDate;

  ScehduleData(
      {this.chefId,
        this.dayOfMonth,
        this.experienceId,
        this.hourId,
        this.hourOfDay,
        this.reservedStatus,
        this.scheduledDate});

  ScehduleData.fromJson(Map<String, dynamic> json) {
    chefId = json['chefId'];
    dayOfMonth = json['dayOfMonth'];
    experienceId = json['experienceId'];
    hourId = json['hourId'];
    hourOfDay = json['hourOfDay'];
    reservedStatus = json['reservedStatus'];
    scheduledDate = json['scheduledDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chefId'] = this.chefId;
    data['dayOfMonth'] = this.dayOfMonth;
    data['experienceId'] = this.experienceId;
    data['hourId'] = this.hourId;
    data['hourOfDay'] = this.hourOfDay;
    data['reservedStatus'] = this.reservedStatus;
    data['scheduledDate'] = this.scheduledDate;
    return data;
  }
}