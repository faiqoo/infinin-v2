// // import 'dart:convert';
// //
// // SignupResponse signupResponseFromJson(String str) =>
// //     SignupResponse.fromJson(json.decode(str));
// //
// // String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());
// //
// // class SignupResponse {
// //   SignupResponse({
// //     required this.t,
// //     this.userName,
// //     this.userId,
// //     this.totalRecords,
// //     this.currentPage,
// //     required this.message,
// //     this.error,
// //     required this.code,
// //   });
// //
// //   T t;
// //   dynamic userName;
// //   dynamic userId;
// //   dynamic totalRecords;
// //   dynamic currentPage;
// //   String message;
// //   dynamic error;
// //   int code;
// //
// //   factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
// //         t: T.fromJson(json["t"]),
// //         userName: json["userName"],
// //         userId: json["userId"],
// //         totalRecords: json["totalRecords"],
// //         currentPage: json["currentPage"],
// //         message: json["message"],
// //         error: json["error"],
// //         code: json["code"],
// //       );
// //
// //   factory SignupResponse.empty() {
// //     return SignupResponse(
// //       t: T(
// //           gender: '',
// //           age: '',
// //           mobileNo: '',
// //           name: '',
// //           professionalId: 0,
// //           id: 0),
// //       message: '',
// //       code: 0,
// //     );
// //   }
// //   Map<String, dynamic> toJson() => {
// //         "t": t.toJson(),
// //         "userName": userName,
// //         "userId": userId,
// //         "totalRecords": totalRecords,
// //         "currentPage": currentPage,
// //         "message": message,
// //         "error": error,
// //         "code": code,
// //       };
// // }
// //
// // class T {
// //   T({
// //     required this.id,
// //     required this.name,
// //     required this.mobileNo,
// //     required this.gender,
// //     required this.age,
// //     required this.professionalId,
// //     this.profileImageUrl,
// //   });
// //
// //   int id;
// //   String name;
// //   String mobileNo;
// //   String gender;
// //   String age;
// //   int professionalId;
// //   dynamic profileImageUrl;
// //
// //   factory T.fromJson(Map<String, dynamic> json) => T(
// //         id: json["id"],
// //         name: json["name"],
// //         mobileNo: json["mobileNo"],
// //         gender: json["gender"],
// //         age: json["age"],
// //         professionalId: json["professionalId"],
// //         profileImageUrl: json["profileImageUrl"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "name": name,
// //         "mobileNo": mobileNo,
// //         "gender": gender,
// //         "age": age,
// //         "professionalId": professionalId,
// //         "profileImageUrl": profileImageUrl,
// //       };
// // }
//
// // To parse this JSON data, do
// //
// //     final signupResponse = signupResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// SignupResponse signupResponseFromJson(String str) =>
//     SignupResponse.fromJson(json.decode(str));
//
// String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());
//
// class SignupResponse {
//   SignupResponse({
//     required this.t,
//     this.userId,
//     this.message,
//     this.error,
//     required this.code,
//   });
//
//   T t;
//   dynamic userId;
//   dynamic message;
//   dynamic error;
//   int code;
//
//   factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
//         t: T.fromJson(json["t"]),
//         userId: json["userId"],
//         message: json["message"],
//         error: json["error"],
//         code: json["code"],
//       );
//
//   factory SignupResponse.empty() {
//     return SignupResponse(
//       t: T(address: '', brandName: '', mobileNo: '', name: '', id: 0),
//       message: '',
//       code: 0,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "t": t.toJson(),
//         "userId": userId,
//         "message": message,
//         "error": error,
//         "code": code,
//       };
// }
//
// class T {
//   T({
//     required this.id,
//     required this.name,
//     required this.mobileNo,
//     required this.address,
//     required this.brandName,
//   });
//
//   int id;
//   String name;
//   String mobileNo;
//   String address;
//   String brandName;
//
//   factory T.fromJson(Map<String, dynamic> json) => T(
//         id: json["id"],
//         name: json["name"],
//         mobileNo: json["mobileNo"],
//         address: json["address"],
//         brandName: json["brandName"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "mobileNo": mobileNo,
//         "address": address,
//         "brandName": brandName,
//       };
// }
// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  T t;
  dynamic userId;
  String message;
  dynamic error;
  int code;

  SignupResponse({
    required this.t,
    this.userId,
    required this.message,
    this.error,
    required this.code,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        t: T.fromJson(json["t"]),
        userId: json["userId"],
        message: json["message"] ?? '',
        error: json["error"] ?? '',
        code: json["code"] ?? '',
      );

  factory SignupResponse.empty() {
    return SignupResponse(
      t: T(
          address: '',
          brandName: '',
          mobileNo: '',
          name: '',
          id: 0,
          cityId: 0,
          cityName: '',
          townId: 0,
          townName: ''),
      message: '',
      code: 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
        "userId": userId,
        "message": message,
        "error": error,
        "code": code,
      };
}

class T {
  int id;
  String name;
  String mobileNo;
  String address;
  String brandName;
  int cityId;
  String cityName;
  int townId;
  String townName;
  dynamic latitude;
  dynamic longitude;
  dynamic placeId;
  dynamic facebook;
  dynamic instagram;
  dynamic twitter;
  dynamic tiktok;

  T({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.address,
    required this.brandName,
    required this.cityId,
    required this.cityName,
    required this.townId,
    required this.townName,
    this.latitude,
    this.longitude,
    this.placeId,
    this.facebook,
    this.instagram,
    this.twitter,
    this.tiktok,
  });

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        name: json["name"],
        mobileNo: json["mobileNo"],
        address: json["address"],
        brandName: json["brandName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        townId: json["townId"],
        townName: json["townName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        placeId: json["placeId"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        tiktok: json["tiktok"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobileNo": mobileNo,
        "address": address,
        "brandName": brandName,
        "cityId": cityId,
        "cityName": cityName,
        "townId": townId,
        "townName": townName,
        "latitude": latitude,
        "longitude": longitude,
        "placeId": placeId,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "tiktok": tiktok,
      };
}
