import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class RequestSubmitViewModel extends BaseViewModel {
  List<String> get petSittingOptions => ['Own home', "Sitter's home"];
  final _authService = locator<AuthService>();
  final dialogService = locator<DialogService>();

  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  Future<dynamic> sendPetRequest(Map<String, dynamic> payload, ctx) async {
    setBusy(true);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      payload['petowner_id'] = _authService.user!.id;
      ApiResult apiResult = await _authService.sendPetRequest(payload);

      apiResult.when(success: (data) {
        print(data);
      }, failure: (NetworkExceptions error) {
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
}
