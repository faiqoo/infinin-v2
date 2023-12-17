import 'package:chef/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../home/experiences_details/experience_details_screen_v.dart';
import '../home/home_page/home_screen_v.dart';
import '../home/home_screen.dart';
import '../home/widget/popular_food_detail.dart';

class ShowOffTimeScreen extends StatefulWidget {
  const ShowOffTimeScreen({Key? key}) : super(key: key);

  @override
  State<ShowOffTimeScreen> createState() => _ShowOffTimeScreenState();
}

class _ShowOffTimeScreenState extends State<ShowOffTimeScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: getSaveButton(appTheme: appTheme),
            backgroundColor: HexColor.fromHex("#212129"),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                    height: 218,
                    child: Image.asset(
                      "assets/images/icons/show_off_time.png",
                    )),
                Stack(
                  children: [
                    Positioned(
                      right: -150,
                      top: -40,
                      // bottom: -10,
                      child: Container(
                        width: 300,
                        height: 400,
                        child: Image.asset(
                          'assets/images/icons/food_product_ring.png',
                          color: const Color(0xfff1c452).withOpacity(0.2),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 29),
                              child: GeneralText(
                                Strings.timeToShowLabel,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        fontSize: 24,
                                        color: HexColor.fromHex('#ffffff')),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 29, end: 35),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 53,
                              ),
                              uploadVideos(appTheme),
                              const SizedBox(
                                height: 16,
                              ),
                              uploadPictures(appTheme),
                              const SizedBox(
                                height: 28,
                              ),
                              Center(child: keepInMindLink(appTheme)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ]),
            ),
          ),
        ));
  }

  Widget uploadVideos(IAppThemeData appTheme) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor.fromHex("#ffffff"),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.only(left: 20, right: 24, top: 20.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.uploadVideosLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: HexColor.fromHex('#212129')),
              ),
              Row(
                children: [
                  GeneralText(
                    Strings.uploadVideosProgressValue,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            fontSize: 12, color: HexColor.fromHex('#8ea659')),
                  ),
                  const SizedBox(
                    width: 5.5,
                  ),
                  Container(
                      width: 24,
                      child:
                          Image.asset("assets/images/icons/upload_videos.png"))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: HexColor.fromHex("#8ea659")),
          )
        ],
      ),
    );
  }

  Widget uploadPictures(IAppThemeData appTheme) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor.fromHex("#ffffff"),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.only(left: 20, right: 24, top: 20.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.uploadPicturesLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: HexColor.fromHex('#212129')),
              ),
              Row(
                children: [
                  GeneralText(
                    Strings.uploadPicturesProgressValue,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            fontSize: 12, color: HexColor.fromHex('#8ea659')),
                  ),
                  const SizedBox(
                    width: 5.5,
                  ),
                  Container(
                      width: 24,
                      child: Image.asset(
                          "assets/images/icons/upload_pictures.png"))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 1.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: HexColor.fromHex("#8ea659")),
          )
        ],
      ),
    );
  }

  Widget keepInMindLink(IAppThemeData appTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 24, child: Image.asset("assets/images/icons/info_icon.png")),
        const SizedBox(
          width: 8,
        ),
        GeneralText(
          Strings.keepInMindLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 15,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w300,
              color: HexColor.fromHex('#f1c452')),
        ),
      ],
    );
  }

  Widget getSaveButton({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 181,
      title: Strings.saveButtonLabel.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        _showInfoPopup(context);
      },
    );
  }

  Future<dynamic> _showInfoPopup(BuildContext context) async {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.show(
      context: context,
      // dialogType: GeneralComponentStyle.success,
      isDismissible: true,
      barrierLabel: '',
      // title: 'Verification\nCode',
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            GeneralText(
              Strings.infoPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 38,
            ),
            Row(
              children: [
                Image.asset(
                  Resources.getSignUpLetsStartScreenTickPng,
                  height: 15,
                  color: const Color(0xfffee4a4),
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
                            color: const Color(0xfffee4a4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              children: [
                Image.asset(
                  Resources.getSignUpLetsStartScreenTickPng,
                  height: 15,
                  color: const Color(0xfffee4a4),
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
                            color: const Color(0xfffee4a4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              children: [
                Image.asset(
                  Resources.getSignUpLetsStartScreenTickPng,
                  height: 15,
                  color: const Color(0xfffee4a4),
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
                            color: const Color(0xfffee4a4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 49,
            ),
            GeneralButton.button(
              title: Strings.infoPopupButtonTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //   return ExperienceDetailsScreen();
                //   //  return PopularFoodDetails();
                // }));

                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return HomeScreenView();
                  //  return PopularFoodDetails();
                }));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
                //    viewModel.goToForgotPasswordScreen();
              },
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      // body: GBottomSheet<String>(
      //   bottomSheetTitle: Strings.chooseDateFormat,
      //   list: ['7878,87,876'],
      //   selectedItem: viewModel.getSelectedFormat(),
      //   bottomSheetType: BottomSheetType.dateFormat,
      // ),
    );
  }
}
