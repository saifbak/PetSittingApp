import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/connectivity_service.dart';
import 'package:whiskers_away_app/src/services/local/keyboard_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/views/auth/login/login_view.dart';
import 'package:whiskers_away_app/src/views/auth/signup/signup_view.dart';
import 'package:whiskers_away_app/src/views/home/home_view.dart';
import 'package:whiskers_away_app/src/views/onboarding/onboarding_view.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view.dart';
import 'package:whiskers_away_app/src/views/payment/payment_view.dart';
import 'package:whiskers_away_app/src/views/profile/profile_view.dart';
import 'package:whiskers_away_app/src/views/request_submit/request_submit_view.dart';
import 'package:whiskers_away_app/src/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/views/terms_conditions/terms_conditions_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: OnBoardingView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: OptionsSelectView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: RequestSubmitView),
    MaterialRoute(page: TermsConditionsView),
    MaterialRoute(page: PaymentView),
    MaterialRoute(page: ProfileView),
  ],
  dependencies: [
    // Lazy singletons
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: ConnectivityService),
    LazySingleton(classType: KeyboardService),
    LazySingleton(classType: ApiService),
  ],
)
class AppSetup {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
