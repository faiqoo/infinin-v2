import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/home/home_screen.dart';

import '../bottom_bar/bottom_bar.dart';
import 'component/create_experience_screen_v.dart';

class ExperienceQuestionireScreen extends StatefulWidget {
  const ExperienceQuestionireScreen({Key? key}) : super(key: key);

  @override
  _ExperienceQuestionireScreenState createState() =>
      _ExperienceQuestionireScreenState();
}

class _ExperienceQuestionireScreenState
    extends State<ExperienceQuestionireScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                Resources.expBackgroundPNG,
                fit: BoxFit.cover,
              )),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 34, top: 53),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Resources.expLogoPNG,
                            height: 72,
                            width: 68,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GeneralText(
                            Strings.experienceScreenTitle,
                            textAlign: TextAlign.start,
                            style: appTheme
                                .typographies.interFontFamily.headline4
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Resources.getSignUpLetsStartScreenTickPng,
                            height: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GeneralText(
                              Strings.letsStartScreenLabel2,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: appTheme
                                  .typographies.interFontFamily.headline4
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Resources.getSignUpLetsStartScreenTickPng,
                            height: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GeneralText(
                              Strings.letsStartScreenLabel2,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: appTheme
                                  .typographies.interFontFamily.headline4
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Resources.getSignUpLetsStartScreenTickPng,
                            color: Colors.white,
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
                              style: appTheme
                                  .typographies.interFontFamily.headline4
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Resources.getSignUpLetsStartScreenTickPng,
                            height: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GeneralText(
                              Strings.letsStartScreenLabel2,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: appTheme
                                  .typographies.interFontFamily.headline4
                                  .copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Center(child: _okButtonTitle(appTheme: appTheme)),
                const SizedBox(
                  height: 87,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _okButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 180,
      title: Strings.experienceScreenButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => const FoodDetailScreen()),
          MaterialPageRoute(builder: (context) => CreateExperienceScreen()),
        );
        //    viewModel.goToForgotPasswordScreen();
      },
    );
  }
}
