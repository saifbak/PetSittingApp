import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:stacked_services/stacked_services.dart';

class NavService {
  static NavigationService? _navigationService = locator<NavigationService>();

  // key
  static GlobalKey<NavigatorState>? get key => StackedService.navigatorKey;

  // on generate route
  static Route<dynamic>? Function(RouteSettings) get onGenerateRoute =>
      StackedRouter().onGenerateRoute;

  // routes with args
  static Future<dynamic>? optionsSelect({dynamic arguments}) =>
      _navigationService!
          .replaceWith(Routes.optionsSelectView, arguments: arguments);
  static Future<dynamic>? onBoarding({dynamic arguments}) => _navigationService!
      .replaceWith(Routes.onBoardingView, arguments: arguments);
  static Future<dynamic>? login({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.loginView, arguments: arguments);
  static Future<dynamic>? loginReplace({dynamic arguments}) =>
      _navigationService!.replaceWith(Routes.loginView, arguments: arguments);
  static Future<dynamic>? signup({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.signUpView, arguments: arguments);
  static Future<dynamic>? signupReplace({dynamic arguments}) =>
      _navigationService!.replaceWith(Routes.signUpView, arguments: arguments);
}
