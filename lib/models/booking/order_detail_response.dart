import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) =>
    OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  OrderDetails({
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

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
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
    required this.experience,
    required this.experienceMenu,
    required this.foodieProfile,
    required this.comments,
    required this.totalPrice,
    required this.priceTypeId,
    required this.qrRequest,
    required this.bookingStatus,
    required this.foodieProfession,
    required this.foodieAge,
    required this.scheduleId,
    required this.scheduleScheduledDate,
    required this.scheduleStartTime,
    required this.scheduleDayOfMonth,
    required this.persons,
    required this.preferenceId,
    required this.preferenceName,
    required this.preferenceDescription,
    required this.preferenceIconPath,
    required this.experienceName,
    required this.chefId,
    required this.brandName,
  });

  int id;
  Experience experience;
  List<ExperienceMenu> experienceMenu;
  List<FoodieProfile> foodieProfile;
  String comments;
  int totalPrice;
  int priceTypeId;
  QrRequest? qrRequest;
  String bookingStatus;
  String foodieProfession;
  String foodieAge;
  int scheduleId;
  DateTime scheduleScheduledDate;
  String scheduleStartTime;
  int scheduleDayOfMonth;
  String persons;
  int preferenceId;
  String preferenceName;
  String preferenceDescription;
  String preferenceIconPath;
  String experienceName;
  int chefId;
  String brandName;

  factory T.fromJson(Map<String, dynamic> json) => T(
        id: json["id"],
        experience: Experience.fromJson(json["experience"]),
        experienceMenu: List<ExperienceMenu>.from(
            json["experienceMenu"].map((x) => ExperienceMenu.fromJson(x))),
        foodieProfile: List<FoodieProfile>.from(
            json["foodieProfile"].map((x) => FoodieProfile.fromJson(x))),
        comments: json["comments"],
        totalPrice: json["totalPrice"],
        priceTypeId: json["priceTypeId"],
        bookingStatus: json["bookingStatus"],
        foodieProfession: json["foodieProfession"],
        foodieAge: json["foodieAge"],
        scheduleId: json["scheduleId"],
        scheduleScheduledDate: DateTime.parse(json["scheduleScheduledDate"]),
        scheduleStartTime: json["scheduleStartTime"],
        scheduleDayOfMonth: json["scheduleDayOfMonth"],
        persons: json["persons"],
        preferenceId: json["preferenceId"],
        preferenceName: json["preferenceName"],
        preferenceDescription: json["preferenceDescription"],
        preferenceIconPath: json["preferenceIconPath"],
        experienceName: json["experienceName"],
        chefId: json["chefId"],
        brandName: json["brandName"],
        qrRequest: json['qrRequest'] != null
            ? QrRequest.fromJson(json['qrRequest'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "experience": experience.toJson(),
        "experienceMenu":
            List<dynamic>.from(experienceMenu.map((x) => x.toJson())),
        "foodieProfile":
            List<dynamic>.from(foodieProfile.map((x) => x.toJson())),
        "comments": comments,
        "totalPrice": totalPrice,
        "priceTypeId": priceTypeId,
        "bookingStatus": bookingStatus,
        "foodieProfession": foodieProfession,
        "foodieAge": foodieAge,
        "scheduleId": scheduleId,
        "scheduleScheduledDate":
            "${scheduleScheduledDate.year.toString().padLeft(4, '0')}-${scheduleScheduledDate.month.toString().padLeft(2, '0')}-${scheduleScheduledDate.day.toString().padLeft(2, '0')}",
        "scheduleStartTime": scheduleStartTime,
        "scheduleDayOfMonth": scheduleDayOfMonth,
        "persons": persons,
        "preferenceId": preferenceId,
        "preferenceName": preferenceName,
        "preferenceDescription": preferenceDescription,
        "preferenceIconPath": preferenceIconPath,
        "experienceName": experienceName,
        "chefId": chefId,
        "brandName": brandName,
        'qrRequest': qrRequest?.toJson(),
      };
}

class QrRequest {
  int? bookingId;
  int? chefId;
  int? experienceId;
  int? foodieId;
  int? verificationCode;

  QrRequest(
      {this.bookingId,
      this.chefId,
      this.experienceId,
      this.foodieId,
      this.verificationCode});

  QrRequest.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    chefId = json['chefId'];
    experienceId = json['experienceId'];
    foodieId = json['foodieId'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = bookingId;
    data['chefId'] = chefId;
    data['experienceId'] = experienceId;
    data['foodieId'] = foodieId;
    data['verificationCode'] = verificationCode;
    return data;
  }
}

class Experience {
  Experience({
    required this.id,
    required this.chefId,
    required this.chefName,
    required this.chefBrandName,
    required this.chefAddress,
    required this.title,
    required this.description,
    this.wowFactorId,
    this.preferenceId,
    required this.price,
    required this.priceTypeId,
    required this.persons,
    required this.locationId,
    required this.subHostName,
    required this.subHostMobileNo,
    required this.experienceWowFactors,
    required this.experiencePreferences,
  });

  int id;
  int chefId;
  String chefName;
  String chefBrandName;
  String chefAddress;
  String title;
  String description;
  dynamic wowFactorId;
  dynamic preferenceId;
  int price;
  int priceTypeId;
  String persons;
  int locationId;
  String subHostName;
  String subHostMobileNo;
  List<ExperienceWowFactor> experienceWowFactors;
  List<ExperiencePreference> experiencePreferences;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
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
        subHostMobileNo: json["subHostMobileNo"] ?? '',
        experienceWowFactors: List<ExperienceWowFactor>.from(
            json["experienceWowFactors"]
                .map((x) => ExperienceWowFactor.fromJson(x))),
        experiencePreferences: List<ExperiencePreference>.from(
            json["experiencePreferences"]
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
        "experienceWowFactors":
            List<dynamic>.from(experienceWowFactors.map((x) => x.toJson())),
        "experiencePreferences":
            List<dynamic>.from(experiencePreferences.map((x) => x.toJson())),
      };
}

class ExperiencePreference {
  ExperiencePreference({
    required this.id,
    required this.experienceId,
    required this.preferenceId,
    required this.preferenceName,
    required this.preferenceDescription,
    required this.preferenceIconPath,
  });

  int id;
  int experienceId;
  int preferenceId;
  String preferenceName;
  String preferenceDescription;
  String preferenceIconPath;

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
    required this.id,
    required this.experienceId,
    required this.wowFactorId,
    required this.wowFactorName,
    required this.wowFactorDescription,
    required this.wowFactorIconPath,
  });

  int id;
  int experienceId;
  int wowFactorId;
  String wowFactorName;
  String wowFactorDescription;
  String wowFactorIconPath;

  factory ExperienceWowFactor.fromJson(Map<String, dynamic> json) =>
      ExperienceWowFactor(
        id: json["id"],
        experienceId: json["experienceId"],
        wowFactorId: json["wowFactorId"],
        wowFactorName: json["wowFactorName"],
        wowFactorDescription: json["wowFactorDescription"],
        wowFactorIconPath: json["wowFactorIconPath"] ?? '',
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

class ExperienceMenu {
  ExperienceMenu({
    required this.id,
    required this.dish,
    required this.mealId,
    required this.mealName,
    required this.baseDishId,
    required this.baseDishName,
    required this.experienceId,
    required this.description,
    required this.price,
    required this.pictureUrl,
  });

  int id;
  String dish;
  int mealId;
  String mealName;
  int baseDishId;
  String baseDishName;
  int experienceId;
  String description;
  int price;
  String pictureUrl;

  factory ExperienceMenu.fromJson(Map<String, dynamic> json) => ExperienceMenu(
        id: json["id"],
        dish: json["dish"],
        mealId: json["mealId"],
        mealName: json["mealName"],
        baseDishId: json["baseDishId"],
        baseDishName: json["baseDishName"],
        experienceId: json["experienceId"],
        description: json["description"],
        price: json["price"],
        pictureUrl: json["pictureUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dish": dish,
        "mealId": mealId,
        "mealName": mealName,
        "baseDishId": baseDishId,
        "baseDishName": baseDishName,
        "experienceId": experienceId,
        "description": description,
        "price": price,
        "pictureUrl": pictureUrl,
      };
}

class FoodieProfile {
  FoodieProfile({
    required this.foodieId,
    required this.questionId,
    required this.questionName,
    required this.questionLabel,
    required this.answer,
    this.inputAnswer,
  });

  int foodieId;
  int questionId;
  String questionName;
  String questionLabel;
  List<Answer> answer;
  dynamic inputAnswer;

  factory FoodieProfile.fromJson(Map<String, dynamic> json) => FoodieProfile(
        foodieId: json["foodieId"],
        questionId: json["questionId"],
        questionName: json["questionName"],
        questionLabel: json["questionLabel"],
        answer:
            List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x))),
        inputAnswer: json["inputAnswer"],
      );

  Map<String, dynamic> toJson() => {
        "foodieId": foodieId,
        "questionId": questionId,
        "questionName": questionName,
        "questionLabel": questionLabel,
        "answer": List<dynamic>.from(answer.map((x) => x.toJson())),
        "inputAnswer": inputAnswer,
      };
}

class Answer {
  Answer({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.questionId,
  });

  int id;
  String name;
  String description;
  String iconPath;
  int questionId;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        iconPath: json["iconPath"],
        questionId: json["questionId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "iconPath": iconPath,
        "questionId": questionId,
      };
}
