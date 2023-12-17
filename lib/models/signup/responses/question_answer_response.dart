import 'dart:convert';

ChefQuestionAnswerResponse chefQuestionAnswerResponseFromJson(String str) =>
    ChefQuestionAnswerResponse.fromJson(json.decode(str));

String chefQuestionAnswerResponseToJson(ChefQuestionAnswerResponse data) => json.encode(data.toJson());

class ChefQuestionAnswerResponse {
  int? code;
  String? error;
  String? message;
  List<T>? t;
  int? userId;

  ChefQuestionAnswerResponse({this.code, this.error, this.message, this.t, this.userId});

  ChefQuestionAnswerResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    error = json['error'];
    message = json['message'];
    if (json['t'] != null) {
      t = <T>[];
      json['t'].forEach((v) {
        t!.add(T.fromJson(v));
      });
    }
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['error'] = error;
    data['message'] = message;
    if (t != null) {
      data['t'] = t!.map((v) => v.toJson()).toList();
    }
    data['userId'] = userId;
    return data;
  }
}

class T {
  List<int>? answerIds;
  int? chefId;
  int? id;
  String? inputAnswer;
  int? questionId;

  T({this.answerIds, this.chefId, this.id, this.inputAnswer, this.questionId});

  T.fromJson(Map<String, dynamic> json) {
    answerIds = json['answerIds'] != null ? List<int>.from(json['answerIds']) : null;
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
