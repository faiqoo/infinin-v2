// import 'dart:convert';
//
// ExperienceResponse experienceResponseFromJson(String str) =>
//     ExperienceResponse.fromJson(json.decode(str));
//
// String experienceResponseToJson(ExperienceResponse data) =>
//     json.encode(data.toJson());
//
// class ExperienceResponse {
//   ExperienceResponse({
//     required this.t,
//     this.userId,
//     required this.message,
//     this.error,
//     required this.code,
//   });
//
//   T t;
//   dynamic userId;
//   String message;
//   dynamic error;
//   int code;
//
//   factory ExperienceResponse.fromJson(Map<String, dynamic> json) =>
//       ExperienceResponse(
//         t: T.fromJson(json["t"]),
//         userId: json["userId"],
//         message: json["message"],
//         error: json["error"],
//         code: json["code"],
//       );
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
//     required this.chefId,
//     required this.chefName,
//     required this.chefBrandName,
//     required this.chefAddress,
//     required this.title,
//     required this.description,
//     required this.wowFactorId,
//     required this.preferenceId,
//     required this.price,
//     required this.priceTypeId,
//     required this.persons,
//     required this.locationId,
//     required this.subHostName,
//     required this.subHostMobileNo,
//     required this.experienceWowFactors,
//     required this.experiencePreferences,
//   });
//
//   int id;
//   int chefId;
//   String chefName;
//   String chefBrandName;
//   String chefAddress;
//   String title;
//   String description;
//   int wowFactorId;
//   int preferenceId;
//   int price;
//   int priceTypeId;
//   String persons;
//   int locationId;
//   String subHostName;
//   String subHostMobileNo;
//   List<ExperienceWowFactor> experienceWowFactors;
//   List<ExperiencePreference> experiencePreferences;
//
//   factory T.fromJson(Map<String, dynamic> json) => T(
//         id: json["id"],
//         chefId: json["chefId"],
//         chefName: json["chefName"],
//         chefBrandName: json["chefBrandName"],
//         chefAddress: json["chefAddress"],
//         title: json["title"],
//         description: json["description"],
//         wowFactorId: json["wowFactorId"],
//         preferenceId: json["preferenceId"],
//         price: json["price"],
//         priceTypeId: json["priceTypeId"],
//         persons: json["persons"],
//         locationId: json["locationId"],
//         subHostName: json["subHostName"],
//         subHostMobileNo: json["subHostMobileNo"],
//         experienceWowFactors: List<ExperienceWowFactor>.from(
//             json["experienceWowFactors"]
//                 .map((x) => ExperienceWowFactor.fromJson(x))),
//         experiencePreferences: List<ExperiencePreference>.from(
//             json["experiencePreferences"]
//                 .map((x) => ExperiencePreference.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "chefId": chefId,
//         "chefName": chefName,
//         "chefBrandName": chefBrandName,
//         "chefAddress": chefAddress,
//         "title": title,
//         "description": description,
//         "wowFactorId": wowFactorId,
//         "preferenceId": preferenceId,
//         "price": price,
//         "priceTypeId": priceTypeId,
//         "persons": persons,
//         "locationId": locationId,
//         "subHostName": subHostName,
//         "subHostMobileNo": subHostMobileNo,
//         "experienceWowFactors":
//             List<dynamic>.from(experienceWowFactors.map((x) => x.toJson())),
//         "experiencePreferences":
//             List<dynamic>.from(experiencePreferences.map((x) => x.toJson())),
//       };
// }
//
// class ExperiencePreference {
//   ExperiencePreference({
//     required this.id,
//     required this.experienceId,
//     required this.preferenceId,
//     this.preferenceName,
//     this.preferenceDescription,
//     this.preferenceIconPath,
//   });
//
//   int id;
//   int experienceId;
//   int preferenceId;
//   dynamic preferenceName;
//   dynamic preferenceDescription;
//   dynamic preferenceIconPath;
//
//   factory ExperiencePreference.fromJson(Map<String, dynamic> json) =>
//       ExperiencePreference(
//         id: json["id"],
//         experienceId: json["experienceId"],
//         preferenceId: json["preferenceId"],
//         preferenceName: json["preferenceName"],
//         preferenceDescription: json["preferenceDescription"],
//         preferenceIconPath: json["preferenceIconPath"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "experienceId": experienceId,
//         "preferenceId": preferenceId,
//         "preferenceName": preferenceName,
//         "preferenceDescription": preferenceDescription,
//         "preferenceIconPath": preferenceIconPath,
//       };
// }
//
// class ExperienceWowFactor {
//   ExperienceWowFactor({
//     required this.id,
//     required this.experienceId,
//     required this.wowFactorId,
//     this.wowFactorName,
//     this.wowFactorDescription,
//     this.wowFactorIconPath,
//   });
//
//   int id;
//   int experienceId;
//   int wowFactorId;
//   dynamic wowFactorName;
//   dynamic wowFactorDescription;
//   dynamic wowFactorIconPath;
//
//   factory ExperienceWowFactor.fromJson(Map<String, dynamic> json) =>
//       ExperienceWowFactor(
//         id: json["id"],
//         experienceId: json["experienceId"],
//         wowFactorId: json["wowFactorId"],
//         wowFactorName: json["wowFactorName"],
//         wowFactorDescription: json["wowFactorDescription"],
//         wowFactorIconPath: json["wowFactorIconPath"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "experienceId": experienceId,
//         "wowFactorId": wowFactorId,
//         "wowFactorName": wowFactorName,
//         "wowFactorDescription": wowFactorDescription,
//         "wowFactorIconPath": wowFactorIconPath,
//       };
// }
//
//
//
//

