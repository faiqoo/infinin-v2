import 'dart:convert';

ExperienceBilledRequest experienceBilledRequestFromJson(String str) =>
    ExperienceBilledRequest.fromJson(json.decode(str));

String experienceBilledRequestToJson(ExperienceBilledRequest data) =>
    json.encode(data.toJson());


class ExperienceBilledRequest {
  int? t;
  int? userId;

  ExperienceBilledRequest({this.t, this.userId});

  ExperienceBilledRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['t'] = t;
    data['userId'] = userId;
    return data;
  }
}