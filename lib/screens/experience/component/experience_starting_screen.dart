import '../../../helpers/color_helper.dart';
import '../../../helpers/helpers.dart';
import '../../../setup.dart';
import 'create_experience_screen_v.dart';

class ExperienceStartingScreen extends StatelessWidget {
   ExperienceStartingScreen({Key? key}) : super(key: key);
   final _navigation = locateService<INavigationService>();

  final List<StepsRow> stepsRow = [
    StepsRow(
      description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit" ,
      iconPath: "assets/images/icons/tick_mark.png",
    ),
    StepsRow(
      description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit" ,
      iconPath: "assets/images/icons/tick_mark.png",
    ),
    StepsRow(
      description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit" ,
      iconPath: "assets/images/icons/tick_mark.png",
    ),
    StepsRow(
      description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit" ,
      iconPath: "assets/images/icons/tick_mark.png",
    ),
    // Add more custom rows as needed
  ];

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/exp_background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
    Colors.white.withOpacity(0.5), // Set the desired opacity value here (0.0 - 1.0)
    BlendMode.dstATop,
          ),
        ),
        ),
        child: Center(
          child:
          Column(
            children: [
              const SizedBox(height: 82.6),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,children: [
                Image.asset(
                  "assets/images/logo_icon.png",
                  // color: Colors.white,
                  width: 69,
                  height: 72,
                ),
                const SizedBox(width: 8.2),
                GeneralText(
                  "04 Steps",
                  style: appTheme
                      .typographies.interFontFamily.headline6
                      .copyWith(
                    fontSize: 35,
                    color: HexColor.fromHex('#ffffff'),
                  ),
                ),
              ]),
              Expanded(
                child: ListView.builder(
                  itemCount: stepsRow.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(34, 0, 42, 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            stepsRow[index].iconPath,
                            // color: Colors.white,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: GeneralText(
                              stepsRow[index].description,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HexColor.fromHex('#ffffff'),
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(height: 217),
              _okayButtonTitle(appTheme: appTheme),
              SizedBox(height: 87),
            ],
          ),
        ),
      ),
    );
  }

  Widget _okayButtonTitle({required IAppThemeData appTheme}) {
     return GeneralButton.button(
       width: 180,
       title: "okay".toUpperCase(),
       styleType: ButtonStyleType.fill,
       onTap: () {
         _navigation.navigateTo(route: CreateExperienceRoute());
       },
     );
   }

}

class StepsRow {
  final String description;
  final String iconPath;

  StepsRow({required this.description, required this.iconPath});
}

