import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/experience/schedule_screen_v.dart';
import 'package:flutter/services.dart';

import '../../../../helpers/color_helper.dart';
import '../../../helpers/menu_helper.dart';
import '../../../setup.dart';

import '../../../models/dish/dish_response.dart' as dish;
import '../../../models/meal/meal_response.dart' as meal;

import 'dart:developer' as developer;

import '../../../ui_kit/helpers/dialog_helper.dart';
import '../../../ui_kit/widgets/general_text_dialog.dart';
import '../component/menu_experience_screen_vm.dart';

class MenuManager extends StatefulWidget {
  const MenuManager({
    required meal.MealResponse mealResponse,
    required dish.DishList dishResponse,
    required MenuExperienceScreenViewModel viewModel,
    Key? key,
  })  : _mealResponse = mealResponse,
        _dishResponse = dishResponse,
        _viewModel = viewModel,
         super(key: key);

  final meal.MealResponse _mealResponse;
  final dish.DishList _dishResponse;
  final MenuExperienceScreenViewModel _viewModel;


  @override
  _MenuManagerState createState() => _MenuManagerState();
}

class _MenuManagerState extends State<MenuManager> {
  final _appService = locateService<ApplicationService>();
  MenuHelper menuHelper = MenuHelper();

  final mealItems = <String>[];
  final foodItems = <String>[];

  final mealMap = {};
  final dishMap = {};
  MenuTab selectedMenuTab = MenuTab.create;
  List<MenuHelperModel> menuList=[];
  @override
  void initState() {
    loadItems();
    _appService.updateMenuHelper(menuHelper);

    developer.log(' Experience price in menu section is '
        '${_appService.state.experienceHelper!.priceExperience}');
    if ((_appService.state.experienceHelper!.priceExperience) != null) {
      if (_appService.state.experienceHelper!.priceExperience == 0.00001) {
        widget._viewModel.priceController.text = "0.0";
        menuHelper.givenPrice = 0.0;
        widget._viewModel.isEnable = true;
      } else {
        menuHelper.givenPrice =
            (_appService.state.experienceHelper!.priceExperience)!;
        widget._viewModel.priceController.text =
            (_appService.state.experienceHelper!.priceExperience)!.toString();
      }
    }

    if ((_appService.state.experienceHelper!.personExperience) != null) {
      widget._viewModel.servingController.text =
          (_appService.state.experienceHelper!.personExperience)!.toString();
      menuHelper.dishServingNoOfPerson =
          (_appService.state.experienceHelper!.personExperience)!;
    }

    super.initState();
  }

