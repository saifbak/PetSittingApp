import 'package:dio/dio.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/wrappers/response_wrapper.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';

class AuthService with ReactiveServiceMixin {
  ReactiveValue<User?> _user = ReactiveValue<User?>(null);
  User? get user => _user.value;

  AuthService() {
    listenToReactiveValues([_user]);
  }

  set user(User? user) {
    _user.value = user;
  }
}
