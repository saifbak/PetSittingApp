import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';

import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';

class SignUpViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();

  Future<dynamic> signup(Map<String, dynamic> payload, ctx) async {
    setBusy(true);
    print(payload);
    print('===> hours payload');
    print(payload['hourlyRate']);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      User user = new User(
        name: payload['name'],
        email: payload['email'],
        password: payload['password'],
        phone: payload['phone'],
        address: payload['address'],
        username: payload['username'],
        hourlyRate: payload['hourlyRate'] != null
            ? payload['hourlyRate'].toDouble()
            : payload['hourlyRate'],
        roleId: _authService.getRoleById(),
      );
      ApiResult apiResult = await _apiService.register(user);

      // Navigator.of(ctx, rootNavigator: true).pop();

      apiResult.when(success: (data) {
        showSuccessAlert();
        print(data);
      }, failure: (NetworkExceptions error) {
        showErrorAlert(error);
      });

      setBusy(false);
    } catch (e) {
      print(e.toString());
      setBusy(false);
    }
  }

  showErrorAlert(e) {
    dialogService.showDialog(
      title: 'Error Occured',
      description: NetworkExceptions.getErrorMessage(e),
      buttonTitle: 'Cancel',
      buttonTitleColor: AppColors.primaryColor,
    );
  }

  showSuccessAlert() {
    dialogService.showDialog(
      title: 'Success',
      description:
          'Congratulations, your account has been created successfully.',
      buttonTitle: 'Okay',
      buttonTitleColor: AppColors.primaryColor,
    );
    Timer(Duration(seconds: 2), () {
      NavService.loginReplace();
    });
  }

  bool isPetSitter() {
    return _authService.isPetSitter();
  }
}
