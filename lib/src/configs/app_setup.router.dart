// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:whiskers_away_app/src/views/edit_submitted_request/edit_sunmitted_request_view_modal.dart';
import 'package:whiskers_away_app/src/views/user_review/user_review_view.dart';

import '../models/Job.dart';
import '../views/auth/login/login_view.dart';
import '../views/auth/forgot/forgot_view.dart';
import '../views/auth/signup/signup_view.dart';
import '../views/employee_details/employee_details_view.dart';
import '../views/explore/explore_view.dart';
import '../views/home/home_view.dart';
import '../views/landing/landing_view.dart';
import '../views/my_employees/my_employees_view.dart';
import '../views/onboarding/onboarding_view.dart';
import '../views/options_select/options_select_view.dart';
import '../views/options_select/options_select_view_model.dart';
import '../views/payment/payment_view.dart';
import '../views/per_details/pet_details_view.dart';
import '../views/profile/profile_view.dart';
import '../views/request_submit/request_submit_view.dart';
import '../views/edit_submitted_request/edit_submitted_request_view.dart';
import '../views/splash/splash_view.dart';
import '../views/terms_conditions/terms_conditions_view.dart';
import '../views/user_profile/user_profile_view.dart';

class Routes {
  static const String splashView = '/';
  static const String onBoardingView = '/on-boarding-view';
  static const String loginView = '/login-view';
  static const String forgotView = '/forgot-view';
  static const String signUpView = '/sign-up-view';
  static const String optionsSelectView = '/options-select-view';
  static const String homeView = '/home-view';
  static const String exploreView = '/explore-view';
  static const String requestSubmitView = '/request-submit-view';
  static const String editsubmittedrequestview = '/edit-submitted-request-view';
  static const String termsConditionsView = '/terms-conditions-view';
  static const String paymentView = '/payment-view';
  static const String profileView = '/profile-view';
  static const String petDetailsView = '/pet-details-view';
  static const String userReviewView = '/user-review-view';
  static const String landingView = '/landing-view';
  static const String myEmployeesView = '/my-employees-view';
  static const String employeeDetailsView = '/employee-details-view';
  static const String userProfileView = '/user-profile-view';
  static const all = <String>{
    splashView,
    onBoardingView,
    loginView,
    forgotView,
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
    userProfileView,
    userReviewView,
    editsubmittedrequestview
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.onBoardingView, page: OnBoardingView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.forgotView, page: ForgotView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.optionsSelectView, page: OptionsSelectView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.exploreView, page: ExploreView),
    RouteDef(Routes.requestSubmitView, page: RequestSubmitView),
    RouteDef(Routes.editsubmittedrequestview, page: EditSubmittedRequestView),
    RouteDef(Routes.termsConditionsView, page: TermsConditionsView),
    RouteDef(Routes.paymentView, page: PaymentView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.petDetailsView, page: PetDetailsView),
    RouteDef(Routes.landingView, page: LandingView),
    RouteDef(Routes.myEmployeesView, page: MyEmployeesView),
    RouteDef(Routes.employeeDetailsView, page: EmployeeDetailsView),
    RouteDef(Routes.userProfileView, page: UserProfileView),
    RouteDef(Routes.userReviewView, page: UserReviewView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    OnBoardingView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => OnBoardingView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    ForgotView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => ForgotView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => SignUpView(),
        settings: data,
      );
    },
    OptionsSelectView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => OptionsSelectView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    ExploreView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => ExploreView(),
        settings: data,
      );
    },
    RequestSubmitView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => RequestSubmitView(),
        settings: data,
      );
    },
    EditSubmittedRequestView: (data) {
      var args = data.getArgs<EditRequestArguments>(nullOk: false);
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => EditSubmittedRequestView(
          request: args.request,
          role: args.role,
        ),
        settings: data,
      );
    },
    TermsConditionsView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => TermsConditionsView(),
        settings: data,
      );
    },
    PaymentView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => PaymentView(),
        settings: data,
      );
    },
    ProfileView: (data) {
      var args = data.getArgs<ProfileViewArguments>(nullOk: false);
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => ProfileView(args.user),
        settings: data,
      );
    },
    PetDetailsView: (data) {
      var args = data.getArgs<PetDetailsViewArguments>(nullOk: false);
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => PetDetailsView(
          request: args.request,
          role: args.role,
        ),
        settings: data,
      );
    },
    LandingView: (data) {
      var args = data.getArgs<LandingViewArguments>(nullOk: false);
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => LandingView(navBarItems: args.navBarItems),
        settings: data,
      );
    },
    MyEmployeesView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => MyEmployeesView(),
        settings: data,
      );
    },
    EmployeeDetailsView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => EmployeeDetailsView(),
        settings: data,
      );
    },
    UserProfileView: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => UserProfileView(),
        settings: data,
      );
    },
    UserReviewView: (data) {
      var args = data.getArgs<UserReviewViewArguments>(nullOk: false);

      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => UserReviewView(
          assignedJob: args.assignedJob,
        ),
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProfileView arguments holder class
class ProfileViewArguments {
  final dynamic user;
  ProfileViewArguments({required this.user});
}

/// PetDetailsView arguments holder class
class PetDetailsViewArguments {
  final Job request;
  final Roles role;
  PetDetailsViewArguments({required this.request, required this.role});
}

class EditRequestArguments {
  final Job request;
  final Roles role;
  EditRequestArguments({required this.request, required this.role});
}

/// LandingView arguments holder class
class LandingViewArguments {
  final List<NavBarItem> navBarItems;
  LandingViewArguments({required this.navBarItems});
}

class UserReviewViewArguments {
  dynamic assignedJob;
  UserReviewViewArguments({required this.assignedJob});
}
