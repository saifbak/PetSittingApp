import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class Review {
  final String authorName;
  final String date;
  final String authorImgUrl;
  final String reviewText;

  Review(this.authorName, this.date, this.authorImgUrl, this.reviewText);
}

class ProfileViewModel extends BaseViewModel {
  final _jobService = locator<JobService>();
  final dialogService = locator<DialogService>();

  bool _fullReviewsDisplay = false;
  bool get fullReviewsDisplay => _fullReviewsDisplay;
  set fullReviewsDisplay(bool val) {
    _fullReviewsDisplay = val;
    notifyListeners();
  }

  Map<String, dynamic> _userDetails = {
    'petsitter': {},
    'job': {},
  };
  Map<String, dynamic> get userDetails => _userDetails;
  set userDetails(Map<String, dynamic> val) {
    _userDetails = val;
    _jobService.selectedJobProposal = val;
    notifyListeners();
  }

  // final _reviewService = locator<ReviewService>();
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();

  // List<Review> _reviews = [];

  Future<dynamic> sentEmail(data, ctx) async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      // payload['petowner_id'] = _authService.user!.id;
      ApiResult apiResult = await _apiService.sentEmail(data);

      apiResult.when(success: (data) {
        print('data===>');
        print(data);
        // AlertDialog();
        showAlert(data);
        AppUtils.toastShow('Email Sent');
        NavService.home();
      }, failure: (NetworkExceptions error) {
        print(error);
        AppUtils.toastShow("Email not sent!");
        showErrorAlert(error);
        //NetworkExceptions.getErrorMessage(error);
      });

      setBusy(false);
    } catch (e) {
      print(e.toString());
      setBusy(false);
    }
  }

  showAlert(e) {
    dialogService.showDialog(
      title: 'Email Sent',
      description: 'Email has been successfully sent to the desired petsitter',
      buttonTitle: 'Cancel',
      buttonTitleColor: AppColors.primaryColor,
    );
  }

  showErrorAlert(e) {
    dialogService.showDialog(
      title: 'Error Occured',
      description: NetworkExceptions.getErrorMessage(e),
      buttonTitle: 'Cancel',
      buttonTitleColor: AppColors.primaryColor,
    );
  }

  List<Review> get reviewsList => [
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        ),
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        ),
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        ),
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        )
      ];

  User get petUser {
    return User.fromJson(_jobService.selectedJobProposal['petsitter']);
  }
}
