import 'dart:ui';

import 'package:chef/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/resources.dart';
import '../../../constants/strings.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/function_helper.dart';
import '../../../models/experience/schedule_list_display.dart';
import '../../../models/home/food_details_menu_model.dart' as fdm;
import '../../../theme/app_theme_data/app_theme_data.dart';
import '../../../theme/app_theme_widget.dart';
import '../../../ui_kit/widgets/general_button.dart';
import '../../../ui_kit/widgets/general_dropdown.dart';
import '../../../ui_kit/widgets/general_new_appbar.dart';
import '../../../ui_kit/widgets/general_text.dart';
import '../../../ui_kit/widgets/general_text_input.dart';
import '../../user_account/user_profile.dart';
import '../../../models/home/experience_list_response.dart' as experience_data;

import 'dart:developer' as developer;

import '../experience_menu_details/experience_menu_details_screen_vm.dart';

import '../../../models/home/food_details_menu_model.dart'
    as food_details_menu_model;

enum TabBars { details, menu, schedule, media }

class FoodDetailScreen extends StatefulWidget {
  // const FoodDetailScreen({Key? key}) : super(key: key);

  const FoodDetailScreen({
    required fdm.FoodMenuModel foodMenuModel,
    required experience_data.T experienceData,
    required ScheduleData scheduleData,
    required ExperienceMenuDetailsScreenViewModel
        experienceMenuDetailsScreenViewModel,
    Key? key,
  })  : _foodMenuModel = foodMenuModel,
        _experienceData = experienceData,
        _scheduleData = scheduleData,
        _experienceMenuDetailsScreenViewModel =
            experienceMenuDetailsScreenViewModel,
        super(key: key);

  final fdm.FoodMenuModel _foodMenuModel;
  final experience_data.T _experienceData;
  final ScheduleData _scheduleData;
  final ExperienceMenuDetailsScreenViewModel
      _experienceMenuDetailsScreenViewModel;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int foodItemQuantity = 0;
  String selectedDate = "13";
  String selectedDay = "MON";
  String selectedMonth = "OCT";
  String selectedTime = "10 AM";
  final TextController nOfPersons = TextController();
  final TextController notes = TextController();
  late List<DropdownMenuItem<String>> statusList = [];

  // late List<DropdownMenuItem<String>> items = [];

  final items = <String>[];

  final menuHeaderList = <String>[];

  bool scheduleForm = false;

  List<CustomModel> wowFactorsList = [];
  List<CustomModel> preferencesList = [];
  List<CustomModel> menuListItems = [];
  List<FoodListModel> foodMenuListItems = [];
  List<ScheduleModel> scheduleListItems = [];

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String _price = '';
  bool editPriceEnable = false;

  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    items.add('Scientist');
    items.add('Couple');
    items.add('Single');
    //_price =  widget._experienceData.price.toString();

