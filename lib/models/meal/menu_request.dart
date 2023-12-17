// import 'dart:convert';
//
// MenuRequest menuRequestFromJson(String str) =>
//     MenuRequest.fromJson(json.decode(str));
//
// String menuRequestToJson(MenuRequest data) => json.encode(data.toJson());
//
// class MenuRequest {
//   MenuRequest({
//     required this.t,
//     this.userId,
//   });
//
//   T t;
//   int? userId;
//
//   factory MenuRequest.fromJson(Map<String, dynamic> json) => MenuRequest(
//         t: T.fromJson(json["t"]),
//         userId: json["userId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "t": t.toJson(),
//         "userId": userId,
//       };
// }
//
// class T {
//   T({
//     required this.description,
//     required this.dish,
//     required this.dishId,
//     required this.experienceId,
//     this.id,
//     required this.mealId,
//     this.pictureUrl,
//     required this.price,
//   });
//
//   String description;
//   String dish;
//   int dishId;
//   int experienceId;
//   int? id;
//   int mealId;
//   String? pictureUrl;
//   int price;
//
//   factory T.fromJson(Map<String, dynamic> json) => T(
//         description: json["description"],
//         dish: json["dish"],
//         dishId: json["dishId"],
//         experienceId: json["experienceId"],
//         id: json["id"],
//         mealId: json["mealId"],
//         pictureUrl: json["pictureUrl"],
//         price: json["price"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "description": description,
//         "dish": dish,
//         "dishId": dishId,
//         "experienceId": experienceId,
//         "id": id,
//         "mealId": mealId,
//         "pictureUrl": pictureUrl,
//         "price": price,
//       };
// }

// To parse this JSON data, do
//
//     final menuRequest = menuRequestFromJson(jsonString);

import 'dart:convert';

MenuRequest menuRequestFromJson(String str) =>
    MenuRequest.fromJson(json.decode(str));

String menuRequestToJson(MenuRequest data) => json.encode(data.toJson());

class MenuRequest {
  MenuRequest({
    required this.t,
    this.userId,
  });

  T t;
  int? userId;

  factory MenuRequest.fromJson(Map<String, dynamic> json) => MenuRequest(
        t: T.fromJson(json["t"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "t": t.toJson(),
        "userId": userId,
      };
}

class T {
  T({
    required this.baseDishId,
    required this.baseDishName,
    required this.description,
    required this.dish,
    required this.experienceId,
    this.id,
    required this.mealId,
    required this.mealName,
    required this.pictureUrl,
    required this.price,
  });

  int baseDishId;
  String baseDishName;
  String description;
  String dish;
  int experienceId;
  int? id;
  int mealId;
  String mealName;
  String pictureUrl;
  int price;

  factory T.fromJson(Map<String, dynamic> json) => T(
        baseDishId: json["baseDishId"],
        baseDishName: json["baseDishName"],
        description: json["description"],
        dish: json["dish"],
        experienceId: json["experienceId"],
        id: json["id"],
        mealId: json["mealId"],
        mealName: json["mealName"],
        pictureUrl: json["pictureUrl"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "baseDishId": baseDishId,
        "baseDishName": baseDishName,
        "description": description,
        "dish": dish,
        "experienceId": experienceId,
        "id": id,
        "mealId": mealId,
        "mealName": mealName,
        "pictureUrl": pictureUrl,
        "price": price,
      };
}
