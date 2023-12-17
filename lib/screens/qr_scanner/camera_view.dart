import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

import 'package:chef/setup.dart';
import 'package:chef/ui_kit/overlay/scanner_overlay.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/services/navigation/navigation.dart';
import 'package:chef/theme/theme.dart';

import 'package:chef/ui_kit/general_ui_kit.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  const CameraView({
    required this.onImage,
    this.onScreenModeChanged,
    this.initialDirection = CameraLensDirection.back,
    Key? key,
  }) : super(key: key);
  final Function(InputImage inputImage) onImage;
  final Function(ScreenMode mode)? onScreenModeChanged;
  final CameraLensDirection initialDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  ScreenMode _mode = ScreenMode.liveFeed;
  CameraController? _controller;
  int _cameraIndex = -1;
  final bool _changingCameraLens = false;
  bool _enableFlash = false;

  final _navigationService = locateService<INavigationService>();

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    if (cameras.any(
      (element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) =>
              element.lensDirection == widget.initialDirection &&
              element.sensorOrientation == 90,
        ),
      );
    } else {
      for (var i = 0; i < cameras.length; i++) {
        if (cameras[i].lensDirection == widget.initialDirection) {
          _cameraIndex = i;
          break;
        }
      }
    }

    if (_cameraIndex != -1) {
      _startLiveFeed();
    } else {
      _mode = ScreenMode.gallery;
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      body: _body(appTheme),
    );
  }

  Widget _body(IAppThemeData appTheme) {
    Widget body;
    if (_mode == ScreenMode.liveFeed) {
      body = _liveFeedBody(appTheme);
    } else {
      body = const SizedBox();
    }
    return body;
  }

  Widget _liveFeedBody(IAppThemeData appTheme) {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    final chipPositionFromTop = size.height / 2 - 256 / 2 - 64;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.scale(
          scale: scale,
          child: Center(
            child: _changingCameraLens
                ? const Center(
                    child: Text('Changing camera lens'),
                  )
                : CameraPreview(_controller!),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: ShapeDecoration(
              shape: ScannerOverlayShape(
                borderRadius: 20,
                borderLength: 64,
                borderWidth: 8,
                cutOutSize: 256,
              ),
            ),
          ),
        ),
        Positioned(
          top: 64,
          right: 24,
          child: InkWell(
            onTap: () => _navigationService.pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: appTheme.colors.secondaryBackground,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.close),
            ),
          ),
        ),
        Positioned(
          top: chipPositionFromTop,
          left: 100,
          right: 100,
          child: Chip(
            label: GeneralText(
              Strings.scanningInstructions,
              style: appTheme.typographies.interFontFamily.label4.copyWith(
                color: appTheme.colors.secondaryBackground,
              ),
            ),
            backgroundColor: appTheme.colors.primary.withOpacity(0.7),
          ),
        ),
        Positioned(
          left: 156,
          right: 156,
          bottom: 56,
          child: InkWell(
            onTap: () => onSetFlashModeButtonPressed(
              _enableFlash ? FlashMode.off : FlashMode.torch,
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: appTheme.colors.secondaryBackground,
              child: Icon(
                _enableFlash ? Icons.flashlight_off : Icons.flashlight_on,
                color: appTheme.colors.searchBorder,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) {
        setState(() {
          _enableFlash = !_enableFlash;
        });
      }
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (_controller == null) {
      return;
    }

    try {
      await _controller!.setFlashMode(mode);
    } on CameraException {
      rethrow;
    }
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _processCameraImage(CameraImage image) async {
    final allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
