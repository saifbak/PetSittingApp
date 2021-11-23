import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class PetDetailsViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();
  final dialogService = locator<DialogService>();

  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  Future<dynamic> requestToPetSit(payload, data, ctx) async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      ApiResult apiResult = await _apiService.requestToPetSit(payload, data);

      apiResult.when(success: (data) {
        AppUtils.toastShow("Your Proposal has been submitted");
      }, failure: (NetworkExceptions error) {
        AppUtils.toastShow("Your Proposal has not been submitted !");
        showErrorAlert(error);
        //NetworkExceptions.getErrorMessage(error);
      });

      setBusy(false);
    } catch (e) {
      print(e.toString());
      setBusy(false);
    }
  }

  Future<dynamic> addToFavourite(data, ctx) async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      // payload['petowner_id'] = _authService.user!.id;
      ApiResult apiResult = await _apiService.addToFavourite(data);

      apiResult.when(success: (data) {
        print(data);
        AppUtils.toastShow(data);
      }, failure: (NetworkExceptions error) {
        AppUtils.toastShow("Add to favourite unsuccessfully !");
        showErrorAlert(error);
        //NetworkExceptions.getErrorMessage(error);
      });

      setBusy(false);
    } catch (e) {
      print(e.toString());
      setBusy(false);
    }
  }

  Future<dynamic> deleteJob(data, ctx) async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      // payload['petowner_id'] = _authService.user!.id;
      ApiResult apiResult = await _apiService.deleteJob(data);

      apiResult.when(success: (data) {
        AppUtils.toastShow("Yor Proposal has been submitted");
      }, failure: (NetworkExceptions error) {
        AppUtils.toastShow("Yor Proposal has not been submitted !");
        showErrorAlert(error);
        //NetworkExceptions.getErrorMessage(error);
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

  bool isOwner() {
    return _authService.isOwner();
  }
}