// To parse this JSON data, do
//
//     final experienceResponse = experienceResponseFromJson(jsonString);

import 'dart:convert';

ExperienceResponse experienceResponseFromJson(String str) =>
    ExperienceResponse.fromJson(json.decode(str));

String experienceResponseToJson(ExperienceResponse data) =>
    json.encode(data.toJson());

class ExperienceResponse {
  ExperienceResponse({
    this.t,
    this.userId,
    this.message,
    this.error,
    this.code,
  });

  T? t;
  dynamic userId;
  String? message;
  dynamic error;
  int? code;

  factory ExperienceResponse.fromJson(Map<String, dynamic> json) =>
      ExperienceResponse(
        t: json["t"] == null ? null : T.fromJson(json["t"]),
        userId: json["userId"],
        message: json["message"],
        error: json["error"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "t": t?.toJson(),
        "userId": userId,
        "message": message,
        "error": error,
        "code": code,
      };
}

class T {
  T({
    this.id,
    this.chefId,
    this.chefName,
    this.chefBrandName,
    this.chefAddress,
    this.title,
    this.description,
    this.wowFactorId,
    this.preferenceId,
    this.price,
    this.priceTypeId,
    this.persons,
    this.locationId,
    this.subHostName,
    this.subHostMobileNo,
    this.experienceWowFactors,
    this.experiencePreferences,
  });

  int? id;
  int? chefId;
  String? chefName;
  String? chefBrandName;
  String? chefAddress;
  String? title;
  String? description;
  dynamic wowFactorId;
  dynamic preferenceId;
  int? price;
  int? priceTypeId;
  String? persons;
  int? locationId;
  String? subHostName;
  String? subHostMobileNo;
  List<ExperienceWowFactor>? experienceWowFactors;
  List<ExperiencePreference>? experiencePreferences;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        chefId: json["chefId"],
        chefName: json["chefName"],
        chefBrandName: json["chefBrandName"],
        chefAddress: json["chefAddress"],
        title: json["title"],
        description: json["description"],
        wowFactorId: json["wowFactorId"],
        preferenceId: json["preferenceId"],
        price: json["price"],
        priceTypeId: json["priceTypeId"],
        persons: json["persons"],
        locationId: json["locationId"],
        subHostName: json["subHostName"],
        subHostMobileNo: json["subHostMobileNo"],
        experienceWowFactors: json["experienceWowFactors"] == null
            ? []
            : List<ExperienceWowFactor>.from(json["experienceWowFactors"]!
                .map((x) => ExperienceWowFactor.fromJson(x))),
        experiencePreferences: json["experiencePreferences"] == null
            ? []
            : List<ExperiencePreference>.from(json["experiencePreferences"]!
                .map((x) => ExperiencePreference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chefId": chefId,
        "chefName": chefName,
        "chefBrandName": chefBrandName,
        "chefAddress": chefAddress,
        "title": title,
        "description": description,
        "wowFactorId": wowFactorId,
        "preferenceId": preferenceId,
        "price": price,
        "priceTypeId": priceTypeId,
        "persons": persons,
        "locationId": locationId,
        "subHostName": subHostName,
        "subHostMobileNo": subHostMobileNo,
        "experienceWowFactors": experienceWowFactors == null
            ? []
            : List<dynamic>.from(experienceWowFactors!.map((x) => x.toJson())),
        "experiencePreferences": experiencePreferences == null
            ? []
            : List<dynamic>.from(experiencePreferences!.map((x) => x.toJson())),
      };
}

class ExperiencePreference {
  ExperiencePreference({
    this.id,
    this.experienceId,
    this.preferenceId,
    this.preferenceName,
    this.preferenceDescription,
    this.preferenceIconPath,
  });

  int? id;
  int? experienceId;
  int? preferenceId;
  dynamic preferenceName;
  dynamic preferenceDescription;
  dynamic preferenceIconPath;

  factory ExperiencePreference.fromJson(Map<String, dynamic> json) =>
      ExperiencePreference(
        id: json["id"],
        experienceId: json["experienceId"],
        preferenceId: json["preferenceId"],
        preferenceName: json["preferenceName"],
        preferenceDescription: json["preferenceDescription"],
        preferenceIconPath: json["preferenceIconPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "experienceId": experienceId,
        "preferenceId": preferenceId,
        "preferenceName": preferenceName,
        "preferenceDescription": preferenceDescription,
        "preferenceIconPath": preferenceIconPath,
      };
}

class ExperienceWowFactor {
  ExperienceWowFactor({
    this.id,
    this.experienceId,
    this.wowFactorId,
    this.wowFactorName,
    this.wowFactorDescription,
    this.wowFactorIconPath,
  });

  int? id;
  int? experienceId;
  int? wowFactorId;
  dynamic wowFactorName;
  dynamic wowFactorDescription;
  dynamic wowFactorIconPath;

  factory ExperienceWowFactor.fromJson(Map<String, dynamic> json) =>
      ExperienceWowFactor(
        id: json["id"],
        experienceId: json["experienceId"],
        wowFactorId: json["wowFactorId"],
        wowFactorName: json["wowFactorName"],
        wowFactorDescription: json["wowFactorDescription"],
        wowFactorIconPath: json["wowFactorIconPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "experienceId": experienceId,
        "wowFactorId": wowFactorId,
        "wowFactorName": wowFactorName,
        "wowFactorDescription": wowFactorDescription,
        "wowFactorIconPath": wowFactorIconPath,
      };
}
