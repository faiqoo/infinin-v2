import 'package:chef/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/booking/booking_status.dart';
import '../order_screen.dart';
import 'order_screen_m.dart';
import 'order_screen_vm.dart';

class OrderScreenView extends BaseView<OrderScreenViewModel>
    with ScreenLayoutBase {
  OrderScreenView({required String type, Key? key})
      : _type = type,
        super(key: key);

  String _type;

  // @override
  // Widget buildScreen(
  //     {required BuildContext context, required ScreenSizeData screenSizeData}) {
  //   final appTheme = AppTheme.of(context).theme;
  //
  //   return BlocBuilder<OrderScreenViewModel, OrderScreenState>(
  //       bloc: viewModel..loadBookingOverview(),
  //       builder: (context, state) {
  //         return Scaffold(
  //           backgroundColor: appTheme.colors.primaryBackground,
  //           body: state.when(
  //               loading: _loading,
  //               loaded: (bookingStatus) =>
  //                   displayLoaded(viewModel, bookingStatus)),
  //         );
  //       });
  // }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayLoaded(
      OrderScreenViewModel viewModel, BookingStatus bookingStatus) {
    return OrderScreen(
      bookingStatus: bookingStatus,
      orderViewModel: viewModel,
      type: _type,
    );
  }

  @override
  Widget body(BuildContext context, ScreenSizeData screenSizeData) {
    // TODO: implement body
    final appTheme = AppTheme.of(context).theme;

    return BlocBuilder<OrderScreenViewModel, OrderScreenState>(
        bloc: viewModel..loadBookingOverview(_type),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.colors.primaryBackground,
            body: state.when(
                loading: _loading,
                loaded: (bookingStatus) =>
                    displayLoaded(viewModel, bookingStatus)),
          );
        });
  }

  @override
  void onSearchChange(String value) {
    // TODO: implement onSearchChange
  }

  @override
  Future<void> suffixIconTap(BuildContext context) {
    // TODO: implement suffixIconTap
    throw UnimplementedError();
  }
}
