import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:chef/services/network/network_service.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../constants/api.dart';
import '../../../models/booking/booking_status.dart';
import '../../../models/home/food_menu_request.dart';
import '../../../services/application_state.dart';
import '../../../setup.dart';
import 'order_screen_m.dart';

import 'dart:developer' as developer;

@injectable
class OrderScreenViewModel extends BaseViewModel<OrderScreenState> {
  OrderScreenViewModel({
    required INetworkService network,
  })  : _network = network,
        super(const Loading());

  final INetworkService _network;

  void initialize() {
    emit(const Loading());
  }

  Future<void> loadBookingOverview(String _type) async {
    final url = InfininHelpers.getRestApiURL(
        Api.baseURL + Api.findByChefId + '?type=' + _type);

    final _appService = locateService<ApplicationService>();

    emit(const Loading());

    final foodMenuRequest = FoodMenuRequest(
      t: int.parse(_appService.state.userInfo!.t.id.toString()),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: foodMenuRequest,
    );

    if (response != null) {
      BookingStatus bookingStatus = bookingStatusFromJson(response.body);
      emit(Loaded(bookingStatus));
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

    developer.log(' Formatted Time is ' + '${formattedTime}');

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
}
