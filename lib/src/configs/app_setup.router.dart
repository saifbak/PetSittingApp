// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../views/onboarding/onboarding_view.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String onBoardingView = '/on-boarding-view';
  static const all = <String>{
    splashView,
    onBoardingView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.onBoardingView, page: OnBoardingView),
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
  };
}
