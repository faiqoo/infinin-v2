import 'package:chef/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../screens/home/home_page/home_screen_v.dart';
import '../../screens/home/home_screen.dart';
import '../../services/navigation/navigation_service.dart';
import '../../setup.dart';
import '../../theme/app_theme_widget.dart';
import 'general_text.dart';

import 'dart:developer' as developer;

class GeneralNewAppBar extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? rightIcon;
  const GeneralNewAppBar(
      {Key? key, this.title, this.titleColor, this.rightIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    final _navigation = locateService<INavigationService>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image.asset(Resources.appBackIcon,height: 35,),
        InkWell(
            onTap: () {
              Navigator.pop(context);
              // _navigation.pop();
            },
            child: SvgPicture.asset(
              Resources.appBackIconSVG,
              height: 33,
            )),
        if (title != null) ...[
          const Spacer(),
          GeneralText(
            title ?? '',
            textAlign: TextAlign.center,
            style: appTheme.typographies.interFontFamily.headline5.copyWith(
                color: titleColor, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ],
        if (rightIcon != null) ...[
          const Spacer(),
          InkWell(
            onTap: () {
              developer.log(' Transferring to home page');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreenView()),
              );
            },
            child: SvgPicture.asset(
              rightIcon!,
              height: 25,
            ),
          ),
          const SizedBox(
            width: 26,
          ),
        ]
      ],
    );
  }
}
