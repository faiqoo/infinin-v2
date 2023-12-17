import 'package:chef/app.dart';
import 'package:chef/models/experience/experience_request.dart' as expreq;

import '../../../helpers/experience_helper.dart';
import '../../../helpers/helpers.dart';

import '../../../models/experience/experience_request.dart'
    as experience_request;
import '../../../models/experience/experience_response.dart' as expresp;
import '../../../models/experience/schedule_list_display.dart';
import '../../../models/home/experience_list_response.dart';
import '../../../models/home/food_details_menu_model.dart';
import '../../../models/home/food_menu_request.dart';
import '../../../models/preference.dart' as preference;
import '../../../models/wow_factor/wow_factor_response.dart' as wowfactor;
// import '../../../models/wow_factor/wow_factor_response.dart';
import '../../../setup.dart';
import '../widget/schedule_data_model.dart' as schedule_data;
import 'experience_menu_details_screen_m.dart' as exp_menu_details;

import 'package:chef/helpers/data_request.dart' as data_request;

import 'package:chef/models/home/food_menu_request.dart' as menurequest;

import 'dart:developer' as developer;
import '../../../models/home/food_details_menu_model.dart'
    as food_details_menu_model;

@injectable
class ExperienceMenuDetailsScreenViewModel
    extends BaseViewModel<exp_menu_details.ExperienceMenuDetailsScreenState> {
  ExperienceMenuDetailsScreenViewModel({
    required INavigationService navigation,
    required INetworkService network,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _navigation = navigation,
        _network = network,
        _storage = storage,
        _appService = appService,
        super(const exp_menu_details.Loading());
  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;
  final ApplicationService _appService;

  late final wowfactor.WowFactorResponse _wowFactorResponse;
  late final preference.PreferenceResponse _preferenceResponse;
  late FoodMenuModel foodMenuData;
  late ScheduleData scheduleData;

  initialize() {}

  void saveExperience(BuildContext context) async {
    final _appService = locateService<ApplicationService>();

    ExperienceHelper experienceHelper = (_appService.state.experienceHelper)!;

    if (!validateData(context, experienceHelper)) {
      return;
    }
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.experienceSave);

    //getList(experienceHelper.selectedWowFactors,'wow');
    experience_request.T t = experience_request.T(
      title: experienceHelper.titleExperience ?? '',
      description: experienceHelper.experienceDetails ?? '',
      persons: experienceHelper.numberOfPerson.toString(),
      chefId: _appService.state.userInfo!.t.id,
      chefAddress: _appService.state.userInfo!.t.address,
      chefBrandName: _appService.state.userInfo!.t.address,
      chefName: _appService.state.userInfo!.t.name,
      locationId: 1,
      price: (experienceHelper.priceExperience ?? 0.0).toInt(),
      priceTypeId: 1,
      subHostMobileNo: experienceHelper.subHostMobileNumber ?? '',
      subHostName: experienceHelper.subHostName ?? '',
      wowFactorId: 1,
      preferenceId: 1,
      experienceWowFactors:
          getList(experienceHelper.selectedWowFactors, 'wow').toList(),
      experiencePreferences: getPreferenceList(
          experienceHelper.selectedPerferencesFactors, 'pref'),
    );

    final experienceData = experience_request.ExperienceRequest(
      t: t,
    ).toJson();

    final response = await _network
        .post(
          path: url,
          data: experienceData,
          //   accessToken: false,
        )
        .whenComplete(() {});

    // final response = await _network.get(
    //   //below one is working
    //   path: 'https://run.mocky.io/v3/80289cbe-aa47-491e-9eb2-56126289c8a4',
    // );

    if (response != null) {
      developer.log(' Response of Signup body is ' + '${response.body}');

      expresp.ExperienceResponse experienceResponse =
          expresp.experienceResponseFromJson(response.body);
      _appService.updateSaveExperience(experienceResponse);
      //   SignupResponse signupResponse = signupResponseFromJson(response.body);
//
      //   Toaster.infoToast(context: context, message: signupResponse.message);

      //   developer.log(' Sign up Response is ' + signupResponse.message);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MenuExperienceScreen()),
      // );
    } else {
      Toaster.infoToast(
          context: context,
          message: 'Something is wrong please content vendor');
      developer.log(' Response of Create Experience is ' + '$response');
    }
  }

  List<expreq.ExperienceWowFactor> getList(Map data, String type) {
    // Map obj = experienceHelper.selectedWowFactors;

    // developer.log(' In List wow factors are ' + '${obj.keys}');

    List<expreq.ExperienceWowFactor> alignData = [];

    data.forEach((key, value) {
      Map _localEntry = {};

      if (type == 'wow') {
        expreq.ExperienceWowFactor dataHere =
            expreq.ExperienceWowFactor(wowFactorId: value);
        alignData.add(dataHere);
      } else {
        alignData.add(_localEntry['preferenceId'] = value);
      }

      //  data = data + value.toString();
    });

    developer.log('Data ready to send is ' + '${alignData.length}');
    for (int i = 0; i < alignData.length; i++) {
      developer.log(' Wow factor is ' + '${alignData[i]}');
    }

    return alignData;
  }

  List<expreq.ExperiencePreference> getPreferenceList(Map data, String type) {
    // Map obj = experienceHelper.selectedWowFactors;

    // developer.log(' In List wow factors are ' + '${obj.keys}');

    List<expreq.ExperiencePreference> alignData = [];

    data.forEach((key, value) {
      Map _localEntry = {};
      if (type == 'wow') {
        alignData.add(_localEntry['wowFactorId'] = value);
      } else {
        //alignData.add(_localEntry['preferenceId'] = value);

        expreq.ExperiencePreference dataHere =
            expreq.ExperiencePreference(preferenceId: value);
        alignData.add(dataHere);
      }

      //  data = data + value.toString();
    });

    developer
        .log('Data ready to ExperiencePreference is ' + '${alignData.length}');
    for (int i = 0; i < alignData.length; i++) {
      developer.log(' ExperiencePreference factor is ' + '${alignData[i]}');
    }

    return alignData;
  }

  Future<void> getExperienceMenu({required String experienceId}) async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.experienceMenu);
    // emit(const Loading());

    emit(const exp_menu_details.Loading());

    final foodMenuRequest = FoodMenuRequest(
      t: int.parse(experienceId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: foodMenuRequest,
    );

    developer.log(' Food Menu Data is ' + '${response.body}');
    foodMenuData = foodMenuModelFromJson(response.body);
    getScheduleData(experienceId: experienceId);
    // emit(exp_menu_details.Loaded(foodMenuData));
    //  getScheduleData(experienceId: experienceId, foodMenuModel: foodMenuData);
    //  emit(Loaded(foodMenuData));

    // List<ProfessionData> data = currentProfessionData.t;
    // emit(Loaded(currentProfessionData));
  }

  Future<void> updateExperienceMenu({
    required String foodTitle,
    required String foodSubtitle,
    required String foodDescription,
    required int price,
    required food_details_menu_model.T foodMenuModel,
  }) async {
    final url =
        InfininHelpers.getRestApiURL(Api.baseURL + Api.experienceMenuUpdate);
    // emit(const Loading());

    food_details_menu_model.T t = food_details_menu_model.T(
      baseDishId: foodMenuModel.baseDishId,
      baseDishName: foodSubtitle,
      description: foodDescription,
      dish: foodSubtitle,
      experienceId: foodMenuModel.experienceId,
      id: foodMenuModel.id,
      mealId: foodMenuModel.mealId,
      mealName: foodTitle,
      price: price,
      pictureUrl: "",
    );

    final menuRequestUpdate = food_details_menu_model.MenuRequestUpdate(
      t: t,
    ).toJson();
    developer.log(' Food Details Request is ' + '${menuRequestUpdate}');

    final response = await _network
        .post(
          path: url,
          data: menuRequestUpdate,
          //   accessToken: false,
        )
        .whenComplete(() {});

    developer.log(' Food Details Data is ' + '${response.body}');

    getExperienceMenu(experienceId: foodMenuModel.experienceId.toString());
    // emit(Loaded(currentProfessionData));
  }

  Future<void> updateScheduleData(
      {Function? completion, ScheduleModel? scheduleModel}) async {
    final url =
        InfininHelpers.getRestApiURL(Api.baseURL + Api.scheduleDataUpdate);

    // emit(const Loading());

    final scheduleData = schedule_data.T(
      chefId: _appService.state.userInfo!.t.id,
      reservedStatus: 'open',
      // experienceId:foodMenuModel.experienceId ,
      // experienceId: _appService.state.experienceResponse!.t!.id,
      experienceId: 175,
      hourOfDay: 3,
      id: 3,
      hourEndTime:
          schedule_data.HourEndTime(hour: 10, minute: 45, nano: 0, second: 2),
      hourStartTime:
          schedule_data.HourEndTime(hour: 10, minute: 45, nano: 0, second: 2),
      dayOfMonth: 3,
      hourId: 0,
      scheduledDate: scheduleModel!.scheduledDate.toString(),
    );

    final scheduleRequest = schedule_data.ScheduleRequestUpdate(
      t: scheduleData,
    ).toJson();

    var duration = const Duration(seconds: 2); // set the duration to 5 seconds
    var response = await Future.delayed(duration, () {
      return _network.post(
        path: url,
        data: scheduleRequest,
      );
    });
    //
    completion!();

    developer.log(' Food Details Data is ' + '${response.body}');

    //getExperienceMenu(experienceId: foodMenuModel.experienceId.toString());

    // print(response.body);
    // if (response.body != null) {
    //   ScheduleResponse scheduleResponse =
    //   scheduleResponseFromJson(response.body);
    //   if (scheduleResponse.code == 200) {
    //     scheduleSaveCounter++;
    //
    //     emit(const Loaded());
    //   } else {
    //     emit(const Loading());
    //   }
    // } else {
    //   emit(const Loaded());
    // }
    //response.body.code == 200) {

    //  }
  }

  Future<void> getScheduleData({
    required String experienceId,
    // required FoodMenuModel foodMenuModel,
  }) async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.scheduleData);
    // emit(const Loading());

    final scheduleRequest = menurequest.FoodMenuRequest(
      t: int.parse(experienceId),
    ).toJson();

    final response = await _network.post(path: url, data: scheduleRequest);

    debugPrint("schedule response\n" + response.body.toString());

    // final scheduleData = scheduleModelFromJson(response.body);
    scheduleData = scheduleModelFromJson(response.body);
    emit(exp_menu_details.Loaded(foodMenuData, scheduleData));
    // loadPreference(foodMenuModel: foodMenuModel, scheduleData: scheduleData);
  }

  // void loadWowFactors() async {
  //   //http://18.202.117.137:8080/feyst-service/wow-factor/list
  //
  //   final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.wowFactorAPI);
  //
  //   // T t = loginrequest.T(
  //   //   mobileNo: mobileNumber,
  //   // );
  //
  //   final requestWowFactor = LoginRequest(
  //     t: T(),
  //   ).toJson();
  //
  //   final _header = <String, String>{
  //     Api.headerAcceptKey: Api.headerAcceptTypeValue
  //   };
  //
  //   // final questionsDataRequest = questionirerequest.QuestionireRequest(
  //   //   t: questionirerequest.T(category: "CHEF_PROFILE"),
  //   // ).toJson();
  //   final response = await _network.post(
  //     path: url,
  //     data: requestWowFactor,
  //   );
  //
  //   _wowFactorResponse = wowfactor.wowFactorResponseFromJson(response.body);
  //   loadPerferences();
  //   //  emit(create_experience.Loaded(_wowFactorResponse));
  //   //List<QuestionsList> data = currentQuestionirData.t;
  //   //emit(signupquestion.Loaded(currentQuestionirData.t));
  // }

  // void loadPerferences() async {
  //   //http://18.202.117.137:8080/feyst-service/wow-factor/list
  //
  //   final url =
  //       InfininURLHelpers.getRestApiURL(Api.baseURL + Api.preferenceAPI);
  //
  //   // T t = loginrequest.T(
  //   //   mobileNo: mobileNumber,
  //   // );
  //
  //   final requestWowFactor = LoginRequest(
  //     t: T(),
  //   ).toJson();
  //
  //   final _header = <String, String>{
  //     Api.headerAcceptKey: Api.headerAcceptTypeValue
  //   };
  //
  //   // final questionsDataRequest = questionirerequest.QuestionireRequest(
  //   //   t: questionirerequest.T(category: "CHEF_PROFILE"),
  //   // ).toJson();
  //   final response = await _network.post(
  //     path: url,
  //     data: requestWowFactor,
  //   );
  //
  //   // final preferenceResponse =
  //   _preferenceResponse = preference.preferenceResponseFromJson(response.body);
  //   emit(exp_details.Loaded());
  //   //List<QuestionsList> data = currentQuestionirData.t;
  //   //emit(signupquestion.Loaded(currentQuestionirData.t));
  // }

  bool validateData(BuildContext context, ExperienceHelper experienceHelper) {
    var isValidate = true;
    if ((experienceHelper.titleExperience ?? '').isEmpty) {
      isValidate = false;
      Toaster.infoToast(context: context, message: 'Title cannot be empty');
      return false;
    }
    if ((experienceHelper.experienceDetails ?? '').isEmpty) {
      isValidate = false;
      Toaster.infoToast(
          context: context, message: 'Descriptions cannot be empty');
      return false;
    }
    if ((experienceHelper.priceExperience ?? 0.0) > 0) {
    } else {
      isValidate = false;
      Toaster.infoToast(context: context, message: 'Price cannot be empty');
      return false;
    }
    if ((experienceHelper.personExperience ?? 0) > 0) {
    } else {
      isValidate = false;
      Toaster.infoToast(
          context: context, message: 'Persons cannot be empty or zero');
      return false;
    }

    if ((experienceHelper.locationExperience ?? '').isEmpty) {
      isValidate = false;
      Toaster.infoToast(context: context, message: 'Location cannot be empty');
      return false;
    }
    // if ((experienceHelper.subHostName ?? '').isEmpty) {
    //   isValidate = false;
    //   Toaster.infoToast(
    //       context: context, message: 'SubHost Name cannot be empty');
    //   return false;
    // }
    // if ((experienceHelper.subHostMobileNumber ?? '').isEmpty) {
    //   isValidate = false;
    //   Toaster.infoToast(
    //       context: context, message: 'SubHost Mobile Number cannot be empty');
    //   return false;
    // }

    if (experienceHelper.selectedWowFactors.isEmpty) {
      isValidate = false;
      Toaster.infoToast(context: context, message: 'Select Wow Factor');
      return false;
    }

    if (experienceHelper.selectedPerferencesFactors.isEmpty) {
      isValidate = false;
      Toaster.infoToast(context: context, message: 'Select Perfernces Factor');
      return false;
    }

    return isValidate;
  }
}
