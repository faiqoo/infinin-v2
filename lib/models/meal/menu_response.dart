import 'dart:convert';

MenuResponse menuResponseFromJson(String str) =>
    MenuResponse.fromJson(json.decode(str));

String menuResponseToJson(MenuResponse data) => json.encode(data.toJson());

class MenuResponse {
  MenuResponse({
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

  factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
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
    this.dish,
    this.mealId,
    this.dishId,
    this.experienceId,
    this.description,
    this.price,
    this.pictureUrl,
  });

  int? id;
  String? dish;
  int? mealId;
  int? dishId;
  int? experienceId;
  String? description;
  int? price;
  String? pictureUrl;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        dish: json["dish"],
        mealId: json["mealId"],
        dishId: json["dishId"],
        experienceId: json["experienceId"],
        description: json["description"],
        price: json["price"],
        pictureUrl: json["pictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dish": dish,
        "mealId": mealId,
        "dishId": dishId,
        "experienceId": experienceId,
        "description": description,
        "price": price,
        "pictureUrl": pictureUrl,
      };
}
