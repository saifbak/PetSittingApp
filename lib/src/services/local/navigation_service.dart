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
  static Future<dynamic>? optionsSelect({dynamic arguments}) {
    return _navigationService!
        .replaceWith(Routes.optionsSelectView, arguments: arguments);
  }

  static Future<dynamic>? onBoarding({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.onBoardingView, arguments: arguments);
  static Future<dynamic>? login({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.loginView, arguments: arguments);
  static Future<dynamic>? forgot({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.forgotView, arguments: arguments);
  static Future<dynamic>? loginReplace({dynamic arguments}) =>
      _navigationService!.replaceWith(Routes.loginView, arguments: arguments);
  static Future<dynamic>? loginClearAll({dynamic arguments}) =>
      _navigationService!
          .clearStackAndShow(Routes.loginView, arguments: arguments);
  static Future<dynamic>? signup({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.signUpView, arguments: arguments);
  static Future<dynamic>? signupReplace({dynamic arguments}) =>
      _navigationService!.replaceWith(Routes.signUpView, arguments: arguments);
  static Future<dynamic>? home({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.homeView, arguments: arguments);
  static Future<dynamic>? explore({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.exploreView, arguments: arguments);
  static Future<dynamic>? landing({dynamic arguments}) => _navigationService!
      .clearStackAndShow(Routes.landingView, arguments: arguments);
  static Future<dynamic>? requestSubmit({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.requestSubmitView, arguments: arguments);

  static Future<dynamic>? notifications({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.notificationsView, arguments: arguments);

  static Future<dynamic>? editsubmittedrequest({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.editsubmittedrequestview, arguments: arguments);

  static Future<dynamic>? termsConditions({dynamic arguments}) =>
      _navigationService!.navigateTo(
        Routes.termsConditionsView,
        arguments: arguments,
      );
  static Future<dynamic>? payment({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.paymentView, arguments: arguments);
  static Future<dynamic>? profile({dynamic arguments}) =>
      _navigationService!.navigateTo(Routes.profileView, arguments: arguments);

  static Future<dynamic>? petDetails({dynamic arguments}) => _navigationService!
      .navigateTo(Routes.petDetailsView, arguments: arguments);

  static Future<dynamic>? userReviewView({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.userReviewView, arguments: arguments);
  static Future<dynamic>? employeeDetails({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.employeeDetailsView, arguments: arguments);
  static Future<dynamic>? userProfile({dynamic arguments}) =>
      _navigationService!
          .navigateTo(Routes.userProfileView, arguments: arguments);

  // back route
  static bool get popOut => _navigationService!.back();
}
