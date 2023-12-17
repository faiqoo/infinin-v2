import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'package:chef/screens/qr_scanner/camera_view.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({
    required Function(String?) onCapture,
    Key? key,
  })  : _onCapture = onCapture,
        super(key: key);

  final Function(String?) _onCapture;

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    if (mounted) {
      setState(() {});
    }

    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      for (var barcode in barcodes) {
        final displayValue = (barcode.displayValue)!;
        displayURL(displayValue);
      }
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void displayURL(String? displayValue) {
    try {
      if (displayValue != null && displayValue.isNotEmpty) {
        _canProcess = false;
        _barcodeScanner.close();
        widget._onCapture.call(displayValue);
      }
    } catch (exception) {
      _canProcess = false;
      _barcodeScanner.close();
    }
  }
}
