import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';

class PaymentViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();

  final _jobService = locator<JobService>();
  final _apiService = locator<ApiService>();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  late TextEditingController nameCtrl, cardCtrl, dateCtrl, cvcCtrl;

  get jobProposal {
    return _jobService.selectedJobProposal;
  }

  User get petUser {
    return User.fromJson(_jobService.selectedJobProposal['petsitter']);
  }

  void init() {
    nameCtrl = TextEditingController(text: 'Test');
    cardCtrl = TextEditingController(text: '4242424242424242');
    dateCtrl = TextEditingController(text: '06/2022');
    cvcCtrl = TextEditingController(text: '314');
  }

  Future<dynamic> makePayment() async {
    if (!formKey.currentState!.validate()) {
      autoValidate = AutovalidateMode.onUserInteraction;
      return;
    }

    dynamic parsedDate = dateCtrl.text.split('/');
    Map<String, dynamic> paymentDetails = {
      'amount': jobProposal['price'],
      'number': cardCtrl.text,
      'exp_month': parsedDate[0],
      'exp_year': parsedDate[1],
      'cvc': cvcCtrl.text,
      'petsitter_id': jobProposal['petsitter_id'],
      'job_id': jobProposal['job_id'],
    };
    /* print(paymentDetails);
    return; */
    setBusy(true);
    dialogService.showCustomDialog(
      variant: 'payment',
      barrierDismissible: true,
    );
    ApiResult apiResult = await _apiService.createPayment(paymentDetails);
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
      //_authService.navigateHomeScreen();
    }, failure: (err) {
      setBusy(false);
      NavService.popOut;
      print(err);
      //NavService.optionsSelect();
    });
  }
}
