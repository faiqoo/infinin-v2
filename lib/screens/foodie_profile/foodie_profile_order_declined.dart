import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';

class FoodieProfileOrderDeclined extends StatefulWidget {
  const FoodieProfileOrderDeclined({Key? key}) : super(key: key);

  @override
  State<FoodieProfileOrderDeclined> createState() =>
      _FoodieProfileOrderDeclinedState();
}

class _FoodieProfileOrderDeclinedState
    extends State<FoodieProfileOrderDeclined> {
  List<CustomModel> wowFactorsList = [];
  List<CustomModel> menuListItems = [];
  bool checkValue = false;

  @override
  void initState() {
    // TODO: implement initState
    menuListItems.addAll([
      CustomModel(name: "Sindhi Biryani"),
      CustomModel(name: "Buritto"),
      CustomModel(name: "Vegetable Salad"),
      CustomModel(name: "Hyderabadi Rice"),
      CustomModel(name: "Soft Drinks"),
    ]);
    wowFactorsList.addAll([
      CustomModel(
          foodCategory: Strings.foodieProfileFoodCategoryLabel,
          name: Strings.productDetailWowFactorGarden,
          icon: "assets/images/icons/garden.png"),
      CustomModel(
          foodCategory: Strings.foodieProfileAmbienceCategoryLabel,
          name: Strings.productDetailWowFactorFireworks,
          icon: "assets/images/icons/fireworks.png"),
      CustomModel(
          foodCategory: Strings.foodieProfileCuisineCategoryLabel,
          name: Strings.productDetailWowFactorPetFriendly,
          icon: "assets/images/icons/pet_friendly.png"),
      CustomModel(
          foodCategory: Strings.foodieProfileInterestsCategoryLabel,
          name: Strings.productDetailWowFactorWifi,
          icon: "assets/images/icons/wifi_2.png"),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              color: HexColor.fromHex("#212129"),
              child: Column(
                children: [
                  Container(
                    height: 209,
                    padding: EdgeInsetsDirectional.only(start: 29),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#4b4b52"),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: GeneralNewAppBar(
                            title: Strings.foodieProfileHeader,
                            titleColor: Colors.white,
                            rightIcon: Resources.homeIconSvg,
                          ),
                        ),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 90,
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: HexColor.fromHex("#ffffff"),
                                          width: 2)),
                                  child: Image.asset(
                                      "assets/images/icons/foodie_profile.png"),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                GeneralText(
                                  Strings.foodieProfileName,
                                  style: appTheme
                                      .typographies.interFontFamily.headline6
                                      .copyWith(
                                    fontSize: 18,
                                    color: HexColor.fromHex('#f1c452'),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 13.9,
                                      child: Image.asset(
                                        'assets/images/icons/star.png',
                                        fit: BoxFit.fill,
                                        color: HexColor.fromHex("#f1c452"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GeneralText(
                                      Strings.productDetailReview,
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color:
                                          HexColor.fromHex('#f1c452')),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.9,
                                ),
                              ]),
                        ),
                        Positioned.fill(
                          bottom: -15,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),

                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#b0c18b"),
                                  borderRadius: BorderRadius.circular(20)),
                              child: GeneralText(
                                Strings.foodieProfileOrderDeclined
                                    .toUpperCase(),
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                  fontSize: 12,
                                  color: HexColor.fromHex('#212129'),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 33.9,
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 25, end: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              color: HexColor.fromHex('#f1c452'),
                              width: 16,
                              height: 1,
                            ),
                            const SizedBox(
                              width: 7.2,
                            ),
                            GeneralText(
                              Strings.foodieProfileExperienceLabel,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 20,
                                color: HexColor.fromHex('#f1c452'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18.5,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: HexColor.fromHex("#4b4b52"),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsetsDirectional.only(
                              start: 22.5, top: 30, bottom: 30),
                          child: GeneralText(
                            Strings.foodieProfileExperienceValue,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                              fontSize: 18,
                              color: HexColor.fromHex('#ffffff'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35.5,
                        ),
                        Row(
                          children: [
                            Container(
                              color: HexColor.fromHex('#f1c452'),
                              width: 16,
                              height: 1,
                            ),
                            const SizedBox(
                              width: 7.2,
                            ),
                            GeneralText(
                              Strings.foodieProfileLabel,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 20,
                                color: HexColor.fromHex('#f1c452'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.9,
                        ),
                        wowFactors(appTheme),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  foodProductDetails(appTheme),
                  const SizedBox(
                    height: 28,
                  ),
                  foodieInfo(appTheme),
                  const SizedBox(
                    height: 47.9,
                  ),
                  productPriceInformation(appTheme),
                  const SizedBox(
                    height: 33.9,
                  ),
                  declineReason(appTheme),
                  SizedBox(
                    height: 98,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget wowFactors(IAppThemeData appTheme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
          top: 16.9, bottom: 16.9, start: 38, end: 19.5),
      decoration: BoxDecoration(
          color: HexColor.fromHex("#4b4b52"),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12,right: 18.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7.7),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GeneralText(
                          wowFactorsList[0].foodCategory ?? "",
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#f1c452'),
                          ),
                        ),
                        Container(
                          width: 58,
                          height: 63.3,
                          padding: const EdgeInsetsDirectional.all(10),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/icons/food_item_circle.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(10),
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#f1c452"),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(wowFactorsList[0].icon != null
                                ? wowFactorsList[0].icon ?? ""
                                : ''),
                          ),
                        ),
                        GeneralText(
                          wowFactorsList[0].name ?? "",
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 14,
                            color: HexColor.fromHex('#ffffff'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 7.7),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GeneralText(
                          wowFactorsList[1].foodCategory ?? "",
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#f1c452'),
                          ),
                        ),
                        Container(
                          width: 58,
                          height: 63.3,
                          padding: const EdgeInsetsDirectional.all(10),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/icons/food_item_circle.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(10),
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#f1c452"),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(wowFactorsList[1].icon != null
                                ? wowFactorsList[1].icon ?? ""
                                : ''),
                          ),
                        ),
                        GeneralText(
                          wowFactorsList[1].name ?? "",
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 14,
                            color: HexColor.fromHex('#ffffff'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 7.7),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GeneralText(
                        wowFactorsList[2].foodCategory ?? "",
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 16,
                          color: HexColor.fromHex('#f1c452'),
                        ),
                      ),
                      Container(
                        width: 58,
                        height: 63.3,
                        padding: const EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/icons/food_item_circle.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: const EdgeInsetsDirectional.all(10),
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#f1c452"),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(wowFactorsList[2].icon != null
                              ? wowFactorsList[2].icon ?? ""
                              : ''),
                        ),
                      ),
                      GeneralText(
                        wowFactorsList[2].name ?? "",
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 14,
                          color: HexColor.fromHex('#ffffff'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      GeneralText(
                        wowFactorsList[3].foodCategory ?? "",
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 16,
                          color: HexColor.fromHex('#f1c452'),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7.7),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 58,
                                    height: 63.3,
                                    padding:
                                    const EdgeInsetsDirectional.all(10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/icons/food_item_circle.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      padding:
                                      const EdgeInsetsDirectional.all(10),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex("#f1c452"),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                          wowFactorsList[3].icon != null
                                              ? wowFactorsList[3].icon ?? ""
                                              : ''),
                                    ),
                                  ),
                                  GeneralText(
                                    wowFactorsList[3].name ?? "",
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                      fontSize: 14,
                                      color: HexColor.fromHex('#ffffff'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 11.4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7.7),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 58,
                                    height: 63.3,
                                    padding:
                                    const EdgeInsetsDirectional.all(10),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/icons/food_item_circle.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      padding:
                                      const EdgeInsetsDirectional.all(10),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex("#f1c452"),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                          wowFactorsList[3].icon != null
                                              ? wowFactorsList[3].icon ?? ""
                                              : ''),
                                    ),
                                  ),
                                  GeneralText(
                                    wowFactorsList[3].name ?? "",
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                      fontSize: 14,
                                      color: HexColor.fromHex('#ffffff'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget foodProductDetails(IAppThemeData appTheme) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(
              top: 22, bottom: 29, start: 10, end: 10),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#4b4b52"),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    top: 17, bottom: 17, start: 26, end: 48),
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#212129"),
                    borderRadius: BorderRadius.circular(11)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GeneralText(
                            Strings.productDetailSelectionDate,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#ea7458'),
                            ),
                          ),
                          GeneralText(
                            Strings.productDetailSelectionTime,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 30,
                              color: HexColor.fromHex('#b0c18b'),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: HexColor.fromHex('#707070'),
                        width: 1,
                        height: 69,
                      ),
                      Column(
                        children: [
                          GeneralText(
                            Strings.productDetailSelectionType,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#8ea659'),
                            ),
                          ),
                          GeneralText(
                            Strings.productDetailSelectionTotalPersons,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 30,
                              color: HexColor.fromHex('#8ea659'),
                            ),
                          ),
                          GeneralText(
                            Strings.productDetailSelectionPersons,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                                fontSize: 12,
                                color: HexColor.fromHex('#909094'),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: 29,
              ),
              productRelatedNotes(appTheme),
              SizedBox(
                height: 29,
              ),
              productMenuDetails(appTheme),
            ],
          )),
    );
  }

  Widget productRelatedNotes(IAppThemeData appTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.productDetailSelectionNotesLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontSize: 16,
            color: HexColor.fromHex('#f1c452'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.only(
              top: 15, bottom: 15, start: 14, end: 14),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#212129"),
              borderRadius: BorderRadius.circular(11)),
          child: GeneralText(
            Strings.productDetailSelectionNotes,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 14,
                color: HexColor.fromHex('#ffffff'),
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  Widget productMenuDetails(IAppThemeData appTheme) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GeneralText(
          Strings.productDetailSelectionMenuLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontSize: 16,
            color: HexColor.fromHex('#f1c452'),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Wrap(
          children: [
            for (int index = 0; index < menuListItems.length; index++)
              Container(
                width: 140,
                // height: 67,
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 14, end: 14),
                margin: EdgeInsets.only(right: 5, bottom: 7),
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#212129"),
                    borderRadius: BorderRadius.circular(11)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GeneralText(
                          Strings.productDetailSelectionMenuQuantity,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#f89f84'),
                          ),
                        ),
                        GeneralText(
                          Strings.productDetailSelectionMenuAmount,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#909094'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GeneralText(
                      menuListItems[index].name ?? "",
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                          fontSize: 14,
                          color: HexColor.fromHex('#ffffff'),
                          fontWeight: FontWeight.w400),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
          ],
        )
        /* GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: 7,
              crossAxisSpacing: 5,
              // mainAxisExtent: 67,
            ),
            itemCount: menuListItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 14, end: 14),
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#212129"),
                    borderRadius: BorderRadius.circular(11)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GeneralText(
                          Strings.productDetailSelectionMenuQuantity,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#f89f84'),
                          ),
                        ),
                        GeneralText(
                          Strings.productDetailSelectionMenuAmount,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#909094'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: GeneralText(
                        menuListItems[index].name ?? "",
                        style: appTheme.typographies.interFontFamily.headline2
                            .copyWith(
                                fontSize: 14,
                                color: HexColor.fromHex('#ffffff'),
                                fontWeight: FontWeight.w400),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              );
            }),*/
      ],
    );
  }

  Widget foodieInfo(IAppThemeData appTheme) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: HexColor.fromHex('#f1c452'),
                width: 16,
                height: 1,
              ),
              const SizedBox(
                width: 7.2,
              ),
              GeneralText(
                Strings.foodieInfoLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.only(
                top: 19.1, bottom: 26.6, start: 16.5, end: 74.5),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#4b4b52"),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Container(
                          width: 14,
                          height: 18.8,
                          child: Image.asset(
                              "assets/images/icons/foodie_icon.png")),
                      SizedBox(
                        width: 13.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.foodieInfoProfession,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: HexColor.fromHex('#909094'),
                            ),
                          ),
                          GeneralText(
                            Strings.foodieInfoProfessionValue,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#ffffff'),
                            ),
                          ),
                        ],
                      )
                    ]),
                    Container(
                      color: HexColor.fromHex("#ffffff").withOpacity(0.3),
                      width: 1,
                      height: 28,
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Container(
                          width: 18,
                          height: 20,
                          child: Image.asset(
                              "assets/images/icons/group_icon.png")),
                      SizedBox(
                        width: 13.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.foodieInfoAgeLabel,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: HexColor.fromHex('#909094'),
                            ),
                          ),
                          GeneralText(
                            Strings.foodieInfoAgeValue,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#ffffff'),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ],
                ),
                SizedBox(
                  height: 24.2,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(
                      width: 14,
                      height: 18.8,
                      child:
                      Image.asset("assets/images/icons/foodie_icon.png")),
                  SizedBox(
                    width: 13.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralText(
                        Strings.foodieInfoMobileLabel,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: HexColor.fromHex('#909094'),
                        ),
                      ),
                      GeneralText(
                        Strings.foodieInfoMobileValue,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 14,
                          color: HexColor.fromHex('#ffffff'),
                        ),
                      ),
                    ],
                  )
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget productPriceInformation(IAppThemeData appTheme) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: HexColor.fromHex('#f1c452'),
                width: 16,
                height: 1,
              ),
              const SizedBox(
                width: 7.5,
              ),
              GeneralText(
                Strings.productDetailPriceLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.only(
                top: 22, bottom: 22, start: 23, end: 23),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#4b4b52"),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GeneralText(
                        Strings.productDetailPriceValue,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                            fontSize: 36,
                            color: HexColor.fromHex('#f89f84'),
                            fontWeight: FontWeight.w300),
                      ),
                      GeneralText(
                        Strings.productDetailPriceTotal,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 15,
                          color: HexColor.fromHex('#ffffff'),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 18.1,
                ),
                Container(
                  color: HexColor.fromHex("#ffffff").withOpacity(0.3),
                  width: double.infinity,
                  height: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralText(
                      Strings.productDetailPriceTax,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                    GeneralText(
                      Strings.productDetailPriceTaxValue,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GeneralText(
                          Strings.productDetailAdvancePayment,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 15,
                            color: HexColor.fromHex('#8ea659'),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          // padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor.fromHex('#8ea659'),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    GeneralText(
                      Strings.foodItemAdvancePaymentValue,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#8ea659'),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget declineReason(IAppThemeData appTheme) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: HexColor.fromHex('#f1c452'),
                width: 16,
                height: 1,
              ),
              const SizedBox(
                width: 7.5,
              ),
              GeneralText(
                Strings.foodieProfileDeclineReasonLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.only(
                top: 33, bottom: 33, start: 24, end: 24),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#bb3127"),
                borderRadius: BorderRadius.circular(15)),
            child: GeneralText(
              Strings.foodieProfileDeclineReasonValue,
              style: appTheme.typographies.interFontFamily.headline6
                  .copyWith(
                  fontSize: 14,
                  color: HexColor.fromHex('#ffffff'),
                  fontWeight: FontWeight.w400),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget getAcceptButton({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 159,
      title: Strings.foodieProfileStartBtn.toUpperCase(),
      styleType: ButtonStyleType.fill,

      /*    onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderHistoryScreen()));
      },*/
    );
    // ExtoText(
    //   Strings.getStartedButtonTitle,
    //   style: appTheme.typographies.interFontFamily.headline2,
    // );
  }

  Widget getDeclineCash({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 150,
      title: Strings.foodieProfileCancelBtn.toUpperCase(),
      styleType: ButtonStyleType.fill,
/*      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OrderHistoryScreen()));
      },*/
    );
    // ExtoText(
    //   Strings.getStartedButtonTitle,
    //   style: appTheme.typographies.interFontFamily.headline2,
    // );
  }
}

class CustomModel {
  String? name;
  String? icon;
  String? foodCategory;

  CustomModel({this.name, this.icon, this.foodCategory});
}
