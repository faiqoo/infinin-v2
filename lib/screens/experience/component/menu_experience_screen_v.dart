import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/dish/dish_response.dart';
import 'package:chef/models/meal/meal_response.dart';
import 'package:chef/screens/experience/schedule_screen_v.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/color_helper.dart';
import '../../../setup.dart';
import '../schedule/create_schedule_view.dart';
import '../widget/menu_manager.dart';
import 'menu_experience_screen_m.dart';
import 'menu_experience_screen_vm.dart';

class MenuExperienceScreen extends BaseView<MenuExperienceScreenViewModel> {
  MenuExperienceScreen({Key? key}) : super(key: key);

  final _appService = locateService<ApplicationService>();
  final _navigation = locateService<INavigationService>();

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final appTheme = AppTheme.of(context).theme;
    viewModel.initialize();
    return BlocBuilder<MenuExperienceScreenViewModel,
            MenuExperienceScreenState>(
        bloc: viewModel,
        builder: (_, state) {
          return WillPopScope(
            onWillPop: () async{
              return true;
            },
            child: Scaffold(
              backgroundColor: appTheme.colors.primaryBackground,
              floatingActionButton: displayActionButton(context),
              body: state.when(
                  loading: displayLoader,
                  loaded: (mealResponse, dishResponse) => _displayLoadedData(
                        context,
                        appTheme,
                        state,
                        mealResponse,
                        dishResponse,
                      )),
            ),
          );
        });
  }

  Widget displayLoader() {
    return const GeneralLoading();
  }

  _displayLoadedData(
    BuildContext context,
    appTheme,
    state,
    MealResponse mealResponse,
    DishList dishResponse,
  ) {
    return MenuManager(
      mealResponse: mealResponse,
      dishResponse: dishResponse,
      viewModel: viewModel,
    );
  }

  Widget displayActionButton(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        margin: const EdgeInsets.only(left: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const SignUpLetsStartScreen()),
                // );
              },
              child: SvgPicture.asset(
                Resources.getSignInLeftArrow,
                color: const Color(0xfff1c452),
              ),
            ),
            InkWell(
              onTap: () {
                final _appService = locateService<ApplicationService>();
                // _appService.state?.experienceHelper   =_experienceHelper;
                //_appService.updateExperienceHelper(viewModel.);
               // if(viewModel.menuSaveCounter>0   && viewModel.menueResponseCode==200){
                 if(viewModel.dishController.text.isNotEmpty||viewModel.descriptionController.text.isNotEmpty){
                   _navigation.navigateTo(route: ScheduleRoute());
                 }else{
                   Toaster.infoToast(
                       context: ctx,
                       message: 'Save the menu first or the data will be lost');
                 }
               // }else{
               //   Toaster.infoToast(
               //       context: ctx,
               //       message: 'Please Save at least one Menu');
               // }
              },
              child: SvgPicture.asset(
                Resources.getSignInRightArrow,
                color: Color(0xfff1c452),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
