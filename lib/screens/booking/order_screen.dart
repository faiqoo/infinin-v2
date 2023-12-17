import 'package:chef/screens/foodie_profile/foodie_profile_order_declined.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../models/booking/booking_status.dart';
import '../../services/navigation/navigation_service.dart';
import '../../services/navigation/router.gr.dart';
import '../../setup.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../foodie_profile/foodie_profile_booking_confirmed.dart';
import '../foodie_profile/foodie_profile_decision.dart';
import '../foodie_profile/foodie_profile_detail.dart';
import '../foodie_profile/foodie_profile_order_completed.dart';
import '../home/widget/food_details_screen.dart';
import '../home/food_item_booking_confirmed.dart';
import 'booking_in_process_screen.dart';
import 'component/order_screen_vm.dart';
import 'food_item_advance_booking.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen(
      {required BookingStatus bookingStatus,
      required OrderScreenViewModel orderViewModel,
      required String type,
      Key? key})
      : _bookingStatus = bookingStatus,
        _orderViewModel = orderViewModel,
        _type = type,
        super(key: key);

  BookingStatus _bookingStatus;
  OrderScreenViewModel _orderViewModel;
  String _type;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<BookingProgress> bookingProgressStatus = [];
  final _navigation = locateService<INavigationService>();

  @override
  void initState() {
    for (int i = 0; i < widget._bookingStatus.t.length; i++) {
      bookingProgressStatus.addAll([
        BookingProgress(
          //bookingStatusIcon:  Resources.timeLapsePNG,
          bookingStatusIcon: getIcon(widget._type),
          statusName: getStatusName(widget._bookingStatus.t[i].bookingStatus),
        )
        // statusName: widget._bookingStatus.t[i].bookingStatus == 'REQUESTED'
        //     ? Strings.foodItemBookingDecisionRequired
        //     : Strings.bookingOrderCompleted),
      ]);
    }
    // // TODO: implement initState
    // bookingProgressStatus.addAll([
    //   // BookingProgress(
    //   //     bookingStatusIcon: Resources.timeLapsePNG,
    //   //     statusName: Strings.bookingOrderCompleted),
    //   // BookingProgress(
    //   //     bookingStatusIcon: Resources.hourglassPNG,
    //   //     statusName: Strings.bookingOrderDeclined),
    //   // BookingProgress(
    //   //     bookingStatusIcon: Resources.confirmUserPNG,
    //   //     statusName: Strings.foodItemBookingInProgress),
    //   BookingProgress(
    //       bookingStatusIcon: Resources.paymentPNG,
    //       statusName: Strings.foodItemBookingDecisionRequired),
    //   // BookingProgress(
    //   //     bookingStatusIcon: Resources.paymentPNG,
    //   //     statusName: Strings.foodItemBookingConfirmed),
    // ]);
    super.initState();
  }

  String getStatusName(String _status) {
    switch (_status) {
      case Strings.requestedNew:
        return Strings.foodItemBookingPending;
      case Strings.acceptDataLowerCase:
        return Strings.foodItemBookingAdvancePendingHeader;
      case Strings.confirmedStatus:
        return Strings.confirmedValue;
      case Strings.inProgressForSwitch:
        return Strings.inProgressTitle;
      case Strings.billGenerated:
        return Strings.billGenerated;
      default:
        return Strings.foodItemBookingDecisionRequired;
    }
  }

  String getIcon(String _status) {
    switch (_status) {
      case Strings.newData:
        return Resources.timeLapsePNG;
      case Strings.acceptData:
        return Resources.hourglassPNG;
      case Strings.confirmed:
        return Resources.confirmUserPNG;
      case Strings.inProgress:
        return Resources.paymentPNG;
      default:
        return Resources.timeLapsePNG;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    // return Scaffold(
    //   backgroundColor: HexColor.fromHex("#212129"),
    //   body: Container(
    //     // padding: const EdgeInsets.only(left: 22, right: 22),
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         // mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           SizedBox(
    //             height: 40,
    //           ),
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: 12,
    //               top: 20,
    //               bottom: 20,
    //             ),
    //             child: const GeneralNewAppBar(
    //               rightIcon: Resources.homeIconSvg,
    //               title: Strings.labelNewBookings,
    //               titleColor: Colors.white,
    //             ),
    //           ),
    //           Expanded(child: bookingDetails(appTheme)),
    //         ]),
    //   ),
    // );

    return bookingDetails(appTheme);
  }

  Widget bookingDetails(IAppThemeData appTheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          // itemCount: bookingProgressStatus.length,
          itemCount: widget._bookingStatus.t.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralText(
                  widget._orderViewModel.getDateDisplay(
                      widget._bookingStatus.t[index].scheduleScheduledDate),
                  style: appTheme.typographies.interFontFamily.headline6
                      .copyWith(
                          fontSize: 12,
                          color: HexColor.fromHex('#fee4a4'),
                          fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 22, bottom: 40),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor.fromHex("#4b4b52")),
                  child: InkWell(
                    onTap: () {
                      // if (index == 0) {
                      //   //
                      //
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) {
                      //     return const FoodieProfileOrderCompleted();
                      //   }));
                      // }
                      //
                      // if (index == 1) {
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) {
                      //     return const FoodieProfileOrderDeclined();
                      //   }));
                      // } else if (index == 2) {
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) {
                      //     return FoodieInProgressDetail();
                      //   }));
                      // } else if (index == 3) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               FoodieProfileRequiredPending()));
                      // } else if (index == 4) {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) =>
                      //               FoodieProfileBookingConfirmed()));
                      // }

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             FoodieProfileRequiredPending()));

                      _navigation.navigateTo(
                          route: FoodieProfileDecisionRouteView(
                        bookingId: widget._bookingStatus.t[index].id.toString(),
                      ));
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => FoodieProfileBookingConfirmed()));
                      // else{
                      //   _showGeneralPopup(context);
                      // }
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    Resources.bookingUserPNG,
                                    width: 35,
                                  ),
                                  const SizedBox(
                                    width: 7.2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GeneralText(
                                        widget._bookingStatus.t[index].brandName,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 15,
                                                color:
                                                    HexColor.fromHex('#ffffff'),
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 13.9,
                                            child: Image.asset(
                                                Resources.bookingStarPNG,
                                                fit: BoxFit.fill),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          GeneralText(
                                            Strings.foodItemBookingReviews,
                                            style: appTheme.typographies
                                                .interFontFamily.headline6
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: HexColor.fromHex(
                                                        '#b0c18b')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex("#bb3127"),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: GeneralText(
                                  //     Strings.foodItemBookingAmount,
                                    Strings.rsLabel + widget._bookingStatus.t[index].totalPrice
                                      .toString(),
                                  style: appTheme
                                      .typographies.interFontFamily.headline1
                                      .copyWith(
                                          fontSize: 19,
                                          color: HexColor.fromHex('#ffffff'),
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 22),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GeneralText(
                                    // Strings.foodItemBookingName,
                                    widget
                                        ._bookingStatus.t[index].experienceName,
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 16,
                                            color: HexColor.fromHex('#909094'),
                                            fontWeight: FontWeight.w600),
                                  ),
                                  GeneralText(
                                    // Strings.foodItemBookingNoPersons,
                                    widget._bookingStatus.t[index].persons + Strings.personsLabel,
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 14,
                                            color: HexColor.fromHex('#fbeccb'),
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GeneralText(
                                    widget._orderViewModel
                                        .displayFormatedDateAndTime(
                                            widget._bookingStatus.t[index]
                                                .scheduleScheduledDate,
                                            widget._bookingStatus.t[index]
                                                .scheduleStartTime),
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 14,
                                            color: HexColor.fromHex('#ffffff'),
                                            fontWeight: FontWeight.w400),
                                  ),
                                  GeneralText(
                                    // Strings.foodItemBookingType,
                                    widget
                                        ._bookingStatus.t[index].preferenceName,
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 14,
                                            color: HexColor.fromHex('#fee4a4'),
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              progressBar(appTheme, index),
                              const SizedBox(
                                height: 23,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GeneralText(
                                    bookingProgressStatus[index].statusName ??
                                        "",
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 16,
                                            color: HexColor.fromHex('#f1c452'),
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ]),
                          )
                        ]),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget progressBar(IAppThemeData appTheme, int index) {
    var progressBar;
    if (widget._type == Strings.newData) {
      progressBar = Row(children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#909094")),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    }
    else if (widget._type == Strings.acceptData) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#909094")),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    }
    else if (widget._type == Strings.confirmed) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#f1c452")),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    }
    else if (widget._type == Strings.inProgress) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#f1c452")),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
      ]);
    }
    else {
      return Container();
    }
    return progressBar;
  }

  Future<dynamic> _showGeneralPopup(BuildContext context) async {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.show(
      context: context,
      // dialogType: GeneralComponentStyle.success,
      isDismissible: true,
      barrierLabel: '',
      // title: 'Verification\nCode',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outlined,
              color: appTheme.colors.secondaryBackground,
              size: 45,
            ),
            GeneralText(
              Strings.generalPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: appTheme.colors.secondaryBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GeneralText(
                Strings.generalSubTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: const Color(0xfffee4a4),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            GeneralButton.button(
              title: Strings.generalButtonTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
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

class BookingProgress {
  String? statusName;
  String? bookingStatusIcon;

  BookingProgress({this.statusName, this.bookingStatusIcon});
}
