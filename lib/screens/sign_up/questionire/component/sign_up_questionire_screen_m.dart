


import 'package:chef/base/base.dart';
import 'package:chef/models/signup/responses/questionire_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_questionire_screen_m.freezed.dart';

@freezed
class SignUpQuestionireScreenState extends BaseState with _$SignUpQuestionireScreenState {

  const factory SignUpQuestionireScreenState.loading() = Loading;
  const factory SignUpQuestionireScreenState.loaded(List<QuestionsList> data) = Loaded;
}
