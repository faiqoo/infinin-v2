import 'package:chef/helpers/helpers.dart';

import '../home/experiences_details/experience_details_screen_v.dart';
import 'package:video_player/video_player.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.network(_test);
    _controller = VideoPlayerController.asset(Resources.onBoardingVideo);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await PackageInfo.fromPlatform().then((value) {
      _packageInfo = value;
      setState(() {});
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoPlayer(_controller),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _getStartedTitle(appTheme: appTheme),
                const SizedBox(
                  height: 12,
                ),
                _getStartedSubTitle(appTheme: appTheme),
                const SizedBox(
                  height: 230,
                ),
                _getStartedButtonTitle(appTheme: appTheme),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      ' Version ' + '${_packageInfo.version}',
                      style: appTheme.typographies.interFontFamily.headline6,
                    )),
              ],
            ),
          ) /* add child content here */,
        ],

        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         Resources.getStartedBgPng,
        //       ),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child:
      ),
    );
  }

  Widget _getStartedTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.getStartedTitle,
      textAlign: TextAlign.center,
      // style: appTheme.typographies.interFontFamily.headline4.copyWith(
      //   color: Colors.white,
      //   fontSize: 21,
      //   shadows: <Shadow>[
      //     Shadow(
      //       offset: Offset(10.0, 5.0),
      //       blurRadius: 10.0,
      //       color: Colors.black.withOpacity(0.4),
      //     ),
      //   ],
      // ),

      style: appTheme.typographies.interFontFamily.headline7.copyWith(
        height: 1.5,
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(10.0, 5.0),
            blurRadius: 10.0,
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
    );
  }

  Widget _getStartedSubTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.getStartedSubtitle,
      textAlign: TextAlign.center,

      style: appTheme.typographies.interFontFamily.headline7.copyWith(
        color: Colors.white,
        height: 1.5,

        fontWeight: FontWeight.w500,
        fontSize: 16,
        //color: _IColors.white,
        // fontSize: 15,
        // fontWeight: FontWeight.w500,
        // fontStyle:
        // fontWeight:
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(10.0, 5.0),
            blurRadius: 10.0,
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
      // style: appTheme.typographies.interFontFamily.headline6.copyWith(
      //   color: Colors.white,
      //   fontSize: 15,
      //   shadows: <Shadow>[
      //     Shadow(
      //       offset: Offset(10.0, 5.0),
      //       blurRadius: 10.0,
      //       color: Colors.black.withOpacity(0.4),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.getStartedButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ExperienceDetailsScreen()),
        // );

        //    viewModel.goToForgotPasswordScreen();
      },
    );
  }
}
