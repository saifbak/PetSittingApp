import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';

class SplashViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();

  Future<dynamic> authenticatedUser() async {
    try {
      if (LocalStorage.readSP('token') != '') {
        ApiResult apiResult = await _authService.getUserDetails();
        apiResult.when(success: (data) {
          //print("[SUCCESS] _authService.user");
        }, failure: (err) {
          //print("[FAILUER] _authService.user");
        });
        return NavService.home();
      } else {
        return NavService.optionsSelect();
      }
    } catch (e) {
      print(e.toString());
      return NavService.optionsSelect();
    }
  }
}
