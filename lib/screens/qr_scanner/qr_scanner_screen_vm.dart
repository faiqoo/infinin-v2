import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/screens/qr_scanner/qr_scanner_screen_m.dart';

@injectable
class QrScannerScreenViewModel extends BaseViewModel<QrScannerScreenState> {
  QrScannerScreenViewModel() : super(const Initialized());
}
