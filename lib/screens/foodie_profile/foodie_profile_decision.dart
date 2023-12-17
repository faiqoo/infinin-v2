import 'dart:ui';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../models/booking/order_detail_response.dart';
import '../../setup.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../home/home_page/home_screen_v.dart';
import 'component/foodie_profile_decision_screen_vm.dart';
import 'foodie_profile_booking_confirmed.dart';

import 'dart:developer' as developer;

class FoodieProfileRequiredPending extends StatefulWidget {
  FoodieProfileRequiredPending(
      {required FoodieProfileDecisionScreenViewModel
          foodieProfileDecisionScreenViewModel,
      required OrderDetails orderDetails,
      Key? key})
      : _foodieProfileDecisionScreenViewModel =
            foodieProfileDecisionScreenViewModel,
        _orderDetails = orderDetails,
        super(key: key);
  FoodieProfileDecisionScreenViewModel _foodieProfileDecisionScreenViewModel;
  OrderDetails _orderDetails;

  @override
  State<FoodieProfileRequiredPending> createState() =>
      _FoodieProfileRequiredPendingState();
}

class _FoodieProfileRequiredPendingState
    extends State<FoodieProfileRequiredPending> {
  List<CustomModel> wowFactorsList = [];
  List<CustomModel> menuListItems = [];
  bool checkValue = false;
  final _appService = locateService<ApplicationService>();
  final _navigation = locateService<INavigationService>();
  final TextController _orderIDController = TextController();
  dynamic group1Value;

  @override
  void initState() {
    // TODO: implement initState
    // menuListItems.addAll([
    //   CustomModel(name: "Sindhi Biryani"),
    //   CustomModel(name: "Buritto"),
    //   CustomModel(name: "Vegetable Salad"),
    //   CustomModel(name: "Hyderabadi Rice"),
    //   CustomModel(name: "Soft Drinks"),
    // ]);

    developer.log(' Base Url is ' + '${_appService.state.baseUrl}');
    loadMenu();
    loadWowFactor();

    super.initState();
  }

  void loadMenu() {
    for (var i = 0; i < widget._orderDetails.t.experienceMenu.length; i++) {
      menuListItems.add(
        CustomModel(
            foodCategory: widget._orderDetails.t.experienceMenu[i].mealName,
            name: widget._orderDetails.t.experienceMenu[i].dish,
            icon: "assets/images/icons/garden.png"),
      );
    }
  }

  void loadWowFactor() {
    for (var i = 0;
        i < widget._orderDetails.t.experience.experienceWowFactors.length;
        i++) {
      wowFactorsList.add(CustomModel(
        foodCategory: Strings.foodieProfileFoodCategoryLabel,
        //   foodCategory: widget._orderDetails.t.experience.experienceWowFactors[i]
        //       .,
        name: widget
            ._orderDetails.t.experience.experienceWowFactors[i].wowFactorName,
        icon: Api.imageUrl +
            "" +
            widget._orderDetails.t.experience.experienceWowFactors[i]
                .wowFactorIconPath, // Strings.productDetailWowFactorGarden,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: widget._orderDetails.t.bookingStatus ==
                  Strings.requestedNew.toLowerCase()
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getAcceptButton(appTheme: appTheme),
                    getDeclineCash(appTheme: appTheme),
                  ],
                )
              : widget._orderDetails.t.bookingStatus ==
                      Strings.inProgressForSwitch
                  ? getBillButton(appTheme: appTheme)
                  : widget._orderDetails.t.bookingStatus ==
                          Strings.confirmedStatus.toLowerCase()
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            getStartButton(appTheme: appTheme),
                            getCancelButton(appTheme: appTheme),
                          ],
                        )
                      : Container(),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  color: HexColor.fromHex("#212129"),
                  child: Column(
                    children: [
                      Container(
                        height: 209,
                        padding: const EdgeInsetsDirectional.only(start: 29),
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
                                    const SizedBox(
                                      height: 90,
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color:
                                                  HexColor.fromHex("#ffffff"),
                                              width: 2)),
                                      child: Image.asset(
                                          "assets/images/icons/foodie_profile.png"),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    GeneralText(
                                      widget._orderDetails.t.brandName,
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                        fontSize: 18,
                                        color: HexColor.fromHex('#f1c452'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                  color: HexColor.fromHex(
                                                      '#f1c452')),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.9,
                                    ),
                                  ]),
                            ),
                            Positioned.fill(
                              bottom: -15,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: HexColor.fromHex("#b0c18b"),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: GeneralText(
                                    widget._orderDetails.t.bookingStatus
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
                        padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
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
                              padding: const EdgeInsetsDirectional.only(
                                  start: 22.5, top: 30, bottom: 30),
                              child: GeneralText(
                                // Strings.foodieProfileExperienceValue,
                                widget._orderDetails.t.experienceName,
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
                        height: 189,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget wowFactors(IAppThemeData appTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
          top: 16.9, bottom: 16.9, start: 38, end: 19.5),
      decoration: BoxDecoration(
          color: HexColor.fromHex("#4b4b52"),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 12, right: 18.5),

              // child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: wowFactorsList.length,
              //     padding: EdgeInsets.zero,
              //     itemBuilder: (BuildContext context, int index) {
              child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 22,
                children: [
                  for (var item in wowFactorsList)
                    getWowFactorDisplay(appTheme, item),
                  // ListView.builder(
                  //     physics: const BouncingScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: 3,
                  //     padding: EdgeInsets.zero,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return getWowFactorDisplay();
                  //     }),

                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 7.7),
                  //   child: Container(
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         GeneralText(
                  //           wowFactorsList[1].foodCategory ?? "",
                  //           style: appTheme
                  //               .typographies.interFontFamily.headline6
                  //               .copyWith(
                  //             fontSize: 16,
                  //             color: HexColor.fromHex('#f1c452'),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 58,
                  //           height: 63.3,
                  //           padding: const EdgeInsetsDirectional.all(10),
                  //           decoration: BoxDecoration(
                  //             image: const DecorationImage(
                  //               image: AssetImage(
                  //                   'assets/images/icons/food_item_circle.png'),
                  //               fit: BoxFit.fill,
                  //             ),
                  //             shape: BoxShape.circle,
                  //           ),
                  //           child: Container(
                  //             padding: const EdgeInsetsDirectional.all(10),
                  //             decoration: BoxDecoration(
                  //               color: HexColor.fromHex("#f1c452"),
                  //               shape: BoxShape.circle,
                  //             ),
                  //             child: Image.asset(
                  //                 wowFactorsList[1].icon != null
                  //                     ? wowFactorsList[1].icon ?? ""
                  //                     : ''),
                  //           ),
                  //         ),
                  //         GeneralText(
                  //           wowFactorsList[1].name ?? "",
                  //           style: appTheme
                  //               .typographies.interFontFamily.headline6
                  //               .copyWith(
                  //             fontSize: 14,
                  //             color: HexColor.fromHex('#ffffff'),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              )
              //  }),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(bottom: 7.7),
              //       child: Container(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             GeneralText(
              //               wowFactorsList[2].foodCategory ?? "",
              //               style: appTheme.typographies.interFontFamily.headline6
              //                   .copyWith(
              //                 fontSize: 16,
              //                 color: HexColor.fromHex('#f1c452'),
              //               ),
              //             ),
              //             Container(
              //               width: 58,
              //               height: 63.3,
              //               padding: const EdgeInsetsDirectional.all(10),
              //               decoration: BoxDecoration(
              //                 image: const DecorationImage(
              //                   image: AssetImage(
              //                       'assets/images/icons/food_item_circle.png'),
              //                   fit: BoxFit.fill,
              //                 ),
              //                 shape: BoxShape.circle,
              //               ),
              //               child: Container(
              //                 padding: const EdgeInsetsDirectional.all(10),
              //                 decoration: BoxDecoration(
              //                   color: HexColor.fromHex("#f1c452"),
              //                   shape: BoxShape.circle,
              //                 ),
              //                 child: Image.asset(wowFactorsList[2].icon != null
              //                     ? wowFactorsList[2].icon ?? ""
              //                     : ''),
              //               ),
              //             ),
              //             GeneralText(
              //               wowFactorsList[2].name ?? "",
              //               style: appTheme.typographies.interFontFamily.headline6
              //                   .copyWith(
              //                 fontSize: 14,
              //                 color: HexColor.fromHex('#ffffff'),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Row(
              //       children: [
              //         Column(
              //           children: [
              //             GeneralText(
              //               wowFactorsList[3].foodCategory ?? "",
              //               style: appTheme.typographies.interFontFamily.headline6
              //                   .copyWith(
              //                 fontSize: 16,
              //                 color: HexColor.fromHex('#f1c452'),
              //               ),
              //             ),
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(bottom: 7.7),
              //                   child: Container(
              //                     child: Column(
              //                       children: [
              //                         Container(
              //                           width: 58,
              //                           height: 63.3,
              //                           padding:
              //                               const EdgeInsetsDirectional.all(10),
              //                           decoration: BoxDecoration(
              //                             image: const DecorationImage(
              //                               image: AssetImage(
              //                                   'assets/images/icons/food_item_circle.png'),
              //                               fit: BoxFit.fill,
              //                             ),
              //                             shape: BoxShape.circle,
              //                           ),
              //                           child: Container(
              //                             padding:
              //                                 const EdgeInsetsDirectional.all(10),
              //                             decoration: BoxDecoration(
              //                               color: HexColor.fromHex("#f1c452"),
              //                               shape: BoxShape.circle,
              //                             ),
              //                             child: Image.asset(
              //                                 wowFactorsList[3].icon != null
              //                                     ? wowFactorsList[3].icon ?? ""
              //                                     : ''),
              //                           ),
              //                         ),
              //                         GeneralText(
              //                           wowFactorsList[3].name ?? "",
              //                           style: appTheme
              //                               .typographies.interFontFamily.headline6
              //                               .copyWith(
              //                             fontSize: 14,
              //                             color: HexColor.fromHex('#ffffff'),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 11.4,
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(bottom: 7.7),
              //                   child: Container(
              //                     child: Column(
              //                       children: [
              //                         Container(
              //                           width: 58,
              //                           height: 63.3,
              //                           padding:
              //                               const EdgeInsetsDirectional.all(10),
              //                           decoration: BoxDecoration(
              //                             image: const DecorationImage(
              //                               image: AssetImage(
              //                                   'assets/images/icons/food_item_circle.png'),
              //                               fit: BoxFit.fill,
              //                             ),
              //                             shape: BoxShape.circle,
              //                           ),
              //                           child: Container(
              //                             padding:
              //                                 const EdgeInsetsDirectional.all(10),
              //                             decoration: BoxDecoration(
              //                               color: HexColor.fromHex("#f1c452"),
              //                               shape: BoxShape.circle,
              //                             ),
              //                             child: Image.asset(
              //                                 wowFactorsList[3].icon != null
              //                                     ? wowFactorsList[3].icon ?? ""
              //                                     : ''),
              //                           ),
              //                         ),
              //                         GeneralText(
              //                           wowFactorsList[3].name ?? "",
              //                           style: appTheme
              //                               .typographies.interFontFamily.headline6
              //                               .copyWith(
              //                             fontSize: 14,
              //                             color: HexColor.fromHex('#ffffff'),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             )
              //           ],
              //         )
              //       ],
              //     )
              //   ],
              // ),
              )
        ],
      ),
    );
  }

  Widget wowFactorsBackup(IAppThemeData appTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
          top: 16.9, bottom: 16.9, start: 38, end: 19.5),
      decoration: BoxDecoration(
          color: HexColor.fromHex("#4b4b52"),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 18.5),

            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: wowFactorsList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ListView.builder(
                      //     physics: const BouncingScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: 3,
                      //     padding: EdgeInsets.zero,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return getWowFactorDisplay();
                      //     }),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GeneralText(
                              wowFactorsList[index].foodCategory ?? "",
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 16,
                                color: HexColor.fromHex('#f1c452'),
                              ),
                            ),
                            Container(
                              width: 58,
                              height: 63.3,
                              padding: const EdgeInsetsDirectional.all(10),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
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
                                child: Image.asset(
                                    wowFactorsList[index].icon != null
                                        ? wowFactorsList[index].icon ?? ""
                                        : ''),
                              ),
                            ),
                            GeneralText(
                              // wowFactorsList[0].name ?? "",
                              wowFactorsList[index].name ?? "",
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
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 7.7),
                      //   child: Container(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         GeneralText(
                      //           wowFactorsList[1].foodCategory ?? "",
                      //           style: appTheme
                      //               .typographies.interFontFamily.headline6
                      //               .copyWith(
                      //             fontSize: 16,
                      //             color: HexColor.fromHex('#f1c452'),
                      //           ),
                      //         ),
                      //         Container(
                      //           width: 58,
                      //           height: 63.3,
                      //           padding: const EdgeInsetsDirectional.all(10),
                      //           decoration: BoxDecoration(
                      //             image: const DecorationImage(
                      //               image: AssetImage(
                      //                   'assets/images/icons/food_item_circle.png'),
                      //               fit: BoxFit.fill,
                      //             ),
                      //             shape: BoxShape.circle,
                      //           ),
                      //           child: Container(
                      //             padding: const EdgeInsetsDirectional.all(10),
                      //             decoration: BoxDecoration(
                      //               color: HexColor.fromHex("#f1c452"),
                      //               shape: BoxShape.circle,
                      //             ),
                      //             child: Image.asset(
                      //                 wowFactorsList[1].icon != null
                      //                     ? wowFactorsList[1].icon ?? ""
                      //                     : ''),
                      //           ),
                      //         ),
                      //         GeneralText(
                      //           wowFactorsList[1].name ?? "",
                      //           style: appTheme
                      //               .typographies.interFontFamily.headline6
                      //               .copyWith(
                      //             fontSize: 14,
                      //             color: HexColor.fromHex('#ffffff'),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                }),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(bottom: 7.7),
            //       child: Container(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             GeneralText(
            //               wowFactorsList[2].foodCategory ?? "",
            //               style: appTheme.typographies.interFontFamily.headline6
            //                   .copyWith(
            //                 fontSize: 16,
            //                 color: HexColor.fromHex('#f1c452'),
            //               ),
            //             ),
            //             Container(
            //               width: 58,
            //               height: 63.3,
            //               padding: const EdgeInsetsDirectional.all(10),
            //               decoration: BoxDecoration(
            //                 image: const DecorationImage(
            //                   image: AssetImage(
            //                       'assets/images/icons/food_item_circle.png'),
            //                   fit: BoxFit.fill,
            //                 ),
            //                 shape: BoxShape.circle,
            //               ),
            //               child: Container(
            //                 padding: const EdgeInsetsDirectional.all(10),
            //                 decoration: BoxDecoration(
            //                   color: HexColor.fromHex("#f1c452"),
            //                   shape: BoxShape.circle,
            //                 ),
            //                 child: Image.asset(wowFactorsList[2].icon != null
            //                     ? wowFactorsList[2].icon ?? ""
            //                     : ''),
            //               ),
            //             ),
            //             GeneralText(
            //               wowFactorsList[2].name ?? "",
            //               style: appTheme.typographies.interFontFamily.headline6
            //                   .copyWith(
            //                 fontSize: 14,
            //                 color: HexColor.fromHex('#ffffff'),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Row(
            //       children: [
            //         Column(
            //           children: [
            //             GeneralText(
            //               wowFactorsList[3].foodCategory ?? "",
            //               style: appTheme.typographies.interFontFamily.headline6
            //                   .copyWith(
            //                 fontSize: 16,
            //                 color: HexColor.fromHex('#f1c452'),
            //               ),
            //             ),
            //             Row(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.only(bottom: 7.7),
            //                   child: Container(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           width: 58,
            //                           height: 63.3,
            //                           padding:
            //                               const EdgeInsetsDirectional.all(10),
            //                           decoration: BoxDecoration(
            //                             image: const DecorationImage(
            //                               image: AssetImage(
            //                                   'assets/images/icons/food_item_circle.png'),
            //                               fit: BoxFit.fill,
            //                             ),
            //                             shape: BoxShape.circle,
            //                           ),
            //                           child: Container(
            //                             padding:
            //                                 const EdgeInsetsDirectional.all(10),
            //                             decoration: BoxDecoration(
            //                               color: HexColor.fromHex("#f1c452"),
            //                               shape: BoxShape.circle,
            //                             ),
            //                             child: Image.asset(
            //                                 wowFactorsList[3].icon != null
            //                                     ? wowFactorsList[3].icon ?? ""
            //                                     : ''),
            //                           ),
            //                         ),
            //                         GeneralText(
            //                           wowFactorsList[3].name ?? "",
            //                           style: appTheme
            //                               .typographies.interFontFamily.headline6
            //                               .copyWith(
            //                             fontSize: 14,
            //                             color: HexColor.fromHex('#ffffff'),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 11.4,
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(bottom: 7.7),
            //                   child: Container(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           width: 58,
            //                           height: 63.3,
            //                           padding:
            //                               const EdgeInsetsDirectional.all(10),
            //                           decoration: BoxDecoration(
            //                             image: const DecorationImage(
            //                               image: AssetImage(
            //                                   'assets/images/icons/food_item_circle.png'),
            //                               fit: BoxFit.fill,
            //                             ),
            //                             shape: BoxShape.circle,
            //                           ),
            //                           child: Container(
            //                             padding:
            //                                 const EdgeInsetsDirectional.all(10),
            //                             decoration: BoxDecoration(
            //                               color: HexColor.fromHex("#f1c452"),
            //                               shape: BoxShape.circle,
            //                             ),
            //                             child: Image.asset(
            //                                 wowFactorsList[3].icon != null
            //                                     ? wowFactorsList[3].icon ?? ""
            //                                     : ''),
            //                           ),
            //                         ),
            //                         GeneralText(
            //                           wowFactorsList[3].name ?? "",
            //                           style: appTheme
            //                               .typographies.interFontFamily.headline6
            //                               .copyWith(
            //                             fontSize: 14,
            //                             color: HexColor.fromHex('#ffffff'),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             )
            //           ],
            //         )
            //       ],
            //     )
            //   ],
            // ),
          )
        ],
      ),
    );
  }

  Widget getWowFactorDisplay(appTheme, CustomModel customModel) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GeneralText(
            customModel.foodCategory ?? "",
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 16.0,
              color: HexColor.fromHex('#f1c452'),
            ),
          ),
          Container(
            width: 58,
            height: 63.3,
            padding: const EdgeInsetsDirectional.all(10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/icons/food_item_circle.png'),
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
              child: customModel.icon != null
                  ? SvgPicture.network(customModel.icon!)
                  : Image.asset(""),
              // child: Image.asset(
              //     customModel.icon != null ? customModel.icon ?? "" : ''),
            ),
          ),
          GeneralText(
            // wowFactorsList[0].name ?? "",
            customModel.name ?? "",
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 14.0,
              color: HexColor.fromHex('#ffffff'),
            ),
          ),
        ],
      ),
    );
  }

  Widget foodProductDetails(IAppThemeData appTheme) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.only(
              top: 22, bottom: 29, start: 10, end: 10),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#4b4b52"),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
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
                            // Strings.productDetailSelectionDate,
                            widget._foodieProfileDecisionScreenViewModel
                                .getDayAndMonth(widget
                                    ._orderDetails.t.scheduleScheduledDate),
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#ea7458'),
                            ),
                          ),
                          GeneralText(
                            //  Strings.productDetailSelectionTime,
                            InfininHelpers.getAmPm(
                                widget._orderDetails.t.scheduleStartTime),
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
                            //    Strings.productDetailSelectionType,
                            widget._orderDetails.t.preferenceName,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#8ea659'),
                            ),
                          ),
                          GeneralText(
                            // Strings.productDetailSelectionTotalPersons,
                            widget._orderDetails.t.persons,
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
              const SizedBox(
                height: 29,
              ),
              productRelatedNotes(appTheme),
              const SizedBox(
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
        const SizedBox(
          height: 4,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.only(
              top: 15, bottom: 15, start: 14, end: 14),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#212129"),
              borderRadius: BorderRadius.circular(11)),
          child: GeneralText(
            //   Strings.productDetailSelectionNotes,
            widget._orderDetails.t.comments,
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
        const SizedBox(
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
                margin: const EdgeInsets.only(right: 5, bottom: 7),
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
                        widget._orderDetails.t.experience.priceTypeId == 2
                            ? GeneralText(
                                Strings.productDetailSelectionMenuAmount,
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  fontSize: 16,
                                  color: HexColor.fromHex('#909094'),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(
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
      padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
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
          const SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(
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
                      const SizedBox(
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
                            // Strings.foodieInfoProfessionValue,
                            widget._orderDetails.t.foodieProfession,
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
                      const SizedBox(
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
                            //Strings.foodieInfoAgeValue,
                            widget._orderDetails.t.foodieAge,
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
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget productPriceInformation(IAppThemeData appTheme) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
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
          const SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(
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
                        //   Strings.productDetailPriceValue,
                        "Rs. " + widget._orderDetails.t.totalPrice.toString(),
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
                const SizedBox(
                  height: 18.1,
                ),
                Container(
                  color: HexColor.fromHex("#ffffff").withOpacity(0.3),
                  width: double.infinity,
                  height: 1,
                ),
                const SizedBox(
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
                      //     Strings.productDetailPriceTaxValue,
                      "Rs " +
                          (widget._orderDetails.t.totalPrice * 0.17).toString(),
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
                        const SizedBox(
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
                          child: const Center(
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
                      //  Strings.foodItemAdvancePaymentValue,
                      "Rs " +
                          (widget._orderDetails.t.totalPrice * 0.20).toString(),
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

  Widget getAcceptButton({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 159,
      title: Strings.foodieProfileAcceptBtn.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        widget._foodieProfileDecisionScreenViewModel.sendAcceptRequest();
        // sendAcceptRequest
        _showCashReceivedPopup(context);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => FoodieProfileBookingConfirmed()));
      },
    );
    // ExtoText(
    //   Strings.getStartedButtonTitle,
    //   style: appTheme.typographies.interFontFamily.headline2,
    // );
  }

  Widget getDeclineCash({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 150,
      title: Strings.foodieProfileDeclineBtn.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        widget._foodieProfileDecisionScreenViewModel.sendDeclineRequest();
        _navigation.navigateTo(route: HomeRouteView());
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => OrderHistoryScreen()));
      },
    );
    // ExtoText(
    //   Strings.getStartedButtonTitle,
    //   style: appTheme.typographies.interFontFamily.headline2,
    // );
  }

  Widget getStartButton({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 159,
      title: Strings.foodieProfileStartBtn.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        _showFoodieVerificationPopup(context);
      },
    );
  }

  Widget getCancelButton({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 150,
      title: Strings.foodieProfileCancelBtn.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        _showBottomSheet(context);
      },
    );

  }

  Widget getBillButton({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 181,
      title: Strings.billGenerate,
      styleType: ButtonStyleType.fill,
      onTap: () {
        widget._foodieProfileDecisionScreenViewModel
            .loadBilledDetails(id: widget._orderDetails.t.id);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => FoodieProfileBookingConfirmed()));
      },
    );
  }

  _showBottomSheet(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.showBottomSheetDialog(
      borderRadius: 20,
      context: context,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsetsDirectional.only(
            start: 25,
            end: 28,
            top: 41,
          ),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#212129"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              GeneralText(
                Strings.bottomSheetTellUsWhyTitle,
                maxLines: 2,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 17,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(children: [
                  Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return HexColor.fromHex("#fbeccb");
                            }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 0,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                              color: HexColor.fromHex("#fbeccb"),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return HexColor.fromHex("#fbeccb");
                            }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 1,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                              color: HexColor.fromHex("#fbeccb"),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return HexColor.fromHex("#fbeccb");
                            }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 2,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                              color: HexColor.fromHex("#fbeccb"),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return HexColor.fromHex("#fbeccb");
                            }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 3,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            color: HexColor.fromHex("#fbeccb"),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 42,
              ),
              GeneralButton.button(
                title: Strings.generalButtonTitle.toUpperCase(),
                styleType: ButtonStyleType.fill,
                width: 151,
                onTap: () {
                  _navigation.navigateTo(route: HomeRouteView());
                  // Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<dynamic> _showFoodieVerificationPopup(BuildContext context) async {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.show(
      context: context,
      // dialogType: GeneralComponentStyle.success,
      isDismissible: false,
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
              height: 20,
            ),
            Image.asset(Resources.reviewCheckPNG,height: 63,),
            const SizedBox(
              height: 16,
            ),
            GeneralText(
              Strings.foodieVerificationPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xfff1c452),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 29,
            ),
            GeneralText(
              Strings.foodieVerificationSubPopupTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),

            const SizedBox(
              height: 33,
            ),

            GeneralTextInput(
                height: 80,
                controller: _orderIDController,
                inputType: InputType.digit,
                backgroundColor:
                appTheme.colors.textFieldFilledColor,
                inputBorder: appTheme.focusedBorder,
                valueStyle: const TextStyle(color: Colors.white),
                hint: 'Enter Order ID',
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14),
                // valueStyle: valueStyle,
                onChanged: (newValue) {}),
            const SizedBox(
              height: 48,
            ),

            GeneralButton.button(
              title: Strings.foodieVerificationPopupBtnTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
                // Navigator.pop(context);
                Map<String, dynamic> orderData = jsonDecode(widget._foodieProfileDecisionScreenViewModel.orderQR);
                int verificationCode = orderData['verificationCode'];
                if( verificationCode.toString()== _orderIDController.text ){
                  // Navigator.pop(context);
                  _showFoodieVerifiedPopup(context);
                  _orderIDController.clear();
                } else {
                  // Navigator.pop(context);
                  _orderIDController.clear();
                  Toaster.warningToast(context: context, message: "Invalid code");
                }
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

  Future<dynamic> _showFoodieVerifiedPopup(BuildContext context) async {
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
              height: 20,
            ),
            Image.asset(Resources.reviewCheckPNG,height: 63,),
            const SizedBox(
              height: 16,
            ),
            GeneralText(
              Strings.foodieVerifiedPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xff8ea659),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 29,
            ),
            GeneralText(
              Strings.foodieVerifiedSubPopupTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),

            const SizedBox(
              height: 29,
            ),
            GeneralButton.button(
              title: Strings.foodieVerifiedPopupBtnTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
                widget._foodieProfileDecisionScreenViewModel.processOrder(widget._foodieProfileDecisionScreenViewModel.orderQR, context);
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


  Future<dynamic> _showCashReceivedPopup(BuildContext context) async {
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
              height: 20,
            ),
            Image.asset(
              Resources.reviewCheckPNG,
              height: 63,
            ),
            const SizedBox(
              height: 16,
            ),
            GeneralText(
              Strings.orderPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xff8ea659),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 29,
            ),
            GeneralText(
              Strings.orderSubPopupTitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 29,
            ),
            GeneralButton.button(
              title: Strings.orderPopupBtnTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
                _navigation.navigateTo(route: HomeRouteView());
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

class CustomModel {
  String? name;
  String? icon;
  String? foodCategory;

  CustomModel({this.name, this.icon, this.foodCategory});
}
