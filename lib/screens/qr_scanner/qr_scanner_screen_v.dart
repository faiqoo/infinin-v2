import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/screens/qr_scanner/qr_scanner_screen_m.dart';
import 'package:chef/screens/qr_scanner/qr_scanner_screen_vm.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/qr_scanner/bar_code_scanner.dart';

class QrScannerScreen extends BaseView<QrScannerScreenViewModel> {
  QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    return BlocBuilder<QrScannerScreenViewModel, QrScannerScreenState>(
      bloc: viewModel,
      builder: (_, state) {
        return BarcodeScannerView(
          onCapture: (String? data) {
            Navigator.pop(context, data);
          },
        );
      },
    );
  }
}
