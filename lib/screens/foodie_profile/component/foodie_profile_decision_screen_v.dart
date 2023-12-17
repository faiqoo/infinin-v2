import 'package:chef/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/booking/booking_status.dart';
import '../../../models/booking/order_detail_response.dart';
import '../../../models/foodie/foodie_details_response.dart';
import '../foodie_profile_decision.dart';
// import '../order_screen.dart';
import 'foodie_profile_decision_screen_m.dart';
import 'foodie_profile_decision_screen_vm.dart';

class FoodieProfileDecisionScreenView
    extends BaseView<FoodieProfileDecisionScreenViewModel>
// with ScreenLayoutBase

{
  FoodieProfileDecisionScreenView({required String bookingId, Key? key})
      : _bookingId = bookingId,
        super(key: key);

  final String _bookingId;

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayLoaded(FoodieProfileDecisionScreenViewModel viewModel,
      OrderDetails orderDetails) {
    return FoodieProfileRequiredPending(
      foodieProfileDecisionScreenViewModel: viewModel,
      orderDetails: orderDetails,
      // bookingStatus: bookingStatus,
      // orderViewModel: viewModel,
    );
  }

  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    // TODO: implement body
    final appTheme = AppTheme.of(context).theme;

    return BlocBuilder<FoodieProfileDecisionScreenViewModel,
            FoodieProfileDecisionScreenState>(
        bloc: viewModel..initialize(_bookingId),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.colors.primaryBackground,
            body: state.when(
                loading: _loading,
                loaded: (foodieDetails) =>
                    displayLoaded(viewModel, foodieDetails)),
          );
        });
  }

// @override
  // Widget body(BuildContext context, ScreenSizeData screenSizeData) {
  //   // TODO: implement body
  //   final appTheme = AppTheme.of(context).theme;
  //
  //   return BlocBuilder<FoodieProfileDecisionScreenViewModel,
  //           FoodieProfileDecisionScreenState>(
  //       bloc: viewModel..initialize(_bookingId),
  //       builder: (context, state) {
  //         return Scaffold(
  //           backgroundColor: appTheme.colors.primaryBackground,
  //           body: state.when(
  //               loading: _loading,
  //               loaded: (foodieDetails) =>
  //                   displayLoaded(viewModel, foodieDetails)),
  //         );
  //       });
  // }

  // @override
  // void onSearchChange(String value) {
  //   // TODO: implement onSearchChange
  // }
  //
  // @override
  // Future<void> suffixIconTap(BuildContext context) {
  //   // TODO: implement suffixIconTap
  //   throw UnimplementedError();
  // }
}
