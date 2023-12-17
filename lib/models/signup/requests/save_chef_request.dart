import 'dart:convert';

SaveChefRequest saveChefRequestFromJson(String str) => SaveChefRequest.fromJson(json.decode(str));

String saveChefRequestToJson(SaveChefRequest data) => json.encode(data.toJson());


class SaveChefRequest {
  T? t;
  int? userId;

  SaveChefRequest({this.t, this.userId});

  SaveChefRequest.fromJson(Map<String, dynamic> json) {
    t = json['t'] != null ? T.fromJson(json['t']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (t != null) {
      data['t'] = t!.toJson();
    }
    data['userId'] = userId;
    return data;
  }
}

class T {
  List<ChefQuestionAnswers>? chefQuestionAnswers;
  SocialHandles? socialHandles;

  T({this.chefQuestionAnswers, this.socialHandles});

  T.fromJson(Map<String, dynamic> json) {
    if (json['chefQuestionAnswers'] != null) {
      chefQuestionAnswers = <ChefQuestionAnswers>[];
      json['chefQuestionAnswers'].forEach((v) {
        chefQuestionAnswers!.add(ChefQuestionAnswers.fromJson(v));
      });
    }
    socialHandles = json['socialHandles'] != null
        ? SocialHandles.fromJson(json['socialHandles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chefQuestionAnswers != null) {
      data['chefQuestionAnswers'] =
          chefQuestionAnswers!.map((v) => v.toJson()).toList();
    }
    if (socialHandles != null) {
      data['socialHandles'] = socialHandles!.toJson();
    }
    return data;
  }
}

class ChefQuestionAnswers {
  List<int>? answerIds;
  int? chefId;
  int? id;
  String? inputAnswer;
  int? questionId;

  ChefQuestionAnswers(
      {this.answerIds,
        this.chefId,
        this.id,
        this.inputAnswer,
        this.questionId});

  ChefQuestionAnswers.fromJson(Map<String, dynamic> json) {
    answerIds = json['answerIds'].cast<int>();
    chefId = json['chefId'];
    id = json['id'];
    inputAnswer = json['inputAnswer'];
    questionId = json['questionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answerIds'] = answerIds;
    data['chefId'] = chefId;
    data['id'] = id;
    data['inputAnswer'] = inputAnswer;
    data['questionId'] = questionId;
    return data;
  }
}

class SocialHandles {
  String? facebook;
  String? instagram;
  String? tiktok;
  String? twitter;

  SocialHandles({this.facebook, this.instagram, this.tiktok, this.twitter});

  SocialHandles.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    tiktok = json['tiktok'];
    twitter = json['twitter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['tiktok'] = tiktok;
    data['twitter'] = twitter;
    return data;
  }
}