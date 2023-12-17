import 'dart:convert';

CityResponse cityResponseFromJson(String str) =>
    CityResponse.fromJson(json.decode(str));

String cityResponseToJson(CityResponse data) => json.encode(data.toJson());

class CityResponse {
  List<T> t;
  dynamic userId;
  dynamic message;
  dynamic error;
  int code;

  CityResponse({
    required this.t,
    this.userId,
    this.message,
    this.error,
    required this.code,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        t: List<T>.from(json["t"].map((x) => T.fromJson(x))),
        userId: json["userId"],
        message: json["message"],
        error: json["error"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "t": List<dynamic>.from(t.map((x) => x.toJson())),
        "userId": userId,
        "message": message,
        "error": error,
        "code": code,
      };
}

class T {
  String status;
  int id;
  String name;
  dynamic latitude;
  dynamic longitude;

  T({
    required this.status,
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
  });

  factory T.fromJson(Map<String, dynamic> json) => T(
        status: json["status"],
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
      };
}
