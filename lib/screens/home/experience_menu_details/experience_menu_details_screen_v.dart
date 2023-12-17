import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/home/widget/popular_food_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/color_helper.dart';
import '../../../helpers/experience_helper.dart';
import '../../../models/experience/schedule_list_display.dart';
import '../../../models/home/experience_list_response.dart';
import '../../../models/home/food_details_menu_model.dart';

import '../../../setup.dart';
import 'experience_menu_details_screen_m.dart';
import 'experience_menu_details_screen_vm.dart';

import 'dart:developer' as developer;

import '../../../models/home/experience_list_response.dart' as experience_data;

class ExperienceMenuDetailsScreen
    extends BaseView<ExperienceMenuDetailsScreenViewModel> {
  ExperienceMenuDetailsScreen({
    required int expId,
    required experience_data.T experienceData,
    Key? key,
  })  : _expId = expId,
        _experienceData = experienceData,
        super(key: key);

  final int _expId;
  final experience_data.T _experienceData;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final appTheme = AppTheme.of(context).theme;
    viewModel.getExperienceMenu(experienceId: _expId.toString());
    return BlocBuilder<ExperienceMenuDetailsScreenViewModel,
            ExperienceMenuDetailsScreenState>(
        bloc: viewModel,
        builder: (_, state) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              // displayActionButton(context),
              body: state.when(
                  loading: displayLoader,
                  loaded: (foodMenu, scheduleData) => _displayLoadedData(
                        context,
                        appTheme,
                        state,
                        foodMenu,
                        scheduleData,
                        // wowFactor,
                        // preferences,
                      )),
            ),
          );
        });
  }

  Widget displayLoader() {
    return const GeneralLoading();
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
              onTap: () {},
              child: SvgPicture.asset(
                Resources.getSignInLeftArrow,
                color: const Color(0xfff1c452),
              ),
            ),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                Resources.getSignInRightArrow,
                color: const Color(0xfff1c452),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _displayLoadedData(
    BuildContext context,
    appTheme,
    state,
    FoodMenuModel foodMenuModel,
    ScheduleData scheduleData,
  ) {
    return FoodDetailScreen(
      foodMenuModel: foodMenuModel, experienceData: _experienceData,
      scheduleData: scheduleData,
      experienceMenuDetailsScreenViewModel: viewModel,
      // expResponse: expResp,
      // wowFactor: wowFactor,
      // preferences: preferences,
    );
  }
}

class SocialMediaHandles {
  String? socialMediaName;
  String? socialMediaIcon;

  SocialMediaHandles({this.socialMediaIcon, this.socialMediaName});
}
