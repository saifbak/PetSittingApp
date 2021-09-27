import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class TermsConditionsViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();

  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;
  set termsAccepted(bool val) {
    _termsAccepted = val;
    notifyListeners();
  }

  ScrollController scrollController = ScrollController();
  List<String> get termsDemoData => [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus. Vestibulum aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet.\n\nAnte in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, ante in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet.\n\nAnte in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, ante in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet."
      ];

  Future<dynamic> signup() async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      Map<String, dynamic> payload = _authService.signupUser;

      print("payload");
      print(payload);

      User user = new User(
        name: payload['name'],
        email: payload['email'],
        password: payload['password'],
        phone: payload['phone'],
        address: payload['address'],
        username: payload['username'],
        description:
            payload['description'] != null ? payload['description'] : "",
        roleId: _authService.getRoleById(),
      );
      ApiResult apiResult = await _apiService.register(user);

      NavService.popOut;

      // Navigator.of(ctx, rootNavigator: true).pop();

      apiResult.when(success: (data) {
        showSuccessAlert();
        AppUtils.toastShow("User Registered Successfully");
        print(data);
      }, failure: (NetworkExceptions error) {
        AppUtils.toastShow("Unsuccessful Registration !");
        showErrorAlert(error);
      });

      setBusy(false);
    } catch (e) {
      NavService.popOut;

      print(e.toString());
      setBusy(false);
    }
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

  showErrorAlert(e) {
    dialogService.showDialog(
      title: 'Error Occurred',
      description: NetworkExceptions.getErrorMessage(e),
      buttonTitle: 'Cancel',
      buttonTitleColor: AppColors.primaryColor,
    );
  }
}
