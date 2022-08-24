import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class PaymentViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();

  final _jobService = locator<JobService>();
  final _apiService = locator<ApiService>();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  late TextEditingController nameCtrl, cardCtrl, dateCtrl, cvcCtrl, rewardsCtrl;

  void init() {
    nameCtrl = TextEditingController();
    cardCtrl = TextEditingController();
    dateCtrl = TextEditingController();
    cvcCtrl = TextEditingController();
    rewardsCtrl = TextEditingController();
  }

  double _currentReward = 0;
  int _totalrewards = 0;
  double total = 0;

  set currentReward(double val) {
    _currentReward = val;
    notifyListeners();
  }

  double get currentReward => _currentReward;

  set totalRewards(int val) {
    _totalrewards = val;
    notifyListeners();
  }

  int get totalRewards => _totalrewards;

  applyRewards(user) {
    // model.rewardsCtrl.text;
    if (double.parse(rewardsCtrl.text) <= totalRewards) {
      currentReward = double.parse(rewardsCtrl.text);
      total = double.parse(user['price']) - currentReward;
      user['base_price'] = total.toString();
      notifyListeners();
    } else {
      showErrorAlert("Don't have sufficient rewards");
    }

    // print('Input value ${rewardsCtrl.text}');
  }

  Future<dynamic> getRewards() async {
    setBusy(true);
    ApiResult<dynamic> apiResult = await _apiService.getRewrads();
    apiResult.when(success: (data) {
      totalRewards = data;
      print('totalRewards===> $totalRewards');
      setBusy(false);
    }, failure: (NetworkExceptions error) {
      setBusy(false);
    });
  }

  Future<dynamic> makePayment(data) async {
    if (!formKey.currentState!.validate()) {
      print(data);
      autoValidate = AutovalidateMode.onUserInteraction;
      return;
    }
    print("my data");
    // dynamic parsedDate = dateCtrl.text.split('/');
    // Map<String, dynamic> paymentDetails = {
    //   'amount': jobProposal['price'],
    //   'number': cardCtrl.text,
    //   'exp_month': parsedDate[0],
    //   'exp_year': parsedDate[1],
    //   'cvc': cvcCtrl.text,
    //   'petsitter_id': jobProposal['petsitter_id'],
    //   'job_id': jobProposal['job_id'],
    // };
    /* print(paymentDetails);
    return; */
    setBusy(true);
    // dialogService.showCustomDialog(
    //   variant: 'payment',
    //   barrierDismissible: true,
    // );
    ApiResult apiResult = await _apiService.createPayment(data);
    print(data);
    apiResult.when(success: (data) async {
      NavService.popOut;
      /* _authService.user!.name = data['name'];
      _authService.user!.address = data['address'];
      _authService.user!.phone = data['phone']; */
      //_authService.user!.hourlyRate = data['hourlyRate'];
      /* if (selectedImageFile != null) {
        await uploadImage(selectedImageFile!);
      } */
      setBusy(false);
      dialogService.showCustomDialog(variant: 'payment');
      print("my data");
      print('Data');
      print(data);

      //_authService.navigateHomeScreen();
    }, failure: (err) {
      // dialogService.showCustomDialog(variant: 'payment');
      // showErrorAlert(err);
      setBusy(false);
      NavService.popOut;
      print('Error');
      print(err);
      //NavService.optionsSelect();
    });
  }

  showErrorAlert(e) {
    dialogService.showCustomDialog(
      title: 'Payment Fail',
      description: NetworkExceptions.getErrorMessage(e),
      // buttonTitle: 'Cancel',
      // buttonTitleColor: AppColors.primaryColor,
    );
  }
}
