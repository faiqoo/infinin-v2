import 'package:chef/models/experience/experience_response.dart' as exp_resp;

import '../../../helpers/experience_helper.dart';
import '../../../helpers/helpers.dart';

import '../../../helpers/menu_helper.dart' as menu_help;
import '../../../models/dish/dish_response.dart' as dish;
import '../../../models/meal/meal_response.dart' as meal;

import '../../../models/meal/menu_response.dart' as menu_resp;
import '../../../setup.dart';
import '../../../models/meal/menu_request.dart' as menu_req;
import '../schedule/create_schedule_view.dart';
import '../schedule_screen_v.dart';
import 'menu_experience_screen_m.dart' as menu_exp;

import 'dart:developer' as developer;

@injectable
class MenuExperienceScreenViewModel
    extends BaseViewModel<menu_exp.MenuExperienceScreenState> {
  int menuSaveCounter = 0;

  menu_resp.MenuResponse? menueResponse;

  var menueResponseCode = 0;
  final TextController descriptionController = TextController();
  final TextController dishController = TextController();
  final TextController priceController = TextController();
  final TextController servingController = TextController();
  // MenuExperienceScreenViewModel(MenuExperienceScreenState state) : super(state);


  bool isEnable = false;

  MenuExperienceScreenViewModel({
    required INavigationService navigation,
    required INetworkService network,
  })  : _navigation = navigation,
        _network = network,
        super(const menu_exp.Loading());
  final INavigationService _navigation;
  final INetworkService _network;

  //MenuExperienceScreenViewModel(MenuExperienceScreenViewModel state) : super(state);
  late final meal.MealResponse _mealResponse;
  late final dish.DishList _dishResponse;

  initialize() {
    emit(const menu_exp.Loading());
    loadMealList();
    // loadWowFactors();
  }

  void loadMealList() async {
    //http://18.202.117.137:8080/feyst-service/wow-factor/list

    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.mealAPI);

    // T t = loginrequest.T(
    //   mobileNo: mobileNumber,
    // );

    final requestMealList = LoginRequest(
      t: T(),
    ).toJson();

    final _header = <String, String>{
      Api.headerAcceptKey: Api.headerAcceptTypeValue
    };
    final response = await _network.post(
      path: url,
      data: requestMealList,
    );

    _mealResponse = meal.mealResponseFromJson(response.body);
    loadDishList();
  }

  void loadDishList() async {
    //http://18.202.117.137:8080/feyst-service/wow-factor/list

    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.dishAPI);

    // T t = loginrequest.T(
    //   mobileNo: mobileNumber,
    // );

    final requestMealList = LoginRequest(
      t: T(),
    ).toJson();

    final _header = <String, String>{
      Api.headerAcceptKey: Api.headerAcceptTypeValue
    };
    final response = await _network.post(
      path: url,
      data: requestMealList,
    );

    _dishResponse = dish.dishListFromJson(response.body);
    emit(menu_exp.Loaded(_mealResponse, _dishResponse));
  }

  void saveMenu(BuildContext context,{Function? completion}) async {
    final _appService = locateService<ApplicationService>();
    developer.log(' Ready to save Menu');
    menuSaveCounter += 1;

    menu_help.MenuHelper menuHelper = (_appService.state.menuHelper)!;
    if (!validateData(context, menuHelper)) {
      return;
    }
    exp_resp.ExperienceResponse experienceResponse =
        (_appService.state.experienceResponse)!;

    developer.log(' Meal Id  ' '${menuHelper.selectedMealId}');

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MenuExperienceScreen()),
    // );

    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.menuSave);

    //getList(experienceHelper.selectedWowFactors,'wow');
    menu_req.T t = menu_req.T(
      dish: menuHelper.selectedDishName,
      baseDishId: menuHelper.selectedDishId,
      mealId: menuHelper.selectedMealId,
      experienceId: (experienceResponse.t!.id)!,
      description: menuHelper.givenDescription,
      price: menuHelper.dishServingNoOfPerson,
      pictureUrl: '',
      baseDishName: menuHelper.selectedBaseDishName,
      mealName: menuHelper.selectedBaseMealNameCategory,
    );

    final menuData = menu_req.MenuRequest(
      t: t,
    ).toJson();

    // final signUpCredentials = SignupRequest(
    //   t: t,
    // ).toJson();
    final response = await _network
        .post(
          path: url,
          data: menuData,
          //   accessToken: false,
        )
        .whenComplete(() {});

    if (response != null) {
      developer
          .log(' Response of Menu Submited data is  ' '${response.body}');

      menu_resp.MenuResponse menuResponse =
          menu_resp.menuResponseFromJson(response.body);
      menueResponseCode = menuResponse.code ?? 0;
      Toaster.infoToast(
          context: context, message: menuResponse.message.toString());
      clearEntries(menuHelper);
      completion!();
    } else {
      Toaster.infoToast(context: context, message: 'Please fill the data');
      developer.log(' Response of Menu is ');
    }
  }

  bool validateData(BuildContext context, menu_help.MenuHelper menuHelper) {
    var isValidate = true;
    if (((menuHelper.selectedDishName)! ?? '').isEmpty) {
      isValidate = false;
      Toaster.infoToast(context: context, message: 'Dish Name cannot be empty');
      return false;
    }
    if ((menuHelper.givenDescription ?? '').isEmpty) {
      isValidate = false;
      Toaster.infoToast(
          context: context, message: 'Descriptions cannot be empty');
      return false;
    }
    if ((menuHelper.givenPrice) > 0) {
    } else {
      isValidate = false;
      Toaster.infoToast(context: context, message: 'Price cannot be empty');
      return false;
    }
    if ((menuHelper.dishServingNoOfPerson ?? 0) > 0) {
    } else {
      isValidate = false;
      Toaster.infoToast(
          context: context,
          message: 'Dish Serving Person cannot be empty or zero');
      return false;
    }

    return isValidate;
  }

  void clearEntries(menu_help.MenuHelper menuHelper) {
    menuHelper.selectedDishName = '';
    menuHelper.givenDescription = '';
    menuHelper.givenPrice = 0;
    menuHelper.dishServingNoOfPerson = 0;
    final _appService = locateService<ApplicationService>();

    descriptionController.clear();
    dishController.clear();
    priceController.clear();
    servingController.clear();

    if ((_appService.state.experienceHelper!.priceExperience) != null) {
      if (_appService.state.experienceHelper!.priceExperience == 0.00001) {
        priceController.text = "0.0";
        menuHelper.givenPrice = 0.0;
        isEnable = true;
      } else {
        menuHelper.givenPrice =
        (_appService.state.experienceHelper!.priceExperience)!;
        priceController.text =
            (_appService.state.experienceHelper!.priceExperience)!.toString();
      }
    }

    if ((_appService.state.experienceHelper!.personExperience) != null) {
      servingController.text =
          (_appService.state.experienceHelper!.personExperience)!.toString();
      menuHelper.dishServingNoOfPerson =
          (_appService.state.experienceHelper!.personExperience)!;
    }
  }
}
