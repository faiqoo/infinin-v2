import 'package:chef/helpers/helpers.dart';
import 'package:chef/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../constants/resources.dart';
import '../../../constants/strings.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/function_helper.dart';
import '../../../models/home/experience_list_response.dart';
import '../../../setup.dart';
import '../../../ui_kit/widgets/general_new_appbar.dart';
import '../../../ui_kit/widgets/general_rich_text.dart';
import '../../../ui_kit/widgets/general_text.dart';
import '../../booking/food_item_bookng.dart';

import 'dart:developer' as developer;

import '../../experience/component/create_experience_screen_v.dart';
import '../../experience/component/experience_starting_screen.dart';
import '../experience_menu_details/experience_menu_details_screen_v.dart';
import '../experiences_details/experience_details_screen_vm.dart';

class PopularFoodDetails extends StatefulWidget {
  const PopularFoodDetails({
    required ExperienceListResponse expResponse,
    Key? key,
  })  : _expResponse = expResponse,
        super(key: key);

  final ExperienceListResponse _expResponse;

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  List<CustomModel> wowFactorsList = [];
  final _navigation = locateService<INavigationService>();

  final _experienceScreenViewModel =
      locateService<ExperienceDetailsScreenViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    wowFactorsList.addAll([
      CustomModel(
          icon: Strings.productDetailWowFactorGarden,
          name: "assets/images/icons/garden.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorMusic,
          name: "assets/images/icons/music.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorFireworks,
          name: "assets/images/icons/fireworks.png"),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: HexColor.fromHex("#212129"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget._expResponse.t.isEmpty?_navigation.navigateTo(route: ExperienceStartingRoute()):_navigation.navigateTo(route: CreateExperienceRoute());
        },
        backgroundColor: Color(0xffbb3127),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 12),
            child: GeneralNewAppBar(
              title: Strings.popularFoodDetailAppBarTitle,
              // title: 'hello',
              titleColor: Colors.white,
              rightIcon: Resources.homeIconSvg,
            ),
          ),
          Expanded(child: allPopularFoodItemList(appTheme)),
        ],
      ),
    );
  }

  Widget allPopularFoodItemList(IAppThemeData appTheme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget._expResponse.t.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                developer.log(
                    ' Clicked data is ' + '${widget._expResponse.t[index].id}');
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ExperienceMenuDetailsScreen(
                    expId: widget._expResponse.t[index].id,
                    experienceData: widget._expResponse.t[index],
                  );
                }));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                padding: EdgeInsets.only(left: 33, bottom: 17),
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#4b4b52"),
                    borderRadius: BorderRadius.circular(30)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(children: [
                    Positioned(
                      right: -50,
                      top: -40,
                      child: Container(
                        width: 173,
                        padding: const EdgeInsetsDirectional.all(20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/icons/food_product_ring.png'),
                            fit: BoxFit.fill,
                          ),
                          // shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/icons/food_product_experience.png',
                          fit: BoxFit.fill,
                          height: 150,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32.2,
                        ),

                        SizedBox(
                          width: 120,
                          child: GeneralText(
                            // title: Strings.popularFoodDetailTitle,
                            widget._expResponse.t[index].title,

                            //     width: 60.0,
                            style:
                                appTheme.typographies.interFontFamily.label11,
                          ),
                        ),
                        // GeneralRichText(
                        //   // title: Strings.popularFoodDetailTitle,
                        //   //   title: widget._expResponse.t[index].title,
                        //   title: 'Desi Desi Desi Desi Desi Desi Desi Desi ',
                        //   width: 60.0,
                        //   titleStyle:
                        //       appTheme.typographies.interFontFamily.label11,
                        // ),
                        SizedBox(
                          height: 4,
                        ),
                        // GeneralText(
                        //   Strings.popularFoodDetailSubTitle,
                        //   style: appTheme.typographies.interFontFamily.headline6
                        //       .copyWith(
                        //     fontSize: 12,
                        //     color: HexColor.fromHex('#909094'),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 13.9,
                              child: Image.asset(
                                'assets/images/icons/star.png',
                                fit: BoxFit.fill,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GeneralText(
                              Strings.popularFoodDetailReview,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 37,
                        ),
                        GeneralText(
                          Strings.popularFoodDetailWowFactorTitle,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                                  fontSize: 16,
                                  color: HexColor.fromHex(
                                    '#ffffff',
                                  ),
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 11.7,
                        ),
                        wowFactors(appTheme, index),
                      ],
                    )
                  ]),
                ),
              ),
            );
          }),
    );
  }

  Widget wowFactors(IAppThemeData appTheme, int index) {
    int wowLength = widget._expResponse.t[index].experienceWowFactors.length > 3
        ? 3
        : widget._expResponse.t[index].experienceWowFactors.length;

    return Wrap(
      children: [
        //for (int i = 0; i <  wowFactorsList.length; i++)
        for (int i = 0; i < wowLength; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8.1, bottom: 7.7),
            child: Container(
              width: 71,
              padding: const EdgeInsetsDirectional.all(22),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icons/black_image_ring.png'),
                ),
              ),
              child: Container(
                child: widget._expResponse.t[index].experienceWowFactors[i]
                            .wowFactorIconPath !=
                        null
                    ? SvgPicture.network(
                        (FunctionHelper.getValidUrlForImages(widget
                            ._expResponse
                            .t[index]
                            .experienceWowFactors[i]
                            .wowFactorIconPath!)),

                        // wowFactorsList[i].name != null
                        //     ? wowFactorsList[i].name ?? ""
                        //     : '',
                        color: HexColor.fromHex("#f1c452"),
                        // height: 15.3,
                        // width: 14.4,
                      )
                    : Image.asset('assets/images/icons/fireworks.png'),
              ),
              // child: Container(
              //   child: Image.asset(
              //     widget._expResponse.t[index].experienceWowFactors[i]
              //                 .wowFactorName !=
              //             null
              //         ? widget._expResponse.t[index].experienceWowFactors[i]
              //                 .wowFactorName ??
              //             ""
              //         : '',
              //     // wowFactorsList[i].name != null
              //     //     ? wowFactorsList[i].name ?? ""
              //     //     : '',
              //     color: HexColor.fromHex("#f1c452"),
              //   ),
              // ),
            ),
          ),
      ],
    );
  }
}

class CustomModel {
  String? name;
  String? icon;

  CustomModel({this.name, this.icon});
}