    _price = widget._experienceData.price.toString();
    // _price = widget._foodMenuModel.t.elementAt(0).price.toString();
    loadMenuItems();
    loadWowFactor();
    loadPerferences();
    loadMenuHeader();
    loadFoodMenuList();
    loadScheduleDate();
    super.initState();
  }

  void loadMenuHeader() {
    for (int i = 0; i < widget._foodMenuModel.t.length; i++) {
      if (!menuHeaderList
          .contains(widget._foodMenuModel.t[i].mealName.trim())) {
        menuHeaderList.add(widget._foodMenuModel.t[i].mealName.trim());
      }
    }
  }

  void loadMenuItems() {
    developer.log(' Length of Menu is ' '${widget._foodMenuModel.t.length}');
    for (int i = 0; i < widget._foodMenuModel.t.length; i++) {
      menuListItems.addAll([
        CustomModel(name: widget._foodMenuModel.t[i].dish),
      ]);
    }
  }

  void loadWowFactor() {
    developer.log(
        ' Wow factors are ' '${widget._experienceData.experienceWowFactors}');
    var experienceWowFactor = widget._experienceData.experienceWowFactors;
    //
    for (int i = 0; i < experienceWowFactor.length; i++) {
      wowFactorsList.addAll([
        CustomModel(
            icon: experienceWowFactor[i].wowFactorName,
            name: experienceWowFactor[i].wowFactorIconPath),
      ]);
    }
  }

  void loadScheduleDate() {
    for (int i = 0; i < widget._scheduleData.t.daysGroups.length; i++) {
      scheduleListItems.add(ScheduleModel(
          scheduledDate: widget._scheduleData.t.daysGroups[i].scheduledDate));
    }
  }

  void loadPerferences() {
    developer.log(' load Perferences factors are '
        '${widget._experienceData.experiencePreferences}');
    var experiencePreferences = widget._experienceData.experiencePreferences;

    for (int i = 0; i < experiencePreferences.length; i++) {
      preferencesList.addAll([
        CustomModel(
            icon: experiencePreferences[i].preferenceName,
            name: experiencePreferences[i].preferenceIconPath),
      ]);
    }
  }

  void loadFoodMenuList() {
    for (int i = 0; i < widget._foodMenuModel.t.length; i++) {
      foodMenuListItems.add(FoodListModel(
          enableEdit: false,
          foodMenuModel: widget._foodMenuModel.t[i],
          foodTitleController: TextEditingController(text: widget._foodMenuModel.t[i].mealName),
          foodSubTitleController: TextEditingController(text: widget._foodMenuModel.t[i].baseDishName),
          foodDescriptionController: TextEditingController(text: widget._foodMenuModel.t[i].description)));
    }
  }

  addQuantity() {
    if (foodItemQuantity != null && foodItemQuantity.toString().isNotEmpty) {
      setState(() {
        foodItemQuantity++;
      });
    }
  }

  removeQuantity() {
    if (foodItemQuantity != null && foodItemQuantity > 0) {
      setState(() {
        foodItemQuantity--;
      });
    }
  }

  TabBars selectedTab = TabBars.details;

  updateTabView(TabBars tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: HexColor.fromHex('#212129'),
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset('assets/images/icons/food_detail_bg.png',
                  fit: BoxFit.fill),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(start: 24),
                    color: HexColor.fromHex('#212129'),
                    child: Column(
                      children: [
                        if (selectedTab != TabBars.schedule)
                          const SizedBox(
                            height: 60,
                          ),
                        if (selectedTab == TabBars.schedule)
                          const SizedBox(
                            height: 40,
                          ),
                        if (selectedTab == TabBars.menu) ...[
                          displayMenuHeader(
                            appTheme,
                          ),
                        ],
                        const SizedBox(
                          height: 15,
                        ),
                        if (selectedTab == TabBars.details)
                          detailsTabViewForm(context, appTheme),
                        if (selectedTab == TabBars.schedule)
                          scheduleTabView(context, appTheme),
                        if (selectedTab == TabBars.media)
                          mediaTabViewForm(context, appTheme)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Positioned.fill(
            top: 70,
            left: 20,
            child: Align(
                alignment: Alignment.topLeft,
                child: GeneralNewAppBar(
                  rightIcon: Resources.homeIconSvg,
                )),
          ),
          Positioned(
            top: 140,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 25),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: HexColor.fromHex("#4b4b52"),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      height: 118,
                      padding: const EdgeInsetsDirectional.only(bottom: 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.only(end: 14, top: 30),
                        child: Column(children: [
                          getFoodMainHeading(appTheme: appTheme),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 36, end: 36),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Column(
                                    children: [
                                      GeneralText(
                                        Strings.foodItemDetails,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: selectedTab ==
                                                        TabBars.details
                                                    ? FontWeight.bold
                                                    : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: 9,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: selectedTab ==
                                                    TabBars.details
                                                ? HexColor.fromHex('#f1c452')
                                                : Colors.transparent,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    updateTabView(TabBars.details);
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    updateTabView(TabBars.menu);
                                  },
                                  child: Column(
                                    children: [
                                      GeneralText(
                                        Strings.foodItemMenu,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight:
                                                    selectedTab == TabBars.menu
                                                        ? FontWeight.bold
                                                        : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: 9,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: selectedTab == TabBars.menu
                                                ? HexColor.fromHex('#f1c452')
                                                : Colors.transparent,
                                            shape: BoxShape.circle),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    updateTabView(TabBars.schedule);
                                  },
                                  child: Column(
                                    children: [
                                      GeneralText(
                                        Strings.foodItemSchedule,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: selectedTab ==
                                                        TabBars.schedule
                                                    ? FontWeight.bold
                                                    : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: 9,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: selectedTab ==
                                                    TabBars.schedule
                                                ? HexColor.fromHex('#f1c452')
                                                : Colors.transparent,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    updateTabView(TabBars.media);
                                  },
                                  child: Column(
                                    children: [
                                      GeneralText(
                                        Strings.foodItemMedia,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight:
                                                    selectedTab == TabBars.media
                                                        ? FontWeight.bold
                                                        : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: 9,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: selectedTab == TabBars.media
                                                ? HexColor.fromHex('#f1c452')
                                                : Colors.transparent,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )),
                  if (selectedTab == TabBars.menu ||
                      selectedTab == TabBars.details) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                              start: 25, end: 25, bottom: 10, top: 0),
                          decoration: BoxDecoration(
                              color: HexColor.fromHex("#8ea659"),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(40))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // InkWell(
                              //     onTap: () {
                              //       //performEditPrice();
                              //     },
                              //     child: Icon(
                              //       //  editPriceEnable ? Icons.check : Icons.edit,
                              //       Icons.edit,
                              //       color: Colors.white,
                              //       size: 20,
                              //     )
                              // ),
                              editPriceEnable
                                  ? SizedBox(
                                      height: 30,
                                      width: 90,
                                      child: TextField(
                                        controller: priceController,
                                        onChanged: (value) {},
                                        style: appTheme.typographies
                                            .interFontFamily.headline4
                                            .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: HexColor.fromHex(
                                                    '#ffffff')),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                      ),
                                    )
                                  : GeneralText(
                                      Strings.appCurrency + "." + " " + _price,
                                      style: appTheme.typographies
                                          .interFontFamily.headline4
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  HexColor.fromHex('#ffffff')),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: GeneralText(
                                  widget._experienceData.priceTypeId == 1
                                      ? 'per person'
                                      : "",
                                  style: appTheme
                                      .typographies.interFontFamily.headline4
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: HexColor.fromHex('#ffffff')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
          // if (selectedTab != TabBars.Details)
          // const Positioned.fill(
          //   top: 105,
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: CircleAvatar(
          //       backgroundColor: Colors.white,
          //       radius: 32,
          //       child: CircleAvatar(
          //         radius: 30,
          //         backgroundImage:
          //             AssetImage("assets/images/icons/user_image.png"),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget menuTabView(
      BuildContext context, IAppThemeData appTheme, String headerName) {
    //menuHeaderList();
    developer.log(' Header name is in Menu tab ' '${headerName}');
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12),
      child: Container(
          padding: const EdgeInsetsDirectional.only(
              start: 9.9, end: 18.3, bottom: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: HexColor.fromHex('#f1c452'))),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: foodMenuListItems.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return headerName.trim().toString().toLowerCase() ==
                        foodMenuListItems[index]
                            .foodMenuModel
                            .mealName
                            .toString()
                            .trim()
                            .toLowerCase()
                    ?
                Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            // displayMenuHeader(appTheme),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding:
                                        const EdgeInsetsDirectional.all(16),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/icons/food_item_circle.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/icons/food_item_sample.png',
                                      height: 50,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 7.7,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          getFoodItemTitle(
                                              appTheme: appTheme,
                                              foodListModel:
                                                  foodMenuListItems[index],
                                              itemTitle:
                                                  foodMenuListItems[index]
                                                      .foodMenuModel
                                                      .baseDishName),
                                          InkWell(
                                            onTap: () {
                                              performEditMenu(
                                                  foodMenuListItems[index]);
                                            },
                                            child: Image.asset(
                                              foodMenuListItems[index]
                                                      .enableEdit
                                                  ? Resources
                                                      .getSignUpLetsStartScreenTickPng
                                                  : Resources.expEditPenPNG,
                                              height: 17,
                                            ),
                                          )
                                          // getFoodItemAmount(appTheme: appTheme),
                                        ],
                                      ),
                                      getFoodItemSubTitle(
                                          appTheme: appTheme,
                                          foodListModel:
                                              foodMenuListItems[index],
                                          subItemTitle: foodMenuListItems[index]
                                              .foodMenuModel
                                              .dish),
                                      getFoodItemDescription(
                                          appTheme: appTheme,
                                          foodListModel:
                                              foodMenuListItems[index],
                                          foodDescription:
                                              foodMenuListItems[index]
                                                  .foodMenuModel
                                                  .description),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      Resources.userIcon,
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    //  getFoodItemUsers(appTheme: appTheme,numberOfUserServed:widget._foodMenuModel.t[index]. ),
                                    getFoodItemUsers(
                                      appTheme: appTheme,
                                      numberOfUserServed:
                                          widget._experienceData.persons,
                                    ),
                                  ],
                                ),
                                //Uncomment this when started handle the per Item price.
                                // getFoodItemAmount(
                                //     appTheme: appTheme,
                                //     itemPrice: widget._foodMenuModel.t[index].price
                                //         .toString()),
                              ],
                            ),
                            // SizedBox(
                            //   height: 23,
                            // ),
                            // if (index != 3)
                            //   Divider(
                            //     color: HexColor.fromHex('#f1c452'),
                            //     thickness: 1,
                            //   )
                          ])
                    : Container();
              })),
    );
  }

  Widget displayMenuHeader(
    appTheme,
  ) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: menuHeaderList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              getHeaderData(appTheme, menuHeaderList[index]),
              const SizedBox(
                height: 11,
              ),
              menuTabView(context, appTheme, menuHeaderList[index]),
              const SizedBox(
                height: 25,
              ),
            ],
          );
        });
    // return Column(
    //   children: List.generate(menuHeaderList.length,(index){
    //     return getHeaderData(appTheme,headerName);
    //    // return Text(menuHeaderList[index].toString());
    //   }),
    //   // children: [
    //   //   Row(
    //   //     children: [
    //   //       Container(
    //   //         color: HexColor.fromHex('#f1c452'),
    //   //         width: 16,
    //   //         height: 1,
    //   //       ),
    //   //       const SizedBox(
    //   //         width: 2,
    //   //       ),
    //   //       getFoodItemHeading(
    //   //         appTheme: appTheme,
    //   //         title: headerName,
    //   //         // title: Strings.foodDetailHeading,
    //   //       ),
    //   //     ],
    //   //   )
    //   // ],
    // );
    //return
  }

  Widget getHeaderData(appTheme, headerName) {
    return Row(
      children: [
        Container(
          color: HexColor.fromHex('#f1c452'),
          width: 16,
          height: 1,
        ),
        const SizedBox(
          width: 2,
        ),
        getFoodItemHeading(
          appTheme: appTheme,
          title: headerName,
          // title: Strings.foodDetailHeading,
        ),
      ],
    );
  }

  Widget getFoodItemHeading(
      {required IAppThemeData appTheme, required String title}) {
    return GeneralText(
      title,
      textAlign: TextAlign.center,
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          color: HexColor.fromHex('#f1c452'),
          fontSize: 20,
          fontWeight: FontWeight.w500),
    );
  }

  Widget getFoodItemTitle(
      {required IAppThemeData appTheme,
      required FoodListModel foodListModel,
      required String itemTitle}) {
    foodListModel.foodTitleController!.text = itemTitle;
    return foodListModel.enableEdit
        ? Container(
            height: 30,
            width: 90,
            child: TextField(
              controller: foodListModel.foodTitleController,
              onChanged: (value) {},
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
              ),
            ),
          )
        : GeneralText(
            itemTitle,
            // 'here',
            style: appTheme.typographies.interFontFamily.headline6
                .copyWith(fontSize: 15, color: HexColor.fromHex('#f7dc99')),
          );
  }

  Widget getFoodItemSubTitle(
      {required IAppThemeData appTheme,
      required FoodListModel foodListModel,
      required String subItemTitle}) {
    foodListModel.foodSubTitleController!.text = subItemTitle;
    return foodListModel.enableEdit
        ? Container(
            height: 30,
            width: 90,
            child: TextField(
              controller: foodListModel.foodSubTitleController,
              onChanged: (value) {},
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderSide:
                //   BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide:
                //   BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                // ),
              ),
            ),
          )
        : GeneralText(
            //   Strings.foodProductSubTitle,
            subItemTitle,
            style: appTheme.typographies.interFontFamily.headline6
                .copyWith(fontSize: 15, color: HexColor.fromHex('#b0c18b')),
          );
  }

  Widget getFoodItemAmount(
      {required IAppThemeData appTheme, required String itemPrice}) {
    return GeneralText(
      //  Strings.appCurrency + ". " + Strings.foodProductItemPrice,
      Strings.appCurrency + ". " + itemPrice,
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: HexColor.fromHex('#f1c452')),
    );
  }

  Widget getFoodItemDescription(
      {required IAppThemeData appTheme,
      required FoodListModel foodListModel,
      required String foodDescription}) {
    foodListModel.foodDescriptionController!.text = foodDescription;
    return foodListModel.enableEdit
        ? Container(
            height: 30,
            width: 90,
            child: TextField(
              controller: foodListModel.foodDescriptionController,
              onChanged: (value) {},
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 2.0),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderSide:
                //   BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide:
                //   BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                // ),
              ),
            ),
          )
        : GeneralText(
            //  Strings.foodProductItemDescription,
            foodDescription,
            maxLines: 3,
            textAlign: TextAlign.start,
            style: appTheme.typographies.interFontFamily.headline6
                .copyWith(fontSize: 14, color: HexColor.fromHex('#ffffff')),
          );
  }

  Widget getFoodItemUsers(
      {required IAppThemeData appTheme, String? numberOfUserServed}) {
    return GeneralText(
      // Strings.foodProductItemUsers,
      numberOfUserServed ?? Strings.foodProductItemUsers,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 16, color: HexColor.fromHex('#ffffff')),
    );
  }

  Widget getFoodItemQuantityLabel({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.foodProductItemQuantity + ":",
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: HexColor.fromHex('#f1c452'),
      ),
    );
  }

  Widget getFoodItemQuantityValue({required IAppThemeData appTheme}) {
    return GeneralText(
      (foodItemQuantity <= 9 && foodItemQuantity > 0)
          ? "0" + foodItemQuantity.toString()
          : foodItemQuantity.toString(),
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          fontSize: 15,
          color: foodItemQuantity.toString() == "0"
              ? HexColor.fromHex('#212129').withOpacity(0.4)
              : HexColor.fromHex('#212129')),
    );
  }

  Widget getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 151,
      title: Strings.nextButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile()),
        );
      },
    );
    // ExtoText(
    //   Strings.getStartedButtonTitle,
    //   style: appTheme.typographies.interFontFamily.headline2,
    // );
  }

  Widget getFoodMainHeading({required IAppThemeData appTheme}) {
    // return GeneralText(Strings.foodItemMainHeading,
    //     textAlign: TextAlign.center,
    //     style: appTheme.typographies.interFontFamily.headline6.copyWith(
    //         fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24));

    return GeneralText(widget._experienceData.title,
        textAlign: TextAlign.center,
        style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24));
  }

  ///Schedule tab view
  Widget scheduleTabView(BuildContext context, IAppThemeData appTheme) {
    return
        /*     scheduleForm
        ? Padding(
            padding: EdgeInsetsDirectional.only(start: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // GeneralRichText(title: 'Oct\n 13'),
                          GeneralText(
                            selectedMonth,
                            // style: appTheme
                            //     .typographies.interFontFamily.headline6
                            //     .copyWith(
                            //         color: HexColor.fromHex('#f1c452'),
                            //         fontSize: 14,
                            //         //  height: 0,
                            //         fontWeight: FontWeight.w800),
                            style:
                                appTheme.typographies.interFontFamily.label11,
                          ),
                          GeneralText(
                            selectedDate,
                            // style: appTheme
                            //     .typographies.interFontFamily.headline6
                            //     .copyWith(
                            //         color: HexColor.fromHex('#909094'),
                            //         fontSize: 40,
                            //         fontWeight: FontWeight.w500),

                            style:
                                appTheme.typographies.interFontFamily.label12,
                          )
                        ]),
                    SizedBox(
                      width: 27,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 14, top: 15, bottom: 15, end: 25),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex('#2b2b33'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GeneralText(selectedTime,
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#b0c18b'),
                                              fontSize: 36,
                                              fontWeight: FontWeight.normal)),
                                  GeneralText(selectedDay,
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#909094'),
                                              fontSize: 36,
                                              fontWeight: FontWeight.normal)),
                                ],
                              )),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 14, top: 15, bottom: 15, end: 25),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex('#2b2b33'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Wrap(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GeneralText(Strings.noOfPersonsLabel,
                                          style: appTheme.typographies
                                              .interFontFamily.headline6
                                              .copyWith(
                                                  color: HexColor.fromHex(
                                                      '#fee4a4'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 61,
                                            height: 51,
                                            decoration: BoxDecoration(
                                                color:
                                                    HexColor.fromHex('#2b2b33'),
                                                border: Border.all(
                                                    color: HexColor.fromHex(
                                                        '#f1c452')),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            // padding: EdgeInsetsDirectional.only(
                                            //     top: 8, bottom: 8, start: 16, end: 16),
                                            margin: EdgeInsetsDirectional.only(
                                                bottom: 8),
                                            child: noOfPersonsField(
                                              appTheme: appTheme,
                                              valueStyle: appTheme.typographies
                                                  .interFontFamily.body1
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              hintStyle: appTheme.typographies
                                                  .interFontFamily.body1
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.8,
                                            height: 51,
                                            decoration: BoxDecoration(
                                                color:
                                                    HexColor.fromHex('#2b2b33'),
                                                border: Border.all(
                                                    color: HexColor.fromHex(
                                                        '#f1c452')),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            margin: EdgeInsetsDirectional.only(
                                                bottom: 8),
                                            padding: EdgeInsetsDirectional.only(
                                                top: 8,
                                                bottom: 8,
                                                start: 8,
                                                end: 8),
                                            child: */ /*ExtoDropdown(
                                        name: _wfActions.first ?? "",
                                        items: _wfActions,
                                        // isMandatory: true,
                                        onChange: ({required key, value}) {},
                                      ),*/ /*
                                                GeneralDropdown(
                                              borderColor: Colors.transparent,
                                              name: 'Select',
                                              //     dropDownHeight: 51.0,

                                              // borderColor: appTheme.colors.textFieldBorderColor,
                                              style: appTheme.typographies
                                                  .interFontFamily.headline6
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                              // margin: 22.0,
                                              items: items,
                                              onChange: ({
                                                required String key,
                                                required dynamic value,
                                              }) {},
                                            ),
                                            */ /*GeneralDropdown(
                                          borderColor: Colors.transparent,
                                          name: 'Select',
                                          // margin: 22.0,
                                          items: statusList,
                                          onChange: ({
                                            required String key,
                                            required dynamic value,
                                          }) {
                                          },
                                        )*/ /*
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 14, top: 15, bottom: 15, end: 25),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex('#2b2b33'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Wrap(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GeneralText(Strings.notesLabel,
                                          style: appTheme.typographies
                                              .interFontFamily.headline6
                                              .copyWith(
                                                  color: HexColor.fromHex(
                                                      '#fee4a4'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Container(
                                        // width: 61,
                                        decoration: BoxDecoration(
                                            color: HexColor.fromHex('#2b2b33'),
                                            border: Border.all(
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // padding: EdgeInsetsDirectional.only(
                                        //     top: 8, bottom: 8, start: 16, end: 16),
                                        margin: EdgeInsetsDirectional.only(
                                            bottom: 8),
                                        child: notesField(
                                          appTheme: appTheme,
                                          valueStyle: appTheme.typographies
                                              .interFontFamily.body1
                                              .copyWith(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          hintStyle: appTheme.typographies
                                              .interFontFamily.body1
                                              .copyWith(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 160,
                ),
              ],
            ),
          )
        : */

        Stack(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20, bottom: 50),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // itemCount: widget._scheduleData.t.daysGroups.length, // 4,
              itemCount: scheduleListItems.length, // 4,
              itemBuilder: (BuildContext context, int index) {
                // var item = widget._scheduleData.t.daysGroups[index];
                var item = scheduleListItems[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        selectScheduleDate(context, item);
                      },
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            Resources.expEditPenPNG,
                            height: 20,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          //   scheduleForm = !scheduleForm;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            //   GeneralText(selectedDay.toUpperCase(),
                            GeneralText(dayOfMonth(item.scheduledDate),
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        color: HexColor.fromHex('#f1c452'),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                            GeneralText(
                                // selectedDate,
                                item.scheduledDate.day.toString(),
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  color: HexColor.fromHex('#909094'),
                                  fontSize: 40,
                                )),
                            Image.asset(
                              Resources.expRepeatIconPNG,
                              height: 15,
                            ),
                          ]),
                          const SizedBox(
                            width: 27,
                          ),
                          displayScheduleTime(
                              DateFormat.jm().format(item.scheduledDate)),
                          //displayScheduleTime(widget._scheduleData.t.daysGroups[index].hours),
                          // Expanded(
                          //   child: Container(
                          //     width: double.infinity,
                          //     padding:
                          //         EdgeInsets.only(left: 8, top: 10, bottom: 10),
                          //     decoration: BoxDecoration(
                          //         color: HexColor.fromHex('#2b2b33'),
                          //         borderRadius: const BorderRadius.only(
                          //             topLeft: Radius.circular(20),
                          //             bottomLeft: Radius.circular(20))),
                          //     child: Wrap(
                          //         children: [
                          //       timeSelectorBox(appTheme,
                          //           showSelectedTime: false),
                          //       SizedBox(
                          //         width: 7,
                          //       ),
                          //       timeSelectorBox(appTheme,
                          //           showSelectedTime: false),
                          //       SizedBox(
                          //         width: 7,
                          //       ),
                          //       timeSelectorBox(appTheme,
                          //           showSelectedTime: false),
                          //       SizedBox(
                          //         width: 7,
                          //       ),
                          //       timeSelectorBox(appTheme,
                          //           showSelectedTime: false),
                          //       SizedBox(
                          //         width: 7,
                          //       ),
                          //     ]),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                  ],
                );
              }),
        ),
        // Positioned.fill(
        //   right: 20,
        //   bottom: 40,
        //   child: Align(
        //     alignment: Alignment.bottomRight,
        //     child: FloatingActionButton(
        //       elevation: 6,
        //       onPressed: () {
        //         selectStartDate(context, appTheme);
        //       },
        //       child: Image.asset(
        //         Resources.calendarPNG,
        //         height: 23,
        //       ),
        //       backgroundColor: appTheme.colors.filledButtonColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget displayScheduleTime(
      //List<Hour> _hours,
      String date) {
    final appTheme = AppTheme.of(context).theme;
    return Expanded(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: HexColor.fromHex('#2b2b33'),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              // for (var i in _hours) //displayTimeData(i),
              timeSelectorBox(appTheme, date

                  //    i.startTime,
                  //     i,

                  //  false,
                  // showSelectedTime: _appService.state.orderHelper!.scheduleId ==
                  //     i.scheduleId.toString()
                  //     ? true
                  //     : false,
                  ),
              // const SizedBox(
              //   width: 7,
              // ),
            ],
          )),
    );
  }

  String dayOfMonth(DateTime _date) {
    var dateData = DateFormat('EEEE').format(_date);
    selectedMonth = months[_date.month - 1];

    return dateData.substring(0, 3);
  }

  Future<void> selectStartDate(
      BuildContext context, IAppThemeData appTheme) async {
    final DateTime? picked = await showDatePicker(
      context: context,

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: appTheme.colors.primaryBackground // <-- SEE HERE

                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      //lastDate: DateTime(2101),
      lastDate: DateTime.now(),
    );
  }

  Widget scheduleTabViewForm(BuildContext context, IAppThemeData appTheme) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                GeneralText(selectedMonth,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            color: HexColor.fromHex('#f1c452'),
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                GeneralText(selectedDate,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            color: HexColor.fromHex('#909094'),
                            fontSize: 40,
                            fontWeight: FontWeight.w700))
              ]),
              const SizedBox(
                width: 27,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(
                            start: 14, top: 15, bottom: 15, end: 25),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex('#2b2b33'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GeneralText(selectedTime,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        color: HexColor.fromHex('#b0c18b'),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w200)),
                            GeneralText(selectedDay,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        color: HexColor.fromHex('#909094'),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w200)),
                          ],
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(
                            start: 14, top: 15, bottom: 15, end: 25),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex('#2b2b33'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GeneralText(Strings.noOfPersonsLabel,
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                            color: HexColor.fromHex('#fee4a4'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                const SizedBox(
                                  height: 9,
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      width: 61,
                                      decoration: BoxDecoration(
                                          color: HexColor.fromHex('#2b2b33'),
                                          border: Border.all(
                                              color:
                                                  HexColor.fromHex('#f1c452')),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // padding: EdgeInsetsDirectional.only(
                                      //     top: 8, bottom: 8, start: 16, end: 16),
                                      margin: const EdgeInsetsDirectional.only(
                                          bottom: 8),
                                      child: noOfPersonsField(
                                        appTheme: appTheme,
                                        valueStyle: appTheme
                                            .typographies.interFontFamily.body1
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        hintStyle: appTheme
                                            .typographies.interFontFamily.body1
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      decoration: BoxDecoration(
                                          color: HexColor.fromHex('#2b2b33'),
                                          border: Border.all(
                                              color:
                                                  HexColor.fromHex('#f1c452')),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsetsDirectional.only(
                                          bottom: 8),
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 8, bottom: 8, start: 8, end: 8),
                                      child: GeneralDropdown(
                                        borderColor: Colors.transparent,
                                        name: 'Select',
                                        // margin: 22.0,
                                        items: items,
                                        onChange: ({
                                          required String key,
                                          required dynamic value,
                                        }) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(
                            start: 14, top: 15, bottom: 15, end: 25),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex('#2b2b33'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GeneralText(Strings.notesLabel,
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                            color: HexColor.fromHex('#fee4a4'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                const SizedBox(
                                  height: 9,
                                ),
                                Container(
                                  // width: 61,
                                  decoration: BoxDecoration(
                                      color: HexColor.fromHex('#2b2b33'),
                                      border: Border.all(
                                          color: HexColor.fromHex('#f1c452')),
                                      borderRadius: BorderRadius.circular(10)),
                                  // padding: EdgeInsetsDirectional.only(
                                  //     top: 8, bottom: 8, start: 16, end: 16),
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 8),
                                  child: notesField(
                                    appTheme: appTheme,
                                    valueStyle: appTheme
                                        .typographies.interFontFamily.body1
                                        .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintStyle: appTheme
                                        .typographies.interFontFamily.body1
                                        .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 27,
          ),
        ],
      ),
    );
  }

  Widget mediaTabViewForm(BuildContext context, IAppThemeData appTheme) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  color: HexColor.fromHex('#f1c452'),
                  width: 16,
                  height: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                GeneralText(
                  Strings.mediaPhotos,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 20,
                    color: HexColor.fromHex('#f1c452'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
              ],
            ),

            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Container(
                  color: HexColor.fromHex('#f1c452'),
                  width: 16,
                  height: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                GeneralText(
                  Strings.mediaVideos,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 20,
                    color: HexColor.fromHex('#f1c452'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
                _ImageCell(),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            //
          ],
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {},
                backgroundColor: const Color(0xffbb3127),
              ),
            ),
          ),
        )
      ],
    );
  }

  Stack _ImageCell() {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Image.asset(
              'assets/images/icons/food_detail_bg.png',
              height: 72,
            )),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffbb3127),
                  borderRadius: BorderRadius.only(
                    // topRight: Radius.circular(13.0),
                    bottomRight: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    // bottomLeft: Radius.circular(40.0)
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Image.asset(
                  Resources.expDeleteIconPNG,
                  height: 16,
                )),
          ),
        )
      ],
    );
  }

  Widget detailsTabViewForm(BuildContext context, IAppThemeData appTheme) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  color: HexColor.fromHex('#f1c452'),
                  width: 16,
                  height: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                GeneralText(
                  Strings.foodDetailAboutTitle,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 20,
                    color: HexColor.fromHex('#f1c452'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: GeneralText(
                // Strings.productDetailAboutSubTitle,
                widget._experienceData.description,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 14,
                    color: HexColor.fromHex('#ffffff'),
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Row(
              children: [
                Container(
                  color: HexColor.fromHex('#f1c452'),
                  width: 16,
                  height: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                GeneralText(
                  Strings.productDetailWowFactorTitle,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 20,
                    color: HexColor.fromHex('#f1c452'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            wowFactors(appTheme, wowFactorsList),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  color: HexColor.fromHex('#f1c452'),
                  width: 16,
                  height: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                GeneralText(
                  Strings.foodDetailPreferences,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 20,
                    color: HexColor.fromHex('#f1c452'),
                  ),
                ),
                // const Spacer(),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: wowFactors(appTheme, preferencesList),
                ),
                Container(
                  height: 166,
                  width: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    children: [
                      GeneralText(
                        widget._experienceData.persons,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 47,
                          color: HexColor.fromHex('#b0c18b'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Resources.userIconPNG,
                            height: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5.7,
                          ),
                          GeneralText(
                            "Persons",
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   width: 12,
                // ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Container(
                  color: HexColor.fromHex('#f1c452'),
                  width: 16,
                  height: 1,
                ),
                const SizedBox(
                  width: 5,
                ),
                GeneralText(
                  Strings.foodDetailLocation,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 20,
                    color: HexColor.fromHex('#f1c452'),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GeneralText(
                // 'House # 11, Street # 65 F-11/4, Islamabad',
                widget._experienceData.chefAddress,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(
              height: 22,
            ),

            widget._experienceData.subHostName.isNotEmpty
                ? Row(
                    children: [
                      Container(
                        color: HexColor.fromHex('#f1c452'),
                        width: 16,
                        height: 1,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GeneralText(
                        Strings.foodDetailSubHost,
                        // widget._experienceData.subHostName,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 20,
                          color: HexColor.fromHex('#f1c452'),
                        ),
                      ),
                    ],
                  )
                : Container(),

            widget._experienceData.subHostName.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        GeneralText(
                          widget._experienceData.subHostName,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        GeneralText(
                          widget._experienceData.subHostMobileNo,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),

            const SizedBox(
              height: 60,
            ),

            //
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment(0.9,0.8),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xffbb3127),
              child: Image.asset(
                Resources.expEditPenPNG,
                height: 20,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget wowFactors(IAppThemeData appTheme, List<CustomModel> items) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Wrap(
        children: [
          for (int i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 7.7),
              child: Column(
                children: [
                  Container(
                    width: 68,
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
                        height: 50,
                        padding: const EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#f1c452"),
                          shape: BoxShape.circle,
                        ),
                        // child: Image.asset(
                        //     items[i].name != null ? items[i].name ?? "" : ''),
                        child: items[i].name != null
                            ? SvgPicture.network(
                                FunctionHelper.getValidUrlForImages(
                                    items[i].name!))
                            : Container()
                        // items[i].name != null ? items[i].name ?? "" : ''),
                        ),
                  ),
                  GeneralText(
                    items[i].icon ?? "",
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 14,
                      color: HexColor.fromHex('#ffffff'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget timeSelectorBox(IAppThemeData appTheme, String displayTime,
      //Hour _hour,
      {bool showSelectedTime = false}) {
    var finalDate = '';
    finalDate = displayTime; //InfininHelpers.getAmPm(displayTime);
    return Padding(
        padding: const EdgeInsets.only(right: 7),
        child: Container(
          // width: 71,
          // height: 36,

          child: GeneralText(finalDate,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  color: showSelectedTime
                      ? HexColor.fromHex('#212129')
                      : HexColor.fromHex('#f1c452'),
                  fontSize: 14)),
          decoration: BoxDecoration(
              border: Border.all(color: HexColor.fromHex('#f1c452')),
              color: showSelectedTime
                  ? HexColor.fromHex('#f1c452')
                  : HexColor.fromHex('#2b2b33'),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsetsDirectional.only(
              top: 8, bottom: 8, start: 16, end: 16),
          //padding: const EdgeInsets.only(right: 7, left: 7),
          margin: const EdgeInsetsDirectional.only(
            bottom: 8,
          ),
        ));
  }

  // Widget timeSelectorBox(IAppThemeData appTheme,
  //     {bool showSelectedTime = false}) {
  //   return Container(
  //     // width: 71,
  //     // height: 36,
  //     child: GeneralText(selectedTime,
  //         style: appTheme.typographies.interFontFamily.headline6.copyWith(
  //             color: showSelectedTime
  //                 ? HexColor.fromHex('#212129')
  //                 : HexColor.fromHex('#f1c452'),
  //             fontSize: 14)),
  //     decoration: BoxDecoration(
  //         border: Border.all(color: HexColor.fromHex('#f1c452')),
  //         color: showSelectedTime
  //             ? HexColor.fromHex('#f1c452')
  //             : HexColor.fromHex('#2b2b33'),
  //         borderRadius: BorderRadius.circular(10)),
  //     padding:
  //         EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 16, end: 16),
  //     margin: EdgeInsetsDirectional.only(bottom: 8),
  //   );
  // }

  Widget noOfPersonsField({
    required IAppThemeData appTheme,
    required TextStyle valueStyle,
    required TextStyle hintStyle,
  }) {
    return GeneralTextInput(
      contentPadding: const EdgeInsetsDirectional.only(
          top: 8, bottom: 8, start: 16, end: 16),
      controller: nOfPersons,
      hint: Strings.noOfPersonsHint,
      valueStyle: valueStyle,
      hintStyle: hintStyle,
      validator: (_) {
        return null;
      },
      onChanged: (newValue) {
        setState(() {
          nOfPersons.text = newValue;
        });
      },
    );
  }

  Widget notesField({
    required IAppThemeData appTheme,
    required TextStyle valueStyle,
    required TextStyle hintStyle,
  }) {
    return GeneralTextInput(
      isMultiline: true,
      contentPadding: const EdgeInsetsDirectional.only(
          top: 8, bottom: 8, start: 16, end: 16),
      controller: notes,
      hint: Strings.notesHint,
      valueStyle: valueStyle,
      hintStyle: hintStyle,
      validator: (_) {
        return null;
      },
      onChanged: (newValue) {
        setState(() {
          notes.text = newValue;
        });
      },
    );
  }

  Future<void> selectScheduleDate(
      BuildContext context, ScheduleModel scheduleModel) async {
    final appTheme = AppTheme.of(context).theme;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: appTheme.colors.primaryBackground // <-- SEE HERE

                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      print(picked.toString());
      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedTime != null) {
        var _selectedDateTime = DateTime(picked.year, picked.month, picked.day,
            pickedTime.hour, pickedTime.minute);
        setState(() {
          scheduleModel.scheduledDate = _selectedDateTime;
        });
        final selectedDateTime =
            SelectedDateTime.fromDateTime(_selectedDateTime);

        String date = (selectedDateTime.dateTime.toString().substring(0, 10));
        String time = (selectedDateTime.dateTime.toString().substring(11, 16));

        String dayString = DateFormat.E().format(picked); //

        String timeString = DateFormat('h a').format(
            DateTime(picked.year, picked.month, picked.day, pickedTime.hour));

        String dateOfMonthString = DateFormat.d().format(picked);

        widget._experienceMenuDetailsScreenViewModel.updateScheduleData(
            scheduleModel: scheduleModel,
            //foodMenuModel.
            completion: () {
              setState(() {});
            });

        print(dayString);
        print(timeString);
        print(dateOfMonthString);

        // widget.scheduleScreenViewModel?.setDayValue(dayString.toUpperCase());
        // widget.scheduleScreenViewModel?.setTimeValue(
        //     widget.scheduleScreenViewModel!.convertTo24HourFormat(timeString));
        // String pickedDate = picked.toString().substring(0, 10);
        // widget.scheduleScreenViewModel?.datePicked = pickedDate;
        //
        // if (widget.scheduleScreenViewModel!.scheduleList.isNotEmpty) {
        //   var dateTimeAlreadyExist = false;
        //   var matchedIndex = 0;
        //   for (int i = 0;
        //   i < widget.scheduleScreenViewModel!.scheduleList.length;
        //   i++) {
        //     var element = widget.scheduleScreenViewModel!.scheduleList[i];
        //     if (element.dayOfWeek == dayString &&
        //         element.dateOfMonth == dateOfMonthString) {
        //       dateTimeAlreadyExist = true;
        //       matchedIndex = i;
        //     }
        //   }
        //   if (dateTimeAlreadyExist) {
        //     var timeAlreadyExist = false;
        //     widget.scheduleScreenViewModel?.scheduleList[matchedIndex]
        //         .timeInHourAndAmPm
        //         .forEach((element) {
        //       if (element == timeString) {
        //         timeAlreadyExist = true;
        //       }
        //     });
        //     if (!timeAlreadyExist) {
        //       widget.scheduleScreenViewModel?.sendScheduleData(completion: () {
        //         widget.scheduleScreenViewModel?.scheduleList[matchedIndex]
        //             .timeInHourAndAmPm
        //             .add(timeString);
        //       });
        //       setState(() {});
        //     }
        //   } else {
        //     widget.scheduleScreenViewModel?.sendScheduleData(completion: () {
        //       widget.scheduleScreenViewModel?.scheduleList.add(Schedule(
        //           date: date,
        //           time: time,
        //           dayOfWeek: dayString,
        //           dateOfMonth: dateOfMonthString,
        //           timeInHourAndAmPm: [timeString]));
        //     });
        //     setState(() {});
        //   }
        //   return;
        // } else {
        //   widget.scheduleScreenViewModel?.sendScheduleData(completion: () {
        //     widget.scheduleScreenViewModel?.scheduleList.add(Schedule(
        //         date: date,
        //         time: time,
        //         dayOfWeek: dayString,
        //         dateOfMonth: dateOfMonthString,
        //         timeInHourAndAmPm: [timeString]));
        //   });
        // }
        // print(widget.scheduleScreenViewModel?.scheduleList.length);
        // setState(() {});
      }
    }
  }

  void performEditMenu(FoodListModel foodMenuModel) {
    setState(() {
      foodMenuModel.enableEdit = !foodMenuModel.enableEdit;
    });
    if (!foodMenuModel.enableEdit) {
      widget._experienceMenuDetailsScreenViewModel.updateExperienceMenu(
          foodTitle: foodMenuModel.foodTitleController!.text,
          foodSubtitle: foodMenuModel.foodSubTitleController!.text,
          foodDescription: foodMenuModel.foodDescriptionController!.text,
          foodMenuModel: foodMenuModel.foodMenuModel,
          price: int.parse(_price));
    }

    print(foodMenuModel.foodTitleController!.text);
    print(foodMenuModel.foodSubTitleController!.text);
    print(foodMenuModel.foodDescriptionController!.text);
  }

  void performEditPrice() {
    setState(() {
      editPriceEnable = !editPriceEnable;

      if (!editPriceEnable) {
        _price = priceController.text;
      }
    });
  }
}

class CustomModel {
  String? name;
  String? icon;

  CustomModel({this.name, this.icon});
}

class SelectedDateTime {
  DateTime dateTime;
  String dayOfWeek;

  SelectedDateTime({required this.dateTime, required this.dayOfWeek});

  factory SelectedDateTime.fromDateTime(DateTime dateTime) {
    final daysOfWeek = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    final dayOfWeek = daysOfWeek[dateTime.weekday - 1];
    return SelectedDateTime(dateTime: dateTime, dayOfWeek: dayOfWeek);
  }
}

class FoodListModel {
  bool enableEdit = false;
  TextEditingController? foodTitleController;
  TextEditingController? foodSubTitleController;
  TextEditingController? foodDescriptionController;
  fdm.T foodMenuModel;
  FoodListModel({
    required this.enableEdit,
    required this.foodMenuModel,
    required this.foodTitleController,
    required this.foodSubTitleController,
    required this.foodDescriptionController,
  });
}

class ScheduleModel {
  DateTime scheduledDate;

  ScheduleModel({required this.scheduledDate});
}
