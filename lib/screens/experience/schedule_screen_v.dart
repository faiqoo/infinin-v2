import 'dart:math';

import 'package:chef/screens/experience/schedule/create_schedule_viewmodel.dart';
import 'package:chef/screens/experience/show_off_screen_v.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../services/navigation/navigation_service.dart';
import '../../services/navigation/router.gr.dart';
import '../../setup.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/helpers/toaster_helper.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_text.dart';
// import '../show_off_time/show_off_time_screen.dart';

class SetupScheduleScreen extends StatefulWidget {
  SetupScheduleScreen({Key? key, this.scheduleScreenViewModel})
      : super(key: key);
  final ScheduleScreenViewModel? scheduleScreenViewModel;

  @override
  State<SetupScheduleScreen> createState() => _SetupScheduleScreenState();
}

class _SetupScheduleScreenState extends State<SetupScheduleScreen> {
  bool repeatChecked = false;

  callCalenderWidget(){
    widget.scheduleScreenViewModel?.isOpenedDialog == false?WidgetsBinding.instance
        .addPostFrameCallback((_) => selectStartDate(context)):null;
    widget.scheduleScreenViewModel?.isOpenedDialog = true;
  }
  final _navigation = locateService<INavigationService>();


  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    callCalenderWidget();
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child:
    // return
        Scaffold(
      backgroundColor: HexColor.fromHex("#212129"),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          margin: const EdgeInsets.only(left: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  //Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  Resources.getSignInLeftArrow,
                  color: const Color(0xfff1c452),
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.scheduleScreenViewModel!.scheduleSaveCounter > 0) {
                    _navigation.navigateTo(route: const ShowOffTimeRoute());
                  } else {
                    Toaster.infoToast(
                        context: context,
                        message: 'Please add at-least one schedule');
                  }
                },
                child: SvgPicture.asset(
                  Resources.getSignInRightArrow,
                  color: const Color(0xfff1c452),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 218,
            width: double.infinity,
            child: Image.asset(Resources.expHeaderBGPNG),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: GeneralText(
                  Strings.setYourScheduleLabel,
                  style: appTheme.typographies.interFontFamily.headline6
                      .copyWith(
                          fontSize: 24, color: HexColor.fromHex('#ffffff')),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 40, bottom: 50),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.scheduleScreenViewModel?.scheduleList.length,
                itemBuilder: (BuildContext context, int index) {
                  var item =
                      widget.scheduleScreenViewModel?.scheduleList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 18.0, bottom: 10),
                            child: InkWell(
                              child: Image.asset(
                                Resources.expEditPenPNG,
                                height: 20,
                              ),
                              onTap: () {
                                showConfirmationPopup(context);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(children: [
                            GeneralText(item?.dayOfWeek.toUpperCase() ?? "",
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        color: HexColor.fromHex('#f1c452'),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                            GeneralText(item?.dateOfMonth ?? "",
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  color: HexColor.fromHex('#909094'),
                                  fontSize: 40,
                                ))
                          ]),
                          const SizedBox(
                            width: 27,
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.only(left: 8, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex('#2b2b33'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Wrap(
                                  children: getChipsWigetsList(appTheme,
                                      context, item!.timeInHourAndAmPm)

                                  ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(
            height: 37,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (repeatChecked) {
                              repeatChecked = false;
                            } else {
                              repeatChecked = true;
                            }
                          });
                        },
                        icon: Icon(
                          repeatChecked
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          color: HexColor.fromHex('#f1c452'),
                        )),
                    // SizedBox(
                    //   width: 12.5,
                    // ),
                    GeneralText(
                      Strings.scheduleSetupRepeatText,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ShowOffTime()));
                    selectStartDate(context);
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex("#bb3127"),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.add_sharp,
                        size: 35,
                        color: HexColor.fromHex("#ffffff"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          const SizedBox(
            height: 49.5,
          ),
        ]),
      ),
    ),
    );
  }

  List<Widget> getChipsWigetsList(IAppThemeData appTheme, BuildContext context,
      List<String> timeInHourAndAmPm) {
    return List.generate(timeInHourAndAmPm?.length ?? 0, (index) {
      var item = timeInHourAndAmPm![index];
      return InkWell(
        onTap: () {
          // var currentItemSelectedStatus = item.isSelected;
          //
          // item.isSelected = !currentItemSelectedStatus!;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 7, end: 7),
          child: timeSelectorBox(appTheme, item, showSelectedTime: false),
        ),
      );
    });
  }

  Widget timeSelectorBox(IAppThemeData appTheme, String time,
      {bool showSelectedTime = false}) {
    return Container(
      // width: 71,
      // height: 36,
      child: GeneralText(time,
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
      padding:
          const EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 16, end: 16),
      margin: const EdgeInsetsDirectional.only(bottom: 8),
    );
  }

  Future<void> selectStartDate(
      BuildContext context) async {
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
        final selectedDateTime =
            SelectedDateTime.fromDateTime(_selectedDateTime);

        String date = (selectedDateTime.dateTime.toString().substring(0, 10));
        String time = (selectedDateTime.dateTime.toString().substring(11, 16));

        String dayString = DateFormat.E().format(picked); //

        String timeString = DateFormat('h a').format(
            DateTime(picked.year, picked.month, picked.day, pickedTime.hour));

        String dateOfMonthString = DateFormat.d().format(picked);

        print(dayString);
        print(timeString);
        print(dateOfMonthString);

        widget.scheduleScreenViewModel?.setDayValue(dayString.toUpperCase());
        widget.scheduleScreenViewModel?.setTimeValue(
            widget.scheduleScreenViewModel!.convertTo24HourFormat(timeString));
        String pickedDate = picked.toString().substring(0, 10);
        widget.scheduleScreenViewModel?.datePicked = pickedDate;

        if (widget.scheduleScreenViewModel!.scheduleList.isNotEmpty) {
          var dateTimeAlreadyExist = false;
          var matchedIndex = 0;
          for (int i = 0;
              i < widget.scheduleScreenViewModel!.scheduleList.length;
              i++) {
            var element = widget.scheduleScreenViewModel!.scheduleList[i];
            if (element.dayOfWeek == dayString &&
                element.dateOfMonth == dateOfMonthString) {
              dateTimeAlreadyExist = true;
              matchedIndex = i;
            }
          }
          if (dateTimeAlreadyExist) {
            var timeAlreadyExist = false;
            widget.scheduleScreenViewModel?.scheduleList[matchedIndex]
                .timeInHourAndAmPm
                .forEach((element) {
              if (element == timeString) {
                timeAlreadyExist = true;
              }
            });
            if (!timeAlreadyExist) {
              widget.scheduleScreenViewModel?.sendScheduleData(completion: () {
                widget.scheduleScreenViewModel?.scheduleList[matchedIndex]
                    .timeInHourAndAmPm
                    .add(timeString);
              });
              setState(() {});
            }
          } else {
            widget.scheduleScreenViewModel?.sendScheduleData(completion: () {
              widget.scheduleScreenViewModel?.scheduleList.add(Schedule(
                  date: date,
                  time: time,
                  dayOfWeek: dayString,
                  dateOfMonth: dateOfMonthString,
                  timeInHourAndAmPm: [timeString]));
            });
            setState(() {});
          }
          return;
        } else {
          widget.scheduleScreenViewModel?.sendScheduleData(completion: () {
            widget.scheduleScreenViewModel?.scheduleList.add(Schedule(
                date: date,
                time: time,
                dayOfWeek: dayString,
                dateOfMonth: dateOfMonthString,
                timeInHourAndAmPm: [timeString]));
          });
        }
        print(widget.scheduleScreenViewModel?.scheduleList.length);
        setState(() {});
      }
    }
  }

  showConfirmationPopup(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.show(
      isDismissible: true,
      barrierLabel: 's',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          GeneralText('Are you Sure',
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25)),
          const SizedBox(
            height: 25,
          ),
          GeneralText(Strings.repeatPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  color: const Color(0xfffee4a4),
                  fontWeight: FontWeight.w400,
                  fontSize: 14)),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _okButtonTitle(appTheme: appTheme),
              const SizedBox(
                width: 10,
              ),
              _cancelTitle(appTheme: appTheme),
            ],
          ),
          const SizedBox(
            height: 13,
          ),
        ],
      ),
      context: context,
    );
  }

  Widget _okButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.okButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        //    viewModel.goToForgotPasswordScreen();
      },
    );
  }

  Widget _cancelTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.cancelButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        //    viewModel.goToForgotPasswordScreen();
      },
    );
  }
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
