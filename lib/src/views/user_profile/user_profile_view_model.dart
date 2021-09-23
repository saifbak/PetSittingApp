import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';

import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';

import 'package:whiskers_away_app/src/services/remote/api_service.dart';

class UserProfileViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController addressCtrl, nameCtrl, phoneCtrl, hourlRateCtrl;

  Future<dynamic> updateUserDetails(userData) async {
    print('updateUserDetails');
    print(userData);
    ApiResult apiResult = await _apiService.updateUserDetails(userData);
    apiResult.when(success: (data) {
      _authService.user!.name = data['name'];
      _authService.user!.address = data['address'];
      _authService.user!.phone = data['phone'];
      _authService.user!.hourlyRate = data['hourlyRate'];
      _authService.navigateHomeScreen();
    }, failure: (err) {
      print(err);
      NavService.optionsSelect();
      //print("[FAILUER] _authService.user");
    });
  }

  void init() {
    nameCtrl = TextEditingController(text: user!.name);
    phoneCtrl = TextEditingController(text: user!.phone);
    addressCtrl = TextEditingController(text: user!.address);
    hourlRateCtrl = TextEditingController(text: user!.hourlyRate.toString());
  }

  User? get user {
    return this._authService.user;
  }

  bool isPetSitter() {
    return _authService.isPetSitter();
  }
}
  