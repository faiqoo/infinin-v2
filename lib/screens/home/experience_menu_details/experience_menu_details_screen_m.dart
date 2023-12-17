import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

import '../../../models/experience/schedule_list_display.dart';
import '../../../models/home/experience_list_response.dart';
import '../../../models/home/food_details_menu_model.dart';
import '../../../models/preference.dart';
import '../../../models/wow_factor/wow_factor_response.dart';

part 'experience_menu_details_screen_m.freezed.dart';

@freezed
class ExperienceMenuDetailsScreenState extends BaseState
    with _$ExperienceMenuDetailsScreenState {
  const factory ExperienceMenuDetailsScreenState.loading() = Loading;
  const factory ExperienceMenuDetailsScreenState.loaded(
      FoodMenuModel foodMenuModel,
      ScheduleData scheduleData,
      ) = Loaded;
}
