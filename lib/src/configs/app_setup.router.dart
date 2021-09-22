// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/Job.dart';

import '../views/auth/login/login_view.dart';
import '../views/auth/signup/signup_view.dart';
import '../views/employee_details/employee_details_view.dart';
import '../views/home/home_view.dart';
import '../views/home/home_view_model.dart';
import '../views/landing/landing_view.dart';
import '../views/my_employees/my_employees_view.dart';
import '../views/onboarding/onboarding_view.dart';
import '../views/options_select/options_select_view.dart';
import '../views/options_select/options_select_view_model.dart';
import '../views/payment/payment_view.dart';
import '../views/per_details/pet_details_view.dart';
import '../views/profile/profile_view.dart';
import '../views/request_submit/request_submit_view.dart';
import '../views/splash/splash_view.dart';
import '../views/terms_conditions/terms_conditions_view.dart';
import '../views/explore/explore_view.dart';

class Routes {
  static const String splashView = '/';
  static const String onBoardingView = '/on-boarding-view';
  static const String loginView = '/login-view';
  static const String signUpView = '/sign-up-view';
  static const String optionsSelectView = '/options-select-view';
  static const String homeView = '/home-view';
  static const String exploreView = '/explore-view';
  static const String requestSubmitView = '/request-submit-view';
  static const String termsConditionsView = '/terms-conditions-view';
  static const String paymentView = '/payment-view';
  static const String profileView = '/profile-view';
  static const String petDetailsView = '/pet-details-view';
  static const String landingView = '/landing-view';
  static const String myEmployeesView = '/my-employees-view';
  static const String employeeDetailsView = '/employee-details-view';
  static const all = <String>{
    splashView,
    onBoardingView,
    loginView,
    signUpView,
    optionsSelectView,
    homeView,
    exploreView,
    requestSubmitView,
    termsConditionsView,
    paymentView,
    profileView,
    petDetailsView,
    landingView,
    myEmployeesView,
    employeeDetailsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.onBoardingView, page: OnBoardingView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.optionsSelectView, page: OptionsSelectView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.exploreView, page: ExploreView),
    RouteDef(Routes.requestSubmitView, page: RequestSubmitView),
    RouteDef(Routes.termsConditionsView, page: TermsConditionsView),
    RouteDef(Routes.paymentView, page: PaymentView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.petDetailsView, page: PetDetailsView),
    RouteDef(Routes.landingView, page: LandingView),
    RouteDef(Routes.myEmployeesView, page: MyEmployeesView),
    RouteDef(Routes.employeeDetailsView, page: EmployeeDetailsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    OnBoardingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpView(),
        settings: data,
      );
    },
    OptionsSelectView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OptionsSelectView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    ExploreView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ExploreView(),
        settings: data,
      );
    },
    RequestSubmitView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RequestSubmitView(),
        settings: data,
      );
    },
    TermsConditionsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => TermsConditionsView(),
        settings: data,
      );
    },
    PaymentView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PaymentView(),
        settings: data,
      );
    },
    ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(),
        settings: data,
      );
    },
    PetDetailsView: (data) {
      var args = data.getArgs<PetDetailsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PetDetailsView(
          request: args.request,
          role: args.role,
        ),
        settings: data,
      );
    },
    LandingView: (data) {
      var args = data.getArgs<LandingViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LandingView(navBarItems: args.navBarItems),
        settings: data,
      );
    },
    MyEmployeesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MyEmployeesView(),
        settings: data,
      );
    },
    EmployeeDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EmployeeDetailsView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PetDetailsView arguments holder class
class PetDetailsViewArguments {
  final Job request;
  final Roles role;
  PetDetailsViewArguments({required this.request, required this.role});
}

/// LandingView arguments holder class
class LandingViewArguments {
  final List<NavBarItem> navBarItems;
  LandingViewArguments({required this.navBarItems});
}
