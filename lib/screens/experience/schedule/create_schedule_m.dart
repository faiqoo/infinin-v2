import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chef/base/base.dart';

part 'create_schedule_m.freezed.dart';

@freezed
class ScheduleScreenState extends BaseState with _$ScheduleScreenState {
  const factory ScheduleScreenState.loading() = Loading;
  const factory ScheduleScreenState.loaded() = Loaded;
}
