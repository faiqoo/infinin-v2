import 'dart:convert';

import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:chef/services/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../constants/api.dart';
import '../../../constants/strings.dart';
import '../../../models/billed_bookings/billed_bookings_response.dart';
import '../../../models/booking/accept_booking_response.dart';
import '../../../models/booking/booking_status.dart';
import '../../../models/booking/order_detail_response.dart';
import '../../../models/experience/experience_billed_request.dart';
import '../../../models/foodie/foodie_details_response.dart';
import '../../../models/home/food_menu_request.dart';
import '../../../services/application_state.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../../services/navigation/router.gr.dart';
import '../../../setup.dart';
import '../../../ui_kit/helpers/toaster_helper.dart';
import 'foodie_profile_decision_screen_m.dart';
// import 'order_screen_m.dart';

import '../../../models/booking/process_booking_request.dart' as bookingRequest;

import 'dart:developer' as developer;

@injectable
class FoodieProfileDecisionScreenViewModel
    extends BaseViewModel<FoodieProfileDecisionScreenState> {
  FoodieProfileDecisionScreenViewModel({
    required INetworkService network,
    required INavigationService navigation,
  })  : _navigation = navigation,
      _network = network,
        super(const Loading());

  final INetworkService _network;
  final INavigationService _navigation;

  String bookingId = "0";

  void initialize(String _bookingId) {
    developer.log(' Booking Id is ' '${_bookingId}');
    bookingId = _bookingId;
    // emit(const Loading());
    loadOrderDetails();
  }

  String orderQR = "";


  Future<void> loadOrderDetails() async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.findById);
    // emit(const Loading());

    final _appService = locateService<ApplicationService>();

    emit(const Loading());

    final foodMenuRequest = FoodMenuRequest(
      // t: int.parse(_appService.state.userInfo!.t.id.toString()),
      t: int.parse(bookingId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: foodMenuRequest,
    );

    if (response != null) {
      // FoodieDetails foodieDetails = foodieDetailsFromJson(response.body);
      developer
          .log(' Response body of order details are ' '${response.body}');

      OrderDetails orderDetails = orderDetailsFromJson(response.body);
      orderQR = jsonEncode(orderDetails.t.qrRequest?.toJson()).toString();
      emit(Loaded(orderDetails));
    }
  }


  Future<void> loadBilledDetails({required int id}) async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.billedBooking);

    final _appService = locateService<ApplicationService>();

    // emit(const Loading());

    final expBilledRequest = ExperienceBilledRequest(
      userId: int.parse(_appService.state.userInfo!.t.id.toString()),
      t: id,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: expBilledRequest,
    );

    if (response != null) {

      developer
          .log(' Response body of billed orders details are ' '${response.body}');
print("billed "+ response.body);
      // ExperienceBilledOrder billedOrderDetails = billedOrderDetailsFromJson(response.body);
      // emit(Loaded());
    }
  }

  Future<void> sendAcceptRequest() async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.acceptBooking);
    // emit(const Loading());

    final _appService = locateService<ApplicationService>();

    //  emit(const Loading());

    final foodMenuRequest = FoodMenuRequest(
      // t: int.parse(_appService.state.userInfo!.t.id.toString()),
      t: int.parse(bookingId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: foodMenuRequest,
    );

    if (response != null) {
      OrderStatusResponse acceptResponse =
          orderStatusResponseFromJson(response.body);
      developer.log('acceptResponse is  ' '${acceptResponse.t.brandName}');

      //  emit(Loaded(foodieDetails));
    }
  }

  Future<void> sendDeclineRequest() async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.declineBooking);
    // emit(const Loading());

    final _appService = locateService<ApplicationService>();

    //  emit(const Loading());

    final foodMenuRequest = FoodMenuRequest(
      // t: int.parse(_appService.state.userInfo!.t.id.toString()),
      t: int.parse(bookingId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: foodMenuRequest,
    );

    if (response != null) {
      OrderStatusResponse declineResponse =
          orderStatusResponseFromJson(response.body);
      developer.log('declineResponse is  ' '${declineResponse.t.brandName}');

      //  emit(Loaded(foodieDetails));
    }
  }

  void processOrder(String jsonString, BuildContext context) {

    String jsonWithoutBraces = jsonString.substring(1, jsonString.length - 1);
    List<String> keyValuePairs = jsonWithoutBraces.split(',');
    Map<String, dynamic> jsonMap = {};

    for (String keyValuePair in keyValuePairs) {
      List<String> keyValue = keyValuePair.split(':');
      String key = keyValue[0].trim();
      String trimmedKey = key.replaceAll('\\', '').replaceAll('"', '').trim();
      String value = keyValue[1].trim();



      dynamic parsedValue = int.tryParse(value) ?? value.replaceAll('"', '');
      jsonMap[trimmedKey] = parsedValue;
    }

    String json = jsonEncode(jsonMap);
    developer.log(' JSOn is ' + '${json}');
    developer.log('Data converted verification code is ' +
        '${jsonMap['verificationCode']}');
    processBooking(jsonMap, context);
  }

  Future<void> processBooking(Map<String, dynamic> processBookingDetails, BuildContext context) async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.processBooking);
    // emit(const Loading());

    final _appService = locateService<ApplicationService>();

    emit(const Loading());

    final bookingData = bookingRequest.ProcessBookingRequest(
        userId: _appService.state.userInfo?.t.id,
        t: bookingRequest.T(
          bookingId: processBookingDetails['bookingId'],
          experienceId: processBookingDetails['experienceId'],
          chefId: processBookingDetails['chefId'],
          foodieId: processBookingDetails['foodieId'],
          verificationCode: processBookingDetails['verificationCode'],
        )).toJson();


    var duration = const Duration(seconds: 2); // set the duration to 5 seconds
    var response = await Future.delayed(duration, () {
      return _network.post(
        path: url,
        data: bookingData,
      );
    });
    // final response = await _network.post(
    //   path: url,
    //   data: bookingData,
    // );


    if (response != null) {
      print("ressp"+response.body);
      _appService.updateTitlePage(
          Strings.inProgress
              .replaceAll('_', '')
              .substring(0, 1)
              .toUpperCase() +
              Strings.inProgressTitle
                  .substring(1)
                  .toLowerCase());
      _navigation.navigateTo(
          route: OrderRouteView(
            type: Strings.inProgress,
          ));
      // BookingOverview bookingOverview = bookingOverviewFromJson(response.body);
      // emit(home_model.Loaded(bookingOverview));
    } else {
      Toaster.errorToast(context: context, message: "Invalid response received");
    }
  }

  String getDisplayDate(
    DateTime providedDate,
    String providedTime,
  ) {
    // DateTime date = DateTime.parse(item.scheduleScheduledDate ?? '');
    String formattedDate =
        "${providedDate.day} ${InfininHelpers.getMonthName(providedDate.month)}";

    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String formatted = formatter.format(providedDate);

    // final String formatted = formatter.format(now);
    //String timeString = providedTime ?? '';
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateTime dateTime = inputFormat.parse(providedTime);
    DateFormat outputFormat = DateFormat('hh a');
    String formattedTime = outputFormat.format(dateTime);

    developer.log(' Formatted Time is ' '${formattedTime}');

    return formattedTime;
  }

  String getFormattedDate(DateTime providedDate) {
    String formattedDate =
        "${providedDate.day} ${InfininHelpers.getMonthName(providedDate.month)}";

    return formattedDate;
  }

  String displayFormatedDateAndTime(
      DateTime providedDate, String providedTime) {
    String formattedDate = getFormattedDate(providedDate) +
        " @ " +
        getDisplayDate(providedDate, providedTime);

    return formattedDate;
  }

  String getDateDisplay(
    DateTime providedDate,
  ) {
    final DateFormat formatter = DateFormat('dd-MM-yy');
    final String formatted = formatter.format(providedDate);

    return formatted;
  }

  String getDayAndMonth(DateTime _givenDate) {
    var _date = InfininHelpers.dayOfMonth(_givenDate);
    var dayOfMonth = _givenDate.day;
    var _month = InfininHelpers.months[_givenDate.month - 1];
    var _productDetailSelectionDate = _date.toUpperCase() +
        ',  ' +
        (dayOfMonth.toString())! +
        "   " +
        _month.toString().toUpperCase();
    return _productDetailSelectionDate;
  }
}
