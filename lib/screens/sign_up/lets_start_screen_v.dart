import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/home/home_screen.dart';

import '../../setup.dart';
import '../bottom_bar/bottom_bar.dart';
import '../experience/experience_questionire_v.dart';
import '../home/home_page/home_screen_v.dart';

class SignUpLetsStartScreen extends StatefulWidget {
  const SignUpLetsStartScreen({Key? key}) : super(key: key);

  @override
  _SignUpLetsStartScreenState createState() => _SignUpLetsStartScreenState();
}

class _SignUpLetsStartScreenState extends State<SignUpLetsStartScreen> {
  final _navigation = locateService<INavigationService>();

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset(Resources.getSignUpLetsStartScreenBgPng),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralText(
                  Strings.letsStartScreenLabel,
                  textAlign: TextAlign.start,
                  style: appTheme.typographies.interFontFamily.headline4
                      .copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 27,
                ),
                GeneralText(
                  Strings.letsStartScreenLabel1,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: appTheme.typographies.interFontFamily.headline4
                      .copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Image.asset(
                      Resources.getSignUpLetsStartScreenTickPng,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel2,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                                color: Color(0xfffee4a4),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      Resources.getSignUpLetsStartScreenTickPng,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel3,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                                color: Color(0xfffee4a4),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      Resources.getSignUpLetsStartScreenTickPng,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel4,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                                color: Color(0xfffee4a4),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      Resources.getSignUpLetsStartScreenTickPng,
                      height: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel2,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                                color: Color(0xfffee4a4),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          Center(child: _letsStartedButtonTitle(appTheme: appTheme)),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _letsStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 180,
      title: Strings.letsStartScreenBtnLabel.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        _navigation.replace(route: HomeRouteView());
        //    viewModel.goToForgotPasswordScreen();
      },
    );
  }
}
