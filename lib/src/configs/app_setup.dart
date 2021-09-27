import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/connectivity_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:whiskers_away_app/src/services/local/job_resp_services.dart';

import 'package:whiskers_away_app/src/services/local/keyboard_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/views/auth/login/login_view.dart';
import 'package:whiskers_away_app/src/views/auth/signup/signup_view.dart';
import 'package:whiskers_away_app/src/views/employee_details/employee_details_view.dart';
import 'package:whiskers_away_app/src/views/home/home_view.dart';
import 'package:whiskers_away_app/src/views/explore/explore_view.dart';
import 'package:whiskers_away_app/src/views/landing/landing_view.dart';
import 'package:whiskers_away_app/src/views/my_employees/my_employees_view.dart';
import 'package:whiskers_away_app/src/views/onboarding/onboarding_view.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view.dart';
import 'package:whiskers_away_app/src/views/payment/payment_view.dart';
import 'package:whiskers_away_app/src/views/per_details/pet_details_view.dart';
import 'package:whiskers_away_app/src/views/profile/profile_view.dart';
import 'package:whiskers_away_app/src/views/request_submit/request_submit_view.dart';
import 'package:whiskers_away_app/src/views/splash/splash_view.dart';
import 'package:whiskers_away_app/src/views/terms_conditions/terms_conditions_view.dart';
import 'package:whiskers_away_app/src/views/user_profile/user_profile_view.dart';
import 'package:whiskers_away_app/src/views/user_review/user_review_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: OnBoardingView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: OptionsSelectView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ExploreView),
    MaterialRoute(page: RequestSubmitView),
    MaterialRoute(page: TermsConditionsView),
    MaterialRoute(page: PaymentView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: PetDetailsView),
    MaterialRoute(page: LandingView),
    MaterialRoute(page: MyEmployeesView),
    MaterialRoute(page: EmployeeDetailsView),
    MaterialRoute(page: UserProfileView),
    MaterialRoute(page: UserReviewView),
  ],
  dependencies: [
    // Lazy singletons
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: JobService),
    LazySingleton(classType: JobRespService),
    LazySingleton(classType: ConnectivityService),
    LazySingleton(classType: KeyboardService),
    LazySingleton(classType: ApiService),
  ],
)
class AppSetup {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
