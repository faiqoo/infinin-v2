import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:chef/base/base.dart';

part 'qr_scanner_screen_m.freezed.dart';

@freezed
class QrScannerScreenState extends BaseState with _$QrScannerScreenState {
  const factory QrScannerScreenState.initialized() = Initialized;
}
