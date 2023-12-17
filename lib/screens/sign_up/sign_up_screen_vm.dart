import 'package:chef/helpers/helpers.dart';

// import '../../models/signup/signup_request.dart' as signuprequest;
import 'package:chef/models/signup/responses/signup_response.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../helpers/data_request.dart' as signuprequest;

import 'dart:developer' as developer;

import '../../models/signup/responses/city_response.dart';
import 'package:chef/helpers/data_request.dart' as data_request;

import '../../models/signup/responses/town_response.dart';

@injectable
class SignUpScreenViewModel extends BaseViewModel<SignUpScreenState> {
  SignUpScreenViewModel({
    required INavigationService navigation,
    required INetworkService network,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _navigation = navigation,
        _network = network,
        _storage = storage,
        _appService = appService,
        super(
          const Initialized(
            fullName: '',
            brandName: '',
            mobileNumber: '',
            address: '',
            // town: '',
            // city: '',
          ),
        );

  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;
  final ApplicationService _appService;

  final TextController townController = TextController();
  final TextController cityController = TextController();

  late final cityDropDown = <String>[];
  late final townDropDown = <String>[];

  final cityInfo = {};
  final townInfo = {};

  final Map<String, List<String>> cityTownInfo = {};
  late CityResponse cityResponse;
  late TownResponse townResponse;

  int selectedCityId = 0;
  int selectedTownId = 0;

  String? currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission({BuildContext? context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Toaster.errorToast(
        context: context!,
        message: 'Location services are disabled. Please enable the services',
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Toaster.errorToast(
          context: context!,
          message: 'Location permissions are denied',
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Toaster.errorToast(
        context: context!,
        message: 'Location permissions are permanently denied, we cannot request permissions.',
      );
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition({BuildContext? context,Function? completion}) async {
    final hasPermission = await _handleLocationPermission(context:context);
    if (!hasPermission) return;
    // emit(const Loading());
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // setState(() => _currentPosition = position);
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
      // emit(Loaded(cityResponse));
      completion!();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // setState(() {
        currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      // });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  void initialize() {
    emit(Loaded(cityResponse));
  }

  void getCityId(String cityName, {CityResponse? cityDetails}) {
    if (cityDetails != null) {
      cityResponse = cityDetails;
    }
    for (var i = 0; i < cityResponse.t.length; i++) {
      //  if (cityName == cityResponse.t[i].name && cityResponse.t[i].id == 1) {
      //  if (cityName == cityResponse.t[i].name) {
      developer.log(' City Id is ' + '${cityResponse.t[i].id}');
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

  ValueNotifier<bool> buttonEnabled = ValueNotifier(false);

  void changeButton(bool? value) {
    buttonEnabled.value = value ?? !buttonEnabled.value;
  }

  bool isValidUrl(String url) => Uri.tryParse(url)?.hasAbsolutePath ?? false;

  String updateUrl(String url) {
    if (!url.endsWith('/')) {
      url += '/';
    }
    if (!url.endsWith(Api.client)) {
      url += Api.client;
    }
    return url;
  }

  void onFormValuesChange({
    String? fullName,
    String? mobileNumber,
    String? address,
    String? brandName,
  }) =>
      emit(Initialized(
              fullName: fullName ?? '',
              mobileNumber: mobileNumber ?? '',
              brandName: brandName ?? '',
              address: address ?? '')
          .copyWith());

  bool _validateInput({
    required String name,
    required String brandName,
    required String mobileNumber,
    required String address,
    required String town,
    required String city,
  }) =>
      name.trim().isNotEmpty &&
      brandName.trim().isNotEmpty &&
      mobileNumber.trim().isNotEmpty &&
      address.trim().isNotEmpty &&
      town.trim().isNotEmpty &&
      city.trim().isNotEmpty;

  bool verifyInput({
    required String name,
    required String brandName,
    required String mobileNumber,
    required String address,
    required String city,
    required String town,
    required String baseUrl,
    required BuildContext context,
  }) {
    final isInputValid = _validateInput(
      name: name,
      mobileNumber: mobileNumber,
      address: address,
      brandName: brandName,
      city: city,
      town: town,
    );
    if (!isInputValid) {
      Toaster.errorToast(
        context: context,
        message: Strings.signUpFields,
      );
      return false;
    }
    return true;
  }

  bool verifyInputForm({
    required String name,
    required String brandName,
    required String mobileNumber,
    required String address,
    required String city,
    required String town,
  }) {
    final isInputValid = _validateInput(
      name: name,
      mobileNumber: mobileNumber,
      address: address,
      brandName: brandName,
      city: city,
      town: town,
    );
    if (!isInputValid) {
      return false;
    }
    return true;
  }

  Future<void> loadCityList({
    required String baseUrl,
  }) async {
    developer.log(' Base Url is ' + '${baseUrl}');
    final url = InfininHelpers.getRestApiURL(baseUrl + Api.cityList);
    data_request.T t = data_request.T();

    final dataRequest = data_request.DataRequest(
      t: t,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: dataRequest,
    );
    cityResponse = cityResponseFromJson(response.body);
    for (var i = 0; i < cityResponse.t.length; i++) {
      developer.log(' City data is ' + cityResponse.t[i].name);
      cityDropDown.add(cityResponse.t[i].name);
      cityInfo[cityResponse.t[i].name] = cityResponse.t[i].id;

      if (cityTownInfo.isEmpty) {
        getCityId(cityResponse.t[i].name);
      }
    }

    emit(Loaded(cityResponse));
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
    townResponse = townResponseFromJson(response.body);

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

    emit(const Loading());
    emit(Loaded(cityResponse));
  }

  Future<void> _cacheData({
    required BuildContext context,
    required loginData,
    required String baseUrl,
  }) async {
    // await _storage.writeBool(
    //   key: PreferencesKeys.sRememberUser,
    //   data:  state.rememberMe,
    //   // data: state.when(initialized: , loaded: loaded),
    // );
    await _storage.writeString(
      key: PreferencesKeys.sLoginData,
      data: loginData.toString(),
    );
    final loginDecodedData = jsonDecode(loginData.toString());
    //final currentUser = LoginResponse.fromJson(loginDecodedData);
    final currentUser = SignupResponse.fromJson(loginDecodedData);
    // await _storage.writeString(
    //   key: PreferencesKeys.sTenantId,
    //   data: currentUser.user.tenantId,
    // );
    await _storage.writeString(
      key: PreferencesKeys.sBaseUrl,
      data: baseUrl,
    );
    await _appService.loadPrefData();
  }

  void saveChef({
    required String name,
    required String brandName,
    required String mobileNumber,
    required String address,
    required String town,
    required String city,
    required BuildContext context,
    required String baseUrl,
  }) async {
    final isInputValid = _validateInput(
      name: name,
      brandName: brandName,
      mobileNumber: mobileNumber,
      address: address,
      town: town,
      city: city,
    );
    if (isInputValid) {
      emit(const Loading());
      try {
        final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.chefSignUp);
        signuprequest.T t = signuprequest.T(
          name: name,
          brandName: brandName,
          mobileNo: "+92$mobileNumber",
          address: address,
          townName: town,
          cityName: city,
          cityId: cityInfo[city],
          townId: townInfo[town],
          latitude: _currentPosition?.latitude.toInt(),
          longitude: _currentPosition?.longitude.toInt(),
        );
        final signUpCredentials = signuprequest.DataRequest(
          t: t,
        ).toJson();
        final response = await _network
            .post(
              path: url,
              data: signUpCredentials,
              //   accessToken: false,
            )
            .whenComplete(() {});
        if (response != null) {
          developer.log(' Response of Signup body is ' '${response.body}');

          SignupResponse signupResponse = signupResponseFromJson(response.body);

          Toaster.infoToast(context: context, message: signupResponse.message);
          await _cacheData(
            context: context,
            loginData: response.body,
            baseUrl: Api.baseURL,
          );

          developer.log(' Sign up Response is ' + signupResponse.message);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SignUpQuestionireScreen()),
          // );

          _navigation.replace(route: SignUpQuestionireRoute());
        } else {
          Toaster.infoToast(
              context: context,
              message: 'Something is wrong please content vendor');
        }
      } catch (error) {
        // emit(
        //   // state.copyWith(
        //   //   isBusy: false,
        //   //   errorMessage: error.toString().contains(Api.unauthorizedRequest)
        //   //       ? Strings.invalidUsernamePassword
        //   //       : error.toString(),
        //   // ),
        // );
      }
    } else {
      Toaster.errorToast(
        context: context,
        message: Strings.requiredFields,
      );
    }
  }

  void loading({required bool isBusy}) => emit(const Loading());
}
