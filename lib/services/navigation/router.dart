import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import 'package:chef/constants/constants.dart';
import 'package:chef/screens/screen.dart';
import 'package:chef/screens/sign_up/get_started_screen_v.dart';

import '../../screens/booking/component/order_screen_v.dart';
import '../../screens/experience/component/create_experience_screen_v.dart';
import '../../screens/experience/component/experience_starting_screen.dart';
import '../../screens/experience/schedule/create_schedule_view.dart';
import '../../screens/experience/show_off_screen_v.dart';
import '../../screens/foodie_profile/component/foodie_profile_decision_screen_v.dart';
import '../../screens/home/home_page/home_screen_v.dart';
import '../../screens/qr_scanner/qr_scanner_screen_v.dart';
import '../../screens/sign_up/questionire/component/sign_up_questionire_screen_v.dart';
import '../../screens/sign_up/sign_up_screen_v.dart';

export 'router.gr.dart';

abstract class Routes {
  static const login = '/login';
  static const signUp = '/signUp';
  static const forgotPassword = '/forgotPassword';
  static const splash = '/splash';
  static const customers = '/customers';
  static const activities = '/activitys';
  static const recordListApprover = '/recordapprovers';
  static const projects = '/projects';
  static const workspaces = '/workspaces';
  static const modules = '/modules';
  static const home = '/home';
  static const profile = '/profile';
  static const dashboard = '/dashboard';
  static const forms = '/forms/';
  static const records = '/forms/:formId';
  static const customForm = '/custom_form/:${Strings.formIdParam}';
  static const innerCheckListItem = '/inner_checklist_item';
  static const qrScanner = '/qr_scanner';
  static const mainProfile = '/main_profile';
  static const profileSwitcher = '/profile_switcher';
  static const profileInformation = '/profile_information';
  static const changePassword = '/change_password';
  static const accountSettings = '/account_settings';
  static const getStartedScreen = '/get_started_screen';
  static const experienceStartingScreen = '/experience_starting_screen';
  static const createExperienceScreen = '/create_experience_screen_v';
  static const showOffScreen = '/show_off_screen_v';
  static const scheduleScreen = '/schedule_screen_v';

  static const signUpScreenQuestionaire = '/signup_screen_questionaire';

  static const orderScreenView = '/order_screen/:type';

  static const foodieDecisionPending = '/foodie_decision_pending/:bookingId';
}

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashScreen,
      initial: true,
    ),
    AutoRoute(
      page: GetStartedScreen,
      path: Routes.getStartedScreen,
    ),
    AutoRoute(
      page: ExperienceStartingScreen,
      path: Routes.experienceStartingScreen,
    ),
    AutoRoute(
      page: CreateExperienceScreen,
      path: Routes.createExperienceScreen,
    ),
    AutoRoute(
      page: SignUpScreen,
      path: Routes.signUp,
    ),
    AutoRoute(
      page: HomeScreenView,
      path: Routes.home,
    ),

    AutoRoute(
      page: ForgotPasswordScreen,
      path: Routes.forgotPassword,
    ),
    AutoRoute(
      page: OrderScreenView,
      path: Routes.orderScreenView,
    ),

    AutoRoute(
      page: FoodieProfileDecisionScreenView,
      path: Routes.foodieDecisionPending,
    ),

    AutoRoute(
      page: QrScannerScreen,
      path: Routes.qrScanner,
    ),

    AutoRoute(
      page: SignUpQuestionireScreen,
      path: Routes.signUpScreenQuestionaire,
    ),
    AutoRoute(
      page: ShowOffTimeScreen,
      path: Routes.showOffScreen,
    ),
    AutoRoute(
      page: ScheduleScreen,
      path: Routes.scheduleScreen,
    ),

    // AutoRoute(
    //   page: HomeScreen,
    //   path: Routes.home,
    // ),
    RedirectRoute(
      path: '*',
      redirectTo: '/',
    ),
  ],
)
class $AppRouter {}