  void loadItems() {
    for (int i = 0; i < widget._mealResponse.t.length; i++) {
      mealItems.add(widget._mealResponse.t[i].name);
      mealMap[widget._mealResponse.t[i].name] = widget._mealResponse.t[i].id;
      if (i == 0) {
        menuHelper.selectedMealId = mealMap[widget._mealResponse.t[i].name];
      }
    }

    for (int i = 0; i < widget._dishResponse.t.length; i++) {
      foodItems.add(widget._dishResponse.t[i].name);

      dishMap[widget._dishResponse.t[i].name] = widget._dishResponse.t[i].id;

      if (i == 0) {
        menuHelper.selectedDishId = dishMap[widget._dishResponse.t[i].name];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 218,
            width: double.infinity,
            child: Image.asset(Resources.expHeaderBGPNG),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 29),
            child: GeneralText(
              Strings.menuExperienceTitle,
              textAlign: TextAlign.start,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 18,
          ),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    changeTab(MenuTab.create);
                  },
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xff3A3A44),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GeneralText(
                          'CREATE',
                          style: selectedMenuTab == MenuTab.create
                              ? appTheme.typographies.interFontFamily.headline4
                                  .copyWith(
                                      color: Color(0xfff1c452),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800)
                              : appTheme.typographies.interFontFamily.headline4
                                  .copyWith(
                                      color: Color(0xff9d9da2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                            width: 15,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // radius of 10
                              color: selectedMenuTab == MenuTab.create
                                  ? const Color(0xfff1c452)
                                  : Colors.transparent,
                              // green as background color
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    changeTab(MenuTab.view);
                  },
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xff484851),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GeneralText(
                              'VIEW',
                              style: selectedMenuTab == MenuTab.view
                                  ? appTheme
                                      .typographies.interFontFamily.headline4
                                      .copyWith(
                                          color: Color(0xfff1c452),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)
                                  : appTheme
                                      .typographies.interFontFamily.headline4
                                      .copyWith(
                                          color: Color(0xff9d9da2),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            if(menuList.isNotEmpty)
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: GeneralText(
                                  menuList.length.toString(),
                                  style: appTheme
                                      .typographies.interFontFamily.headline4
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(10), // radius of 10
                                  color: Color(0xff909094),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                            width: 15,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // radius of 10
                              color: selectedMenuTab == MenuTab.view
                                  ? Color(0xfff1c452)
                                  : Colors.transparent,
                              // green as background color
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          if(selectedMenuTab==MenuTab.view&&  menuList.isNotEmpty)...[

            getMenuView(),

          ]
          else if (selectedMenuTab==MenuTab.create)...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 29),
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 19),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: const Color(0xff34343B),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralText(
                              Strings.menuExperienceMealTitle,
                              textAlign: TextAlign.center,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                  color: const Color(0xfffbeccb),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralDropdown(
                              name: 'Select',
                              initialValue: '',
                              hintWidget: const Text(
                                'Select an option',
                                style: TextStyle(color: Colors.white),
                              ),
                              items: mealItems,
                              borderColor: appTheme.colors.textFieldBorderColor,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              onChange: ({
                                required String key,
                                required dynamic value,
                              }) {
                                menuHelper.selectedMealId = mealMap[value];
                                menuHelper.selectedBaseMealNameCategory = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralText(
                              Strings.menuExperienceFoodTitle,
                              textAlign: TextAlign.center,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                  color: const Color(0xfffbeccb),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralDropdown(
                              name: 'Select',
                              initialValue: '',
                              hintWidget: const Text(
                                'Select an option',
                                style: TextStyle(color: Colors.white),
                              ),
                              items: foodItems,
                              borderColor: appTheme.colors.textFieldBorderColor,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              onChange: ({
                                required String key,
                                required dynamic value,
                              }) {
                                developer.log(' Dish Map key is ' '$key');
                                developer.log(' Dish Map value is ' '$value');
                                menuHelper.selectedDishId = dishMap[value];
                                menuHelper.selectedBaseDishName = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  GeneralText(
                    Strings.menuExperienceDishTitle,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: appTheme.typographies.interFontFamily.headline4
                        .copyWith(
                        color: const Color(0xfffbeccb),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  GeneralTextInput(
                      height: 51,
                      controller: widget._viewModel.dishController,
                      inputType: InputType.text,
                      backgroundColor: appTheme.colors.textFieldFilledColor,
                      inputBorder: appTheme.focusedBorder,
                      valueStyle: const TextStyle(color: Colors.white),
                      hint: 'Enter your dish',
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.4), fontSize: 14),
                      // valueStyle: valueStyle,
                      onChanged: (newValue) {
                        // _appService.state.experienceHelper!.dishName = newValue;

                        menuHelper.selectedDishName = newValue;
                      }),
                  const SizedBox(
                    height: 26,
                  ),
                  GeneralText(
                    Strings.menuExperienceDescriptionTitle,
                    textAlign: TextAlign.center,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                        color: const Color(0xfffbeccb),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GeneralTextInput(
                      height: 80,
                      controller: widget._viewModel.descriptionController,
                      inputType: InputType.text,
                      isMultiline: true,
                      backgroundColor: appTheme.colors.textFieldFilledColor,
                      inputBorder: appTheme.focusedBorder,
                      valueStyle: const TextStyle(color: Colors.white),
                      hint: 'Enter your dish description',
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.4), fontSize: 14),
                      // valueStyle: valueStyle,
                      onChanged: (newValue) {
                        // _appService.state.experienceHelper!.dishDescription =
                        //     newValue;

                        menuHelper.givenDescription = newValue.trim();
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralText(
                              Strings.menuExperiencePriceTitle,
                              textAlign: TextAlign.center,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                  color: const Color(0xfffbeccb),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralTextInput(
                                height: 51,
                                controller: widget._viewModel.priceController,
                                inputType: InputType.digit,
                                isEnable: widget._viewModel.isEnable,
                                backgroundColor:
                                appTheme.colors.textFieldFilledColor,
                                inputBorder: appTheme.focusedBorder,
                                valueStyle: const TextStyle(color: Colors.white),
                                hint: 'Enter price',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 14),
                                // valueStyle: valueStyle,
                                onChanged: (newValue) {
                                  // _appService.state.experienceHelper!
                                  //     .dishPrice = double.parse(newValue);

                                  menuHelper.givenPrice = double.parse(newValue);
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GeneralText(
                              Strings.menuExperienceServingTitle,
                              textAlign: TextAlign.center,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                  color: const Color(0xfffbeccb),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneralTextInput(
                                height: 51,
                                controller: widget._viewModel.servingController,
                                inputType: InputType.digit,
                                isEnable: false,
                                backgroundColor:
                                appTheme.colors.textFieldFilledColor,
                                inputBorder: appTheme.focusedBorder,
                                valueStyle: const TextStyle(color: Colors.white),
                                hint: '2',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 14),
                                // valueStyle: valueStyle,
                                onChanged: (newValue) {
                                  // _appService.state.experienceHelper!
                                  //         .dishServingNoOfPerson =
                                  //     int.parse(newValue);

                                  menuHelper.dishServingNoOfPerson =
                                      int.parse(newValue);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  GeneralText(
                    Strings.menuExperiencePictureTitle,
                    textAlign: TextAlign.center,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                        color: const Color(0xfffbeccb),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 51,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xfff1c452),
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GeneralText(
                          Strings.menuExperienceUploadPictureTitle,
                          textAlign: TextAlign.center,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        Image.asset(
                          Resources.expUploadImagePNG,
                          height: 23,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           /* Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     widget._viewModel.saveMenu(context);
                  //     //  clearEntries();
                  //   },
                  //   child: GeneralText(
                  //     Strings.menuSave.toUpperCase(),
                  //     textAlign: TextAlign.start,
                  //     style: appTheme.typographies.interFontFamily.headline4
                  //         .copyWith(
                  //             color: const Color(0xffbb3127),
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // const Spacer(),
                *//*  GeneralText(
                    Strings.menuExperienceAddMoreTitle.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: appTheme.typographies.interFontFamily.headline4
                        .copyWith(
                        color: const Color(0xffbb3127),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),*//*
                  const SizedBox(
                    width: 5,
                  ),
                 *//* InkWell(
                    onTap: () {
                      //  clearEntries();

                      DialogHelper.confirmationDialog(
                        context: context,
                        onConfirm: () {
                          developer.log(' Yes please save this ');
                          // SystemNavigator.pop();
                          widget._viewModel.saveMenu(context);
                          Navigator.pop(context);
                        },
                        onDeny: () {
                          developer.log(' No please dont save ');
                          Navigator.pop(context);
                        },

                        // title: 'Save',
                        // body: const Text(
                        //   'Do you want to save this ',
                        // ),
                        // body: CheckListAttachmentsView(
                        //   checkList: widget._checkList,
                        //   fieldId: (widget.innerItem?.id)!,
                        //   itemAttachmentSuccessful: () {
                        //     setState(() {});
                        //   },
                        // ),
                        // barrierLabel: 'Test',
                        // isDismissible: true,
                        // maxHeight: MediaQuery.of(context).size.height * 0.6,
                      );

                      // showTextDialog(context,
                      //     title: Strings.editTitle,
                      //     value: 'Are you sure you want to save');
                    },
                    child: Image.asset(
                      Resources.expPlusPNG,
                      height: 74,
                    ),
                  )*//*
                ],
              ),
            ),*/

            const SizedBox(height: 24,),
            _saveButtonTitle(appTheme: appTheme),
          ],

          const SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
///todo need to adjust this function
  // void performEditMenu(FoodListModel foodMenuModel) {
  //   setState(() {
  //     // foodMenuModel.enableEdit = !foodMenuModel.enableEdit;
  //   });
  //   if (!foodMenuModel.enableEdit) {
  //     widget._experienceMenuDetailsScreenViewModel.updateExperienceMenu(
  //         foodTitle: foodMenuModel.foodTitleController!.text,
  //         foodSubtitle: foodMenuModel.foodSubTitleController!.text,
  //         foodDescription: foodMenuModel.foodDescriptionController!.text,
  //         foodMenuModel: foodMenuModel.foodMenuModel,
  //         price: int.parse(_price));
  //   }
  //
  //   print(foodMenuModel.foodTitleController!.text);
  //   print(foodMenuModel.foodSubTitleController!.text);
  //   print(foodMenuModel.foodDescriptionController!.text);
  // }
  Widget _saveButtonTitle({required IAppThemeData appTheme}) {
    return Center(
      child: GeneralButton.button(
        width: 180,
        title: Strings.menuScreenSaveButtonTitle.toUpperCase(),
        styleType: ButtonStyleType.fill,
        onTap: () {

          if(menuHelper.selectedDishName.isNotEmpty&&menuHelper.selectedDishName.isNotEmpty){
menuList.add(MenuHelperModel(
    dishName: menuHelper.selectedDishName,
    description: menuHelper.givenDescription,
    foodCategory: menuHelper.selectedBaseDishName));
setState(() {

});
Toaster.infoToast(context: context, message: 'You can now view your data in view tab',)
;

          }

          DialogHelper.confirmationDialog(
            context: context,
            onConfirm: () {
              developer.log(' Yes please save this ');
              // SystemNavigator.pop();
              widget._viewModel.saveMenu(context);
              Navigator.pop(context);
            },
            onDeny: () {
              developer.log(' No please dont save ');
              Navigator.pop(context);
            },

            // title: 'Save',
            // body: const Text(
            //   'Do you want to save this ',
            // ),
            // body: CheckListAttachmentsView(
            //   checkList: widget._checkList,
            //   fieldId: (widget.innerItem?.id)!,
            //   itemAttachmentSuccessful: () {
            //     setState(() {});
            //   },
            // ),
            // barrierLabel: 'Test',
            // isDismissible: true,
            // maxHeight: MediaQuery.of(context).size.height * 0.6,
          );


          // Navigator.push(
          //   context,
          //   // MaterialPageRoute(builder: (context) => const FoodDetailScreen()),
          //   MaterialPageRoute(builder: (context) => CreateExperienceScreen()),
          // );
          //    viewModel.goToForgotPasswordScreen();
        },
      ),
    );
  }
  Widget getMenuView() {
    final appTheme = AppTheme.of(context).theme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      padding: const EdgeInsetsDirectional.only(
          start: 9.9, end: 18.3, bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: HexColor.fromHex('#f1c452'))),
      child:
      ListView.separated
        (
          itemCount:menuList.length,
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var item =menuList.elementAt(index);
            return Column(
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
                          padding: const EdgeInsetsDirectional.all(16),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                getFoodItemTitle(
                                    appTheme: appTheme, itemTitle:item.foodCategory),
                               Spacer(),
                                InkWell(
                                  onTap: () {

                              setState(() {
                                menuList.clear();
                              });
                                  },
                                  child: Image.asset(
                                    Resources.expDeleteIconPNG,
                                    height: 17,
                                  ),
                                ),
SizedBox(width: 14,),
                                InkWell(
                                  onTap: () {
                                    // performEditMenu(
                                    //     foodMenuListItems[index]);
                                  },
                                  child: Image.asset(
                                    Resources.expEditPenPNG,
                                    height: 17,
                                  ),
                                )
                                // getFoodItemAmount(appTheme: appTheme),
                              ],
                            ),
                            getFoodItemSubTitle(
                                appTheme: appTheme, subItemTitle: item.dishName),
                            getFoodItemDescription(
                                appTheme: appTheme,
                                foodDescription: item.description),
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
                            numberOfUserServed: '3',
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
                ]);
          }, separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1.5,
              color:  HexColor.fromHex('#f7dc99'),
            );
      },
      ),


    );
  }

  void clearEntries() {
    widget._viewModel.descriptionController.clear();
    widget._viewModel.dishController.clear();
    widget._viewModel.priceController.clear();
    widget._viewModel.servingController.clear();
  }

  void changeTab(MenuTab menuTab) {
    setState(() {
      selectedMenuTab = menuTab;
    });
  }
}

Widget getFoodItemTitle(
    {required IAppThemeData appTheme,
    // required FoodListModel foodListModel,
    required String itemTitle}) {
  return GeneralText(
    itemTitle,
    // 'here',
    style: appTheme.typographies.interFontFamily.headline6
        .copyWith(fontSize: 15, color: HexColor.fromHex('#f7dc99')),
  );
}

Widget getFoodItemSubTitle(
    {required IAppThemeData appTheme,
    // required FoodListModel foodListModel,
    required String subItemTitle}) {
  return GeneralText(
    //   Strings.foodProductSubTitle,
    subItemTitle,
    style: appTheme.typographies.interFontFamily.headline6
        .copyWith(fontSize: 15, color: HexColor.fromHex('#b0c18b')),
  );
}

Widget getFoodItemDescription(
    {required IAppThemeData appTheme,
    // required FoodListModel foodListModel,
    required String foodDescription}) {
  return GeneralText(
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

class ChipsWidget extends StatelessWidget {
  const ChipsWidget({
    Key? key,
    required this.appTheme,
    required this.title,
    this.selected = false,
    this.widthContainer = 130,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final String title;
  final bool selected;
  final double widthContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        // width: widthContainer,
        child: GeneralText(
          title.capitalize(),
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: selected ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appTheme.colors.textFieldBorderColor,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          color: selected
              ? appTheme.colors.textFieldBorderColor
              : Colors.transparent,
        ));
  }
}
class MenuHelperModel{
  final String dishName;
  final String description;
  final String foodCategory;

  MenuHelperModel({required this.dishName, required this.description, required this.foodCategory});
}
class SocialMediaHandles {
  String? socialMediaName;
  String? socialMediaIcon;

  SocialMediaHandles({this.socialMediaIcon, this.socialMediaName});
}

enum MenuTab { create, view }
