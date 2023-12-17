// To parse this JSON data, do
//
//     final foodieDetails = foodieDetailsFromJson(jsonString);

import 'dart:convert';

FoodieDetails foodieDetailsFromJson(String str) =>
    FoodieDetails.fromJson(json.decode(str));

String foodieDetailsToJson(FoodieDetails data) => json.encode(data.toJson());

class FoodieDetails {
  FoodieDetails({
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

  factory FoodieDetails.fromJson(Map<String, dynamic> json) => FoodieDetails(
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
    required this.name,
    required this.mobileNo,
    required this.gender,
    required this.age,
    required this.professionalId,
    this.profileImageUrl,
  });

  int id;
  String name;
  String mobileNo;
  String gender;
  String age;
  int professionalId;
  dynamic profileImageUrl;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        name: json["name"],
        mobileNo: json["mobileNo"],
        gender: json["gender"],
        age: json["age"],
        professionalId: json["professionalId"],
        profileImageUrl: json["profileImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobileNo": mobileNo,
        "gender": gender,
        "age": age,
        "professionalId": professionalId,
        "profileImageUrl": profileImageUrl,
      };
}
