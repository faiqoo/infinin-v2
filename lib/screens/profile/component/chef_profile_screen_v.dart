import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/profile/profile_details_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_profile_v.dart';
import 'chef_profile_screen_m.dart';
import 'chef_profile_screen_vm.dart';

class ChefProfileDetailsScreenView
    extends BaseView<ChefProfileDetailsScreenViewModel> {
  ChefProfileDetailsScreenView({Key? key}) : super(key: key);

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayLoaded(ChefProfileDetailsScreenViewModel viewModel,
      ProfileDetails profileDetails) {
    return UserProfileScreen(
      chefProfileDetailsScreenViewModel: viewModel,
      profileDetails: profileDetails,
    );
  }

  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    // TODO: implement body
    final appTheme = AppTheme.of(context).theme;
    return BlocBuilder<ChefProfileDetailsScreenViewModel,
            ChefProfileDetailsScreenState>(
        bloc: viewModel..initialize(),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.colors.primaryBackground,
            body: state.when(
                loading: _loading,
                loaded: (profileDetails) =>
                    displayLoaded(viewModel, profileDetails)),
          );
        });
  }
}
