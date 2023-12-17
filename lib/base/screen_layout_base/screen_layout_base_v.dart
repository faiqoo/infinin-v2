import 'package:chef/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/services/device/device_service.dart';
import 'package:chef/setup.dart';
import 'package:chef/ui_kit/widgets/general_search_bar.dart';
import 'package:chef/base/screen_layout_base/screen_layout_base_m.dart';
import 'package:chef/base/screen_layout_base/screen_layout_base_vm.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../models/booking/booking_overview.dart';
import '../../screens/home/home_page/home_screen_v.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';

mixin ScreenLayoutBase on StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static const _mobileSearchbarPadding = 4.0;
  static const _tabletSearchbarPadding = 36.0;
  static const _topMobilePadding = 23.0;
  @override
  Widget build(BuildContext context) {
    return buildScreen(
      context: context,
      screenSizeData: locateService<IDeviceService>().screenSizeData(),
    );
  }

  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    final viewModel = locateService<ScreenLayoutBaseViewModel>();

    return BlocBuilder<ScreenLayoutBaseViewModel, ScreenLayoutBaseState>(
      bloc: viewModel..fetchPreSelectedWorkspace(context),
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: HexColor.fromHex("#212129"),
              key: _scaffoldKey,
              body: screenSizeData.screenType == ScreenType.small
                  ? _buildMobileView(
                      context: context,
                      screenSizeData: screenSizeData,
                      state: state,
                      viewModel: viewModel,
                    )
                  : Container()),
        );
      },
    );
  }

  Widget _buildMobileView({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
    required ScreenLayoutBaseViewModel viewModel,
    required ScreenLayoutBaseState state,
  }) {
    final appTheme = AppTheme.of(context).theme;
    final _appService = locateService<ApplicationService>();
    return Column(
      children: [
        const SizedBox(
          height: _mobileSearchbarPadding,
        ),
        // _extoSearchBar(
        //   isTablet: false,
        //   context: context,
        //   state: state,
        //   viewModel: viewModel,
        // ),
        Padding(
          // padding: const EdgeInsets.only(
          //   top: _topMobilePadding,
          // ),

          padding: const EdgeInsets.only(
            left: 12,
            top: 20,
            bottom: 20,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => viewModel.backTo(),
                child: SvgPicture.asset(
                  Resources.appBackIconSVG,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 13,
              ),

              if (_appService.state.titlePage != null) ...[
                const Spacer(),
                GeneralText(
                  _appService.state.titlePage ?? '',
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline5
                      .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                ),
              ],

              // if (rightIcon != null)
              ...[
                const Spacer(),
                InkWell(
                  onTap: () {
                    // developer.log(' Transferring to home page');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreenView()),
                    );
                  },
                  child: SvgPicture.asset(
                    Resources.homeIconSvg,
                    height: 25,
                  ),
                ),
                const SizedBox(
                  width: 26,
                ),
              ]
              // Expanded(
              //   child: _extoSearchBar(
              //     isTablet: false,
              //     context: context,
              //     state: state,
              //     viewModel: viewModel,
              //   ),
              // )
            ],
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.only(
        //     left: 12,
        //     top: 20,
        //     bottom: 20,
        //   ),
        // const GeneralNewAppBar(
        //   rightIcon: Resources.homeIconSvg,
        //   title: Strings.labelNewBookings,
        //   titleColor: Colors.white,
        // ),
        // ),
        Expanded(
          child: body(
            context,
            screenSizeData,
          ),
        ),
      ],
    );
  }

  Widget displayRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image.asset(Resources.appBackIcon,height: 35,),
        InkWell(
            onTap: () {
              // Navigator.pop(context);
              // _navigation.pop();
            },
            child: SvgPicture.asset(
              Resources.appBackIconSVG,
              height: 33,
            )),
        GeneralNewAppBar()
        // if (title != null) ...[
        //   Spacer(),
        //   GeneralText(
        //     title ?? '',
        //     textAlign: TextAlign.center,
        //     style: appTheme.typographies.interFontFamily.headline5.copyWith(
        //         color: titleColor, fontWeight: FontWeight.bold, fontSize: 23),
        //   ),
        // ],
        // if (rightIcon != null) ...[
        //   const Spacer(),
        //   InkWell(
        //     onTap: () {
        //       developer.log(' Transferring to home page');
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => HomeScreenView()),
        //       );
        //     },
        //     child: SvgPicture.asset(
        //       rightIcon!,
        //       height: 25,
        //     ),
        //   ),
        //   const SizedBox(
        //     width: 26,
        //   ),
        // ]
      ],
    );
  }

  Widget body(
    BuildContext context,
    ScreenSizeData screenSizeData,
  );

  Future<void> suffixIconTap(BuildContext context);
  void onSearchChange(String value);
}
