import 'package:chef/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/booking/booking_overview.dart';
import '../home_screen.dart';
import 'home_screen_m.dart';
import 'home_screen_vm.dart';

class HomeScreenView extends BaseView<HomeScreenViewModel> {
  HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    final appTheme = AppTheme.of(context).theme;

    return BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        // bloc: viewModel..initialize(),
        bloc: viewModel..loadBookingOverview(),
        builder: (context, state) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                backgroundColor: appTheme.colors.primaryBackground,
                body: state.when(
                    loading: _loading,
                    loaded: (bookingOverview) =>
                        displayLoaded(viewModel, bookingOverview)),
              ));
        });
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayLoaded(
      HomeScreenViewModel viewModel, BookingOverview bookingOverview) {
    return LoungeHomeScreen(
      bookingOverview: bookingOverview,
      homeScreenViewModel: viewModel,
    );
  }
}
