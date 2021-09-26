import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

import 'package:whiskers_away_app/src/services/remote/api_service.dart';

class LoginViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();

  Future<dynamic> login(Map<String, dynamic> payload, ctx) async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      ApiResult apiResult = await _apiService.login(payload);

      Navigator.of(ctx, rootNavigator: true).pop();
      // SnackbarService().showSnackbar(message: "Successful Login");

      apiResult.when(success: (data) {
        print(data);
        _authService.user = data;
        _authService.navigateHomeScreen();
        AppUtils.toastShow("Successful Login");
      }, failure: (NetworkExceptions error) {
        AppUtils.toastShow("Login Unsuccessful !");
        showErrorAlert(error);
      });

      setBusy(false);
    } catch (e) {
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
}
