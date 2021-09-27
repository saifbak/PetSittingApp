import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'dart:io';

class UserReviewViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController commentCtrl;
  int question1 = 0, question2 = 0, question3 = 0;
  File? _selectedImageFile;
  dynamic _assignedJob;
  User? _petsitter;

  Future<dynamic> submitReview(userData) async {
    dialogService.showCustomDialog(
        variant: 'spinner', barrierDismissible: true);

    ApiResult apiResult = await _apiService.submitReview(userData);
    apiResult.when(success: (data) async {
      //_authService.navigateHomeScreen();
      NavService.popOut;
      NavService.home();
    }, failure: (err) {
      NavService.popOut;
      print(err);
    });
  }

  File? get selectedImageFile => _selectedImageFile;
  set selectedImageFile(File? val) {
    _selectedImageFile = val;
    notifyListeners();
  }

  get assignedJob {
    return _assignedJob;
  }

  set assignedJob(val) {
    _assignedJob = val;
    notifyListeners();
  }

  User? get petsitter {
    return _petsitter;
  }

  set petsitter(val) {
    _petsitter = User.fromJson(val);
    notifyListeners();
  }

  void init() {
    commentCtrl = TextEditingController();
  }

  User? get user {
    return this._authService.user;
  }

  bool isPetSitter() {
    return _authService.isPetSitter();
  }
}
