import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chef/base/base.dart';

import '../../../models/booking/booking_status.dart';
import '../../../models/booking/order_detail_response.dart';
import '../../../models/foodie/foodie_details_response.dart';

part 'foodie_profile_decision_screen_m.freezed.dart';

@freezed
class FoodieProfileDecisionScreenState extends BaseState
    with _$FoodieProfileDecisionScreenState {
  const factory FoodieProfileDecisionScreenState.loading() = Loading;
  const factory FoodieProfileDecisionScreenState.loaded(
      OrderDetails orderDetails) = Loaded;
}
