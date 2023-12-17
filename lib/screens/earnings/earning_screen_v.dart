import 'package:chef/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_rich_text.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../booking/food_item_bookng.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
 

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: HexColor.fromHex("#212129"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 12),
            child: GeneralNewAppBar(
              title: Strings.earningScreenAppBarTitle,
              titleColor: Colors.white,
              rightIcon: Resources.homeIconSvg,
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(right: 38.0),
                  child: Row(

                    children: [
                      GeneralText(
                        Strings.earningThisMonthLabel.toUpperCase(),
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.keyboard_arrow_down,color: Colors.white,),

                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),

                Stack(
                  children: [
                    Image.asset(Resources.earningBG1PNG,height: 230,width: 280,),
                    Positioned.fill(
                      right: 13,
                      bottom: 25,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(Resources.earningBG2PNG,height: 168,width: 258,)),
                    ),

                    Positioned.fill(
                      top: 100,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              GeneralText(
                                'Rs. 8,000',
                                style: appTheme.typographies.interFontFamily.headline6
                                    .copyWith(
                                    fontSize: 19,
                                    color: Color(0xff212129),
                                    fontWeight: FontWeight.bold),
                              ),
                              GeneralText(
                                  Strings.earningThisMonthLabel,
                                style: appTheme.typographies.interFontFamily.headline6
                                    .copyWith(
                                    fontSize: 13,
                                    color: Color(0xff212129),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],

                          ),


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GeneralText(
                                'Rs. 40,000',
                                style: appTheme.typographies.interFontFamily.headline6
                                    .copyWith(
                                    fontSize: 19,
                                    color: Color(0xffbb3127),
                                    fontWeight: FontWeight.bold),
                              ),
                              GeneralText(
                                  Strings.earningTotalEarningLabel,
                                style: appTheme.typographies.interFontFamily.headline6
                                    .copyWith(
                                    fontSize: 13,
                                    color: Color(0xff212129),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],

                          ),
                        ],),
                      ),
                    ),
                    Positioned.fill(
                      top: 65,
                      right: 12,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(bottom:50),
                          height: 53,
                          width: 1.5,
                          color: Color(0xff707070),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                      Container(
                        height: 2,
                      width: 93,
                      color: Colors.white,


                    ),
                    GeneralText(
                      '10 Oct 2022',
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 2,
                      width: 93,
                      color: Colors.white,


                    ),
                  ],
                ),
                SizedBox(height: 16,),
                earningItemList(appTheme),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget earningItemList(IAppThemeData appTheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.zero,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: HexColor.fromHex("#4b4b52"),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GeneralText(
                              Strings.earningPaidLabel,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                      fontSize: 12,
                                      color: Color(0xff909094),
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                Resources.earningPaidPNG,
                                height: 48,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              GeneralText(
                                '10,000',
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        fontSize: 13,
                                        color: Color(0xff8ea659),
                                        fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GeneralText(
                            Strings.earningPendingLabel,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                                    fontSize: 12,
                                    color: Color(0xff909094),
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            children: [
                              GeneralText(
                                '14,562',
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        fontSize: 13,
                                        color: Color(0xfff89f84),
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Image.asset(
                                Resources.earningPendingPNG,
                                height: 48,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  GeneralText(
                    Strings.earningDescriptionLabel,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            fontSize: 13,
                            color: Colors.white,

                            fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }),
    );
  }

}

 
