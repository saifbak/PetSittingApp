// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../views/auth/login/login_view.dart';
import '../views/auth/signup/signup_view.dart';
import '../views/home/home_view.dart';
import '../views/onboarding/onboarding_view.dart';
import '../views/options_select/options_select_view.dart';
import '../views/request_submit/request_submit_view.dart';
import '../views/splash/splash_view.dart';
import '../views/terms_conditions/terms_conditions_view.dart';

class Routes {
  static const String splashView = '/';
  static const String onBoardingView = '/on-boarding-view';
  static const String loginView = '/login-view';
  static const String signUpView = '/sign-up-view';
  static const String optionsSelectView = '/options-select-view';
  static const String homeView = '/home-view';
  static const String requestSubmitView = '/request-submit-view';
  static const String termsConditionsView = '/terms-conditions-view';
  static const all = <String>{
    splashView,
    onBoardingView,
    loginView,
    signUpView,
    optionsSelectView,
    homeView,
    requestSubmitView,
    termsConditionsView,
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
    RouteDef(Routes.requestSubmitView, page: RequestSubmitView),
    RouteDef(Routes.termsConditionsView, page: TermsConditionsView),
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
  };
}
