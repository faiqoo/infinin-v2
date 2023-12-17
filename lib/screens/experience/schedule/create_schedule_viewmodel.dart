import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:chef/services/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:chef/models/experience/schedule_request.dart'
    as scheduleReuqest;

import '../../../constants/api.dart';
import '../../../models/experience/schedule_response.dart';
import '../../../services/application_state.dart';
import '../../../setup.dart';
import 'create_schedule_m.dart';

@injectable
class ScheduleScreenViewModel extends BaseViewModel<ScheduleScreenState> {
  ScheduleScreenViewModel({
    required INetworkService network,
  })  : _network = network,
        super(const Loading());

  final INetworkService _network;
  bool isOpenedDialog = false;


  List<Schedule> scheduleList = [];
  final _appService = locateService<ApplicationService>();
  int? dayValue;
  int? timeValue;
  String? datePicked;

  int scheduleSaveCounter = 0;

  initialize() {
    emit(const Loaded());
  }

  setDayValue(String day) {
    Map<String, int> weekdaysMap = {
      'SUN': 1,
      'MON': 2,
      'TUE': 3,
      'WED': 4,
      'THU': 5,
      'FRI': 6,
      'SAT': 7
    };
    if (weekdaysMap.containsKey(day)) {
      int? dayIndex = weekdaysMap[day];
      dayValue = dayIndex;
    } else {
      print('$day not found');
    }
  }

  setTimeValue(String time) {
    Map<String, int> timeOfWeek = {
      '00': 1,
      '01': 2,
      '02': 3,
      '03': 4,
      '04': 5,
      '05': 6,
      '06': 7,
      '07': 8,
      '08': 9,
      '09': 10,
      '10': 11,
      '11': 12,
      '12': 13,
      '13': 14,
      '14': 15,
      '15': 16,
      '16': 17,
      '17': 18,
      '18': 19,
      '19': 20,
      '20': 21,
      '21': 22,
      '22': 23,
      '23': 24
    };
    if (timeOfWeek.containsKey(time)) {
      int? dayIndex = timeOfWeek[time];
      timeValue = dayIndex;
    } else {
      print('$time not found');
    }
  }

  String convertTo24HourFormat(String time) {
    // Split the time string into hours and minutes
    List<String> timeParts = time.split(' ');
    List<String> hourAndMinute = timeParts[0].split(':');
    int hour = int.parse(hourAndMinute[0]);
    // int minute = int.parse(hourAndMinute[1]);
    // Convert the hour to 24-hour format
    if (timeParts[1] == 'PM' && hour != 12) {
      hour += 12;
    } else if (timeParts[1] == 'AM' && hour == 12) {
      hour = 0;
    }
    // Return the time in 24-hour format as a string
    return hour.toString().padLeft(2, '0');
  }

  Future<void> sendScheduleData({Function? completion}) async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.scheduleSave);

    emit(const Loading());

    final scheduleData = scheduleReuqest.ScehduleData(
      chefId: _appService.state.userInfo!.t.id,
      reservedStatus: 'open',
      experienceId: _appService.state.experienceResponse!.t!.id,
      hourOfDay: 3,
      dayOfMonth: dayValue,
      hourId: timeValue,
      scheduledDate: datePicked,
    );

    final ScheduleRequest = scheduleReuqest.ScheduleRequest(
      t: scheduleData,
    ).toJson();

    var duration = const Duration(seconds: 2); // set the duration to 5 seconds
    var response = await Future.delayed(duration, () {
      return _network.post(
        path: url,
        data: ScheduleRequest,
      );
    });
    //
    completion!();
    // print(response.body);
    if (response.body != null) {
      ScheduleResponse scheduleResponse =
          scheduleResponseFromJson(response.body);
      if (scheduleResponse.code == 200) {
        scheduleSaveCounter++;

        emit(const Loaded());
      } else {
        emit(const Loading());
      }
    } else {
      emit(const Loaded());
    }
    //response.body.code == 200) {

    //  }
  }
}

class Schedule {
  String date;
  String time;
  String dayOfWeek;
  String dateOfMonth;
  List<String> timeInHourAndAmPm;

  Schedule({
    required this.date,
    required this.time,
    required this.dayOfWeek,
    required this.dateOfMonth,
    required this.timeInHourAndAmPm,
  });
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
