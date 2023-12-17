import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

import '../../../models/home/experience_list_response.dart';
import '../../../models/preference.dart';
import '../../../models/wow_factor/wow_factor_response.dart';

part 'experience_details_screen_m.freezed.dart';

@freezed
class ExperienceDetailsScreenState extends BaseState
    with _$ExperienceDetailsScreenState {
  const factory ExperienceDetailsScreenState.loading() = Loading;
  const factory ExperienceDetailsScreenState.loaded(
    ExperienceListResponse experienceListResponse,
  ) = Loaded;
}
