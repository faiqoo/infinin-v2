

import 'dart:convert';

QuestionireRequest questionireRequestFromJson(String str) => QuestionireRequest.fromJson(json.decode(str));

String questionireRequestToJson(QuestionireRequest data) => json.encode(data.toJson());

class QuestionireRequest {
  QuestionireRequest({
    required this.t,
  });

  T t;

  factory QuestionireRequest.fromJson(Map<String, dynamic> json) => QuestionireRequest(
    t: T.fromJson(json["t"]),
  );

  Map<String, dynamic> toJson() => {
    "t": t.toJson(),
  };
}

class T {
  T({
    required this.category,
  });

  String category;

  factory T.fromJson(Map<String, dynamic> json) => T(
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
  };
}
