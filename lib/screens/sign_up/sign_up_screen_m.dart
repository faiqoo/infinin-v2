import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

import '../../models/signup/responses/city_response.dart';

part 'sign_up_screen_m.freezed.dart';

@freezed
class SignUpScreenState extends BaseState with _$SignUpScreenState {
  const factory SignUpScreenState.initialized({
    required String fullName,
    required String brandName,
    required String mobileNumber,
    required String address,
    // required String town,
    // required String city,
  }) = Initialized;
  const factory SignUpScreenState.loading() = Loading;
  const factory SignUpScreenState.loaded(CityResponse? cityData) = Loaded;
}
