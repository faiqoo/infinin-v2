import 'dart:convert';

ExperienceBilledOrder billedOrderDetailsFromJson(String str) =>
    ExperienceBilledOrder.fromJson(json.decode(str));

String billedOrderDetailsToJson(ExperienceBilledOrder data) => json.encode(data.toJson());


class ExperienceBilledOrder {
  int? code;
  String? error;
  String? message;
  T? t;
  int? userId;

  ExperienceBilledOrder(
      {this.code, this.error, this.message, this.t, this.userId});

  ExperienceBilledOrder.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['error'] = error;
    data['message'] = message;
    if (t != null) {
      data['t'] = t!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class T {
  String? bookingStatus;
  String? brandName;
  int? chefId;
  String? comments;
  int? experienceId;
  String? experienceName;
  int? foodieId;
  String? foodieName;
  int? id;
  String? persons;
  String? preferenceDescription;
  String? preferenceIconPath;
  int? preferenceId;
  String? preferenceName;
  int? priceTypeId;
  int? scheduleDayOfMonth;
  int? scheduleId;
  String? scheduleScheduledDate;
  ScheduleStartTime? scheduleStartTime;
  int? totalPrice;
  int? verificationCode;

  T(
      {this.bookingStatus,
        this.brandName,
        this.chefId,
        this.comments,
        this.experienceId,
        this.experienceName,
        this.foodieId,
        this.foodieName,
        this.id,
        this.persons,
        this.preferenceDescription,
        this.preferenceIconPath,
        this.preferenceId,
        this.preferenceName,
        this.priceTypeId,
        this.scheduleDayOfMonth,
        this.scheduleId,
        this.scheduleScheduledDate,
        this.scheduleStartTime,
        this.totalPrice,
        this.verificationCode});

  T.fromJson(Map<String, dynamic> json) {
    bookingStatus = json['bookingStatus'];
    brandName = json['brandName'];
    chefId = json['chefId'];
    comments = json['comments'];
    experienceId = json['experienceId'];
    experienceName = json['experienceName'];
    foodieId = json['foodieId'];
    foodieName = json['foodieName'];
    id = json['id'];
    persons = json['persons'];
    preferenceDescription = json['preferenceDescription'];
    preferenceIconPath = json['preferenceIconPath'];
    preferenceId = json['preferenceId'];
    preferenceName = json['preferenceName'];
    priceTypeId = json['priceTypeId'];
    scheduleDayOfMonth = json['scheduleDayOfMonth'];
    scheduleId = json['scheduleId'];
    scheduleScheduledDate = json['scheduleScheduledDate'];
    scheduleStartTime = json['scheduleStartTime'] != null
        ? ScheduleStartTime.fromJson(json['scheduleStartTime'])
        : null;
    totalPrice = json['totalPrice'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingStatus'] = bookingStatus;
    data['brandName'] = brandName;
    data['chefId'] = chefId;
    data['comments'] = comments;
    data['experienceId'] = experienceId;
    data['experienceName'] = experienceName;
    data['foodieId'] = foodieId;
    data['foodieName'] = foodieName;
    data['id'] = id;
    data['persons'] = persons;
    data['preferenceDescription'] = preferenceDescription;
    data['preferenceIconPath'] = preferenceIconPath;
    data['preferenceId'] = preferenceId;
    data['preferenceName'] = preferenceName;
    data['priceTypeId'] = priceTypeId;
    data['scheduleDayOfMonth'] = scheduleDayOfMonth;
    data['scheduleId'] = scheduleId;
    data['scheduleScheduledDate'] = scheduleScheduledDate;
    if (scheduleStartTime != null) {
      data['scheduleStartTime'] = scheduleStartTime!.toJson();
    }
    data['totalPrice'] = totalPrice;
    data['verificationCode'] = verificationCode;
    return data;
  }
}

class ScheduleStartTime {
  int? hour;
  int? minute;
  int? nano;
  int? second;

  ScheduleStartTime({this.hour, this.minute, this.nano, this.second});

  ScheduleStartTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
    nano = json['nano'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hour'] = hour;
    data['minute'] = minute;
    data['nano'] = nano;
    data['second'] = second;
    return data;
  }
}