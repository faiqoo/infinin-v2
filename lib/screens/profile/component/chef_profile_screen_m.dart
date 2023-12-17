import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chef/base/base.dart';

import '../../../models/profile/profile_details_response_model.dart';

part 'chef_profile_screen_m.freezed.dart';

@freezed
class ChefProfileDetailsScreenState extends BaseState
    with _$ChefProfileDetailsScreenState {
  const factory ChefProfileDetailsScreenState.loading() = Loading;
  const factory ChefProfileDetailsScreenState.loaded(
      ProfileDetails profileDetails) = Loaded;
}
