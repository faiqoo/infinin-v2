import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

import '../../../models/preference.dart';
import '../../../models/signup/responses/city_response.dart';
import '../../../models/wow_factor/wow_factor_response.dart';

part 'create_experience_screen_m.freezed.dart';

@freezed
class CreateExperienceScreenState extends BaseState
    with _$CreateExperienceScreenState {
  const factory CreateExperienceScreenState.loading() = Loading;
  const factory CreateExperienceScreenState.loaded(
      WowFactorResponse wowFactorResponse,
      PreferenceResponse preferenceResponse,
      CityResponse? cityData) = Loaded;
}
