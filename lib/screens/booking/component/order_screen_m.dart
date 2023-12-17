import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chef/base/base.dart';

import '../../../models/booking/booking_status.dart';

part 'order_screen_m.freezed.dart';

@freezed
class OrderScreenState extends BaseState with _$OrderScreenState {
  const factory OrderScreenState.loading() = Loading;
  const factory OrderScreenState.loaded(BookingStatus bookingStatus) = Loaded;
}
