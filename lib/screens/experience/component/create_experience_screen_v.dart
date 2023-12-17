import 'package:chef/helpers/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/color_helper.dart';
import '../../../helpers/experience_helper.dart';
import '../../../models/preference.dart';
import '../../../models/wow_factor/wow_factor_response.dart';
import '../../../setup.dart';
import 'menu_experience_screen_v.dart';

import 'dart:developer' as developer;

import '../widget/experience_manager.dart';
import 'create_experience_screen_m.dart';
import 'create_experience_screen_vm.dart';

class CreateExperienceScreen extends BaseView<CreateExperienceScreenViewModel> {
  CreateExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final appTheme = AppTheme.of(context).theme;
    viewModel.initialize();
    return BlocBuilder<CreateExperienceScreenViewModel,
            CreateExperienceScreenState>(
        bloc: viewModel,
        builder: (_, state) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              floatingActionButton: displayActionButton(context),
              body: state.when(
                  loading: displayLoader,
                  loaded: (wowFactor, preferences, cityResponse) => _displayLoadedData(
                        context,
                        appTheme,
                        state,
                        wowFactor,
                        preferences,
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
              onTap: () {
                Navigator.pop(ctx);
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
                viewModel.saveExperience(ctx);
              },
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
    WowFactorResponse wowFactor,
    PreferenceResponse preferences
  ) {
    return ExperienceManager(
      wowFactor: wowFactor,
      preferences: preferences,
      viewModel: viewModel,
    );
  }
}

class SocialMediaHandles {
  String? socialMediaName;
  String? socialMediaIcon;

  SocialMediaHandles({this.socialMediaIcon, this.socialMediaName});
}
