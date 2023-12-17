import 'dart:convert';

ProfileDetails profileDetailsFromJson(String str) =>
    ProfileDetails.fromJson(json.decode(str));

String profileDetailsToJson(ProfileDetails data) =>
    json.encode(data.toJson());

class ProfileDetails {
  int? code;
  String? error;
  String? message;
  T? t;
  int? userId;

  ProfileDetails({this.code, this.error, this.message, this.t, this.userId});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
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
  String? address;
  String? brandName;
  List<ChefQuestionAnswers>? chefQuestionAnswers;
  int? cityId;
  String? cityName;
  String? facebook;
  int? id;
  String? instagram;
  int? latitude;
  int? longitude;
  String? mobileNo;
  String? name;
  String? placeId;
  String? profileImageUrl;
  String? tiktok;
  int? townId;
  String? townName;
  String? twitter;

  T(
      {this.address,
        this.brandName,
        this.chefQuestionAnswers,
        this.cityId,
        this.cityName,
        this.facebook,
        this.id,
        this.instagram,
        this.latitude,
        this.longitude,
        this.mobileNo,
        this.name,
        this.placeId,
        this.profileImageUrl,
        this.tiktok,
        this.townId,
        this.townName,
        this.twitter});

  T.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    brandName = json['brandName'];
    if (json['chefQuestionAnswers'] != null) {
      chefQuestionAnswers = <ChefQuestionAnswers>[];
      json['chefQuestionAnswers'].forEach((v) {
        chefQuestionAnswers!.add(ChefQuestionAnswers.fromJson(v));
      });
    }
    cityId = json['cityId'];
    cityName = json['cityName'];
    facebook = json['facebook'];
    id = json['id'];
    instagram = json['instagram'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mobileNo = json['mobileNo'];
    name = json['name'];
    placeId = json['placeId'];
    profileImageUrl = json['profileImageUrl'];
    tiktok = json['tiktok'];
    townId = json['townId'];
    townName = json['townName'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['brandName'] = brandName;
    if (chefQuestionAnswers != null) {
      data['chefQuestionAnswers'] =
          chefQuestionAnswers!.map((v) => v.toJson()).toList();
    }
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['facebook'] = facebook;
    data['id'] = id;
    data['instagram'] = instagram;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['mobileNo'] = mobileNo;
    data['name'] = name;
    data['placeId'] = placeId;
    data['profileImageUrl'] = profileImageUrl;
    data['tiktok'] = tiktok;
    data['townId'] = townId;
    data['townName'] = townName;
    data['twitter'] = twitter;
    return data;
  }
}

class ChefQuestionAnswers {
  List<Answers>? answers;
  int? chefId;
  String? inputAnswer;
  Question? question;

  ChefQuestionAnswers(
      {this.answers, this.chefId, this.inputAnswer, this.question});

  ChefQuestionAnswers.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
    chefId = json['chefId'];
    inputAnswer = json['inputAnswer'];
    question = json['question'] != null
        ? Question.fromJson(json['question'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['chefId'] = chefId;
    data['inputAnswer'] = inputAnswer;
    if (question != null) {
      data['question'] = question!.toJson();
    }
    return data;
  }
}

class Answers {
  String? description;
  String? iconPath;
  int? id;
  String? name;
  int? questionId;

  Answers(
      {this.description, this.iconPath, this.id, this.name, this.questionId});

  Answers.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    iconPath = json['iconPath'];
    id = json['id'];
    name = json['name'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['iconPath'] = iconPath;
    data['id'] = id;
    data['name'] = name;
    data['questionId'] = questionId;
    return data;
  }
}

class Question {
  List<Answers>? answers;
  String? category;
  String? description;
  int? id;
  String? name;
  String? type;

  Question(
      {this.answers,
        this.category,
        this.description,
        this.id,
        this.name,
        this.type});

  Question.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
    category = json['category'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    data['category'] = category;
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}