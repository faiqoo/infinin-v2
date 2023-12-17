import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:chef/models/profile/profile_details_response_model.dart' as chef_details_response;
import 'package:chef/services/network/network_service.dart';
import 'package:injectable/injectable.dart';
import '../../../constants/api.dart';
import '../../../services/application_state.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../../setup.dart';
import 'chef_profile_screen_m.dart';
import 'dart:developer' as developer;

@injectable
class ChefProfileDetailsScreenViewModel
    extends BaseViewModel<ChefProfileDetailsScreenState> {
  ChefProfileDetailsScreenViewModel({
    required INetworkService network,
    required INavigationService navigation,
  })  : _navigation = navigation,
      _network = network,
        super(const Loading());

  final INetworkService _network;
  final INavigationService _navigation;


  void initialize() {
    loadChefDetails();
    // emit(Loaded(profileDetails));
  }

  late chef_details_response.ProfileDetails profileDetails;


  Future<void> loadChefDetails() async {
    final url = InfininHelpers.getRestApiURL(Api.baseURL + Api.chefFindById);
    // emit(const Loading());

    final _appService = locateService<ApplicationService>();

    emit(const Loading());

    final chefDetailsRequest = {
      "t": _appService.state.userInfo?.t.id??0,
    };

    final response = await _network.post(
      path: url,
      data: chefDetailsRequest,
    );

    developer.log(response.body);

    if (response != null) {
      profileDetails = chef_details_response.profileDetailsFromJson(response.body);
      emit(Loaded(profileDetails));
    }
  }

}
