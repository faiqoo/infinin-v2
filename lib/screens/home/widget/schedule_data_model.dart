class ScheduleDataModel {
  T? t;
  int? userId;

  ScheduleDataModel({this.t, this.userId});

  ScheduleDataModel.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? new T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    data['userId'] = this.userId;
    return data;
  }
}
class ScheduleRequestUpdate {
  ScheduleRequestUpdate({
    required this.t,
  });

  T t;

  factory ScheduleRequestUpdate.fromJson(Map<String, dynamic> json) =>
      ScheduleRequestUpdate(
        t: T.fromJson(json["t"]),
      );

  Map<String, dynamic> toJson() => {
    "t": t.toJson(),
  };
}
class T {
  int? chefId;
  int? dayOfMonth;
  int? experienceId;
  HourEndTime? hourEndTime;
  int? hourId;
  int? hourOfDay;
  HourEndTime? hourStartTime;
  int? id;
  String? reservedStatus;
  String? scheduledDate;

  T(
      {this.chefId,
      this.dayOfMonth,
      this.experienceId,
      this.hourEndTime,
      this.hourId,
      this.hourOfDay,
      this.hourStartTime,
      this.id,
      this.reservedStatus,
      this.scheduledDate});

  T.fromJson(Map<String, dynamic> json) {
    chefId = json['chefId'];
    dayOfMonth = json['dayOfMonth'];
    experienceId = json['experienceId'];
    hourEndTime = json['hourEndTime'] != null
        ? new HourEndTime.fromJson(json['hourEndTime'])
        : null;
    hourId = json['hourId'];
    hourOfDay = json['hourOfDay'];
    hourStartTime = json['hourStartTime'] != null
        ? new HourEndTime.fromJson(json['hourStartTime'])
        : null;
    id = json['id'];
    reservedStatus = json['reservedStatus'];
    scheduledDate = json['scheduledDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chefId'] = this.chefId;
    data['dayOfMonth'] = this.dayOfMonth;
    data['experienceId'] = this.experienceId;
    if (this.hourEndTime != null) {
      data['hourEndTime'] = this.hourEndTime!.toJson();
    }
    data['hourId'] = this.hourId;
    data['hourOfDay'] = this.hourOfDay;
    if (this.hourStartTime != null) {
      data['hourStartTime'] = this.hourStartTime!.toJson();
    }
    data['id'] = this.id;
    data['reservedStatus'] = this.reservedStatus;
    data['scheduledDate'] = this.scheduledDate;
    return data;
  }
}

class HourEndTime {
  int? hour;
  int? minute;
  int? nano;
  int? second;

  HourEndTime({this.hour, this.minute, this.nano, this.second});

  HourEndTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
    nano = json['nano'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['nano'] = this.nano;
    data['second'] = this.second;
    return data;
  }
}