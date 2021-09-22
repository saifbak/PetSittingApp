import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';

import 'package:whiskers_away_app/src/services/local/auth_service.dart';

import 'package:whiskers_away_app/src/services/remote/api_service.dart';

class UserProfileViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();

  User? get user {
    return this._authService.user;
  }
}
