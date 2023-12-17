import 'package:chef/models/experience/experience_request.dart' as expreq;

import '../../../helpers/experience_helper.dart';
import '../../../helpers/helpers.dart';
import 'package:chef/helpers/data_request.dart' as data_request;

import '../../../models/experience/experience_request.dart'
    as experience_request;
import '../../../models/experience/experience_response.dart' as expresp;
import '../../../models/preference.dart' as preference;
import '../../../models/signup/responses/city_response.dart' as city_resp;
import '../../../models/signup/responses/town_response.dart' as town_resp;
import '../../../models/wow_factor/wow_factor_response.dart' as wowfactor;

import '../../../setup.dart';
import 'menu_experience_screen_v.dart';
import 'create_experience_screen_m.dart' as create_experience;

import 'dart:developer' as developer;

@injectable
class CreateExperienceScreenViewModel
    extends BaseViewModel<create_experience.CreateExperienceScreenState> {
  CreateExperienceScreenViewModel({
    required INavigationService navigation,
    required INetworkService network,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _navigation = navigation,
        _network = network,
        _storage = storage,
        _appService = appService,
        super(const create_experience.Loading());
  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;
  final ApplicationService _appService;

  late final wowfactor.WowFactorResponse _wowFactorResponse;
  late final preference.PreferenceResponse _preferenceResponse;

  late city_resp.CityResponse cityResponse;
  late town_resp.TownResponse townResponse;

  final TextController townController = TextController();
  final TextController cityController = TextController();

  late final cityDropDown = <String>[];
  late final townDropDown = <String>[];

  final cityInfo = {};
  final townInfo = {};

  final Map<String, List<String>> cityTownInfo = {};

  int selectedCityId = 0;
  int selectedTownId = 0;

  void getCityId(String cityName, {city_resp.CityResponse? cityDetails}) {
    if (cityDetails != null) {
      cityResponse = cityDetails;
    }
    for (var i = 0; i < cityResponse.t.length; i++) {
      //  if (cityName == cityResponse.t[i].name && cityResponse.t[i].id == 1) {
      //  if (cityName == cityResponse.t[i].name) {
      developer.log(' City Id is ' '${cityResponse.t[i].id}');
      // townDropDown.clear();
      // townDropDown.add('Select');
      //  townDropDown.clear();
      //townDropDown.clear();
      selectedCityId = cityResponse.t[i].id;
      loadTownList(
          cityId: cityResponse.t[i].id, cityName: cityResponse.t[i].name);
      //  }
    }
  }

  initialize() {
    loadWowFactors();
  }

  void saveExperience(BuildContext context) async {
    final _appService = locateService<ApplicationService>();
    developer.log(' Ready to save');
    developer
        .log(' Chef Id User Id is  ' '${_appService.state.userInfo!.userId}');

    developer.log(' Chef Name is   ' + _appService.state.userInfo!.t.name);

    developer.log(
        ' Chef Brand Name is   ' + _appService.state.userInfo!.t.brandName);

    developer
        .log(' Chef Address is   ' + _appService.state.userInfo!.t.address);

    developer.log(' Chef Id In T is   ' '${_appService.state.userInfo!.t.id}');
    ExperienceHelper experienceHelper = (_appService.state.experienceHelper)!;

    developer
        .log(' priceExperience Details ' '${experienceHelper.priceExperience}');

    developer
        .log(' numberOfPerson Details ' '${experienceHelper.numberOfPerson}');

    developer.log(' subHostName Details ' '${experienceHelper.subHostName}');

    developer.log(' selected WowFactors Number  Details '
        '${experienceHelper.selectedWowFactors.values}');

    developer.log(' selected PreferencesFactors Number  Details '
        '${experienceHelper.selectedPerferencesFactors.values}');

    if (!validateData(context, experienceHelper)) {
      return;
    }
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.experienceSave);

    experience_request.T t = experience_request.T(
      title: experienceHelper.titleExperience ?? '',
      description: experienceHelper.experienceDetails ?? '',
      persons: experienceHelper.numberOfPerson.toString(),
      chefId: _appService.state.userInfo!.t.id,
      // chefAddress: experienceHelper.address!.isEmpty
      //     ? _appService.state.userInfo!.t.address
      //     : experienceHelper.address,
      // chefBrandName: _appService.state.userInfo!.t.address,
      chefName: _appService.state.userInfo!.t.name,
      locationId: 1,
      price: (experienceHelper.priceExperience ?? 0.0).toInt(),
      priceTypeId:
          (experienceHelper.priceExperience ?? 0.0).toString() == "0.00001"
              ? 2
              : 1,
      subHostMobileNo: experienceHelper.subHostMobileNumber ?? '',
      subHostName: experienceHelper.subHostName ?? '',
      wowFactorId: 1,
      preferenceId: 1,
      experienceWowFactors:
          getList(experienceHelper.selectedWowFactors, 'wow').toList(),
      experiencePreferences: getPreferenceList(
          experienceHelper.selectedPerferencesFactors, 'pref'),
      townName: townController.text.isNotEmpty ? townController.text : null,
      cityName: cityController.text.isNotEmpty ? cityController.text : null,
      cityId: cityInfo[cityController.text] != null
          ? cityInfo[cityController.text]
          : null,
      townId: townInfo[townController.text] != null
          ? townInfo[townController.text]
          : null,
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

    if (response != null) {
      developer.log(' Response of response body is ' '${response.body}');

      expresp.ExperienceResponse experienceResponse =
          expresp.experienceResponseFromJson(response.body);
      _appService.updateSaveExperience(experienceResponse);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuExperienceScreen()),
      );
    } else {
      Toaster.infoToast(
          context: context,
          message: 'Something is wrong please content vendor');
      developer.log(' Response of Create Experience is ' '$response');
    }
  }

  Future<void> loadCityList({
    required String baseUrl,
  }) async {
    developer.log(' Base Url is ' '$baseUrl');
    final url = InfininHelpers.getRestApiURL(baseUrl + Api.cityList);
    data_request.T t = data_request.T();

    final dataRequest = data_request.DataRequest(
      t: t,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: dataRequest,
    );
    cityResponse = city_resp.cityResponseFromJson(response.body);
    for (var i = 0; i < cityResponse.t.length; i++) {
      developer.log(' City data is ' + cityResponse.t[i].name);
      cityDropDown.add(cityResponse.t[i].name);
      cityInfo[cityResponse.t[i].name] = cityResponse.t[i].id;

      if (cityTownInfo.isEmpty) {
        getCityId(cityResponse.t[i].name);
      }
    }

    // emit(Loaded(cityResponse));
  }

  Future<void> loadTownList({cityId, required String cityName}) async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.townList);

    data_request.T t = data_request.T(cityId: cityId);
    final dataRequest = data_request.DataRequest(
      t: t,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: dataRequest,
    );
    townResponse = town_resp.townResponseFromJson(response.body);

    List<String> _townData = [];

    for (var i = 0; i < townResponse.t.length; i++) {
      _townData.add(townResponse.t[i].name);
    }
    cityTownInfo[cityName] = _townData;
    for (var i = 0; i < townResponse.t.length; i++) {
      if (!townDropDown.contains(townResponse.t[i].name)) {
        townInfo[townResponse.t[i].name] = townResponse.t[i].id;
        townDropDown.add(townResponse.t[i].name);
      }
    }
    emit(create_experience.Loaded(
        _wowFactorResponse, _preferenceResponse, cityResponse));
  }

  List<expreq.ExperienceWowFactor> getList(Map data, String type) {
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
    });

    developer.log('Data ready to send is ' '${alignData.length}');
    for (int i = 0; i < alignData.length; i++) {
      developer.log(' Wow factor is ' '${alignData[i]}');
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
        .log('Data ready to ExperiencePreference is ' '${alignData.length}');
    for (int i = 0; i < alignData.length; i++) {
      developer.log(' ExperiencePreference factor is ' '${alignData[i]}');
    }

    return alignData;
  }

  void loadWowFactors() async {
    //http://18.202.117.137:8080/feyst-service/wow-factor/list

    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.wowFactorAPI);

    // T t = loginrequest.T(
    //   mobileNo: mobileNumber,
    // );

    final requestWowFactor = LoginRequest(
      t: T(),
    ).toJson();

    final _header = <String, String>{
      Api.headerAcceptKey: Api.headerAcceptTypeValue
    };

    // final questionsDataRequest = questionirerequest.QuestionireRequest(
    //   t: questionirerequest.T(category: "CHEF_PROFILE"),
    // ).toJson();
    final response = await _network.post(
      path: url,
      data: requestWowFactor,
    );

    _wowFactorResponse = wowfactor.wowFactorResponseFromJson(response.body);
    loadPerferences();
  }

  void loadPerferences() async {
    //http://18.202.117.137:8080/feyst-service/wow-factor/list

    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.preferenceAPI);

    // T t = loginrequest.T(
    //   mobileNo: mobileNumber,
    // );

    final requestWowFactor = LoginRequest(
      t: T(),
    ).toJson();

    final _header = <String, String>{
      Api.headerAcceptKey: Api.headerAcceptTypeValue
    };

    // final questionsDataRequest = questionirerequest.QuestionireRequest(
    //   t: questionirerequest.T(category: "CHEF_PROFILE"),
    // ).toJson();
    final response = await _network.post(
      path: url,
      data: requestWowFactor,
    );

    // final preferenceResponse =
    _preferenceResponse = preference.preferenceResponseFromJson(response.body);
    loadCityList(baseUrl: Api.baseURL);
  }

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
    if ((experienceHelper.priceExperience ?? 0.0) >= 0.00001) {
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
