import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

import '../../../models/dish/dish_response.dart';
import '../../../models/meal/meal_response.dart';

part 'menu_experience_screen_m.freezed.dart';

@freezed
class MenuExperienceScreenState extends BaseState
    with _$MenuExperienceScreenState {
  const factory MenuExperienceScreenState.loading() = Loading;
  const factory MenuExperienceScreenState.loaded(
      MealResponse mealResponse, DishList dishResponse) = Loaded;
}
