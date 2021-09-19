import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';

class SplashViewModel extends BaseViewModel {
  Future<dynamic> authenticatedUser() async {
    final _authService = locator<AuthService>();

    ApiResult apiResult = await _authService.getUserDetails();
    apiResult.when(success: (data) {
      //print("[SUCCESS] _authService.user");

      NavService.home();
    }, failure: (err) {
      print(err);
      NavService.optionsSelect();
      //print("[FAILUER] _authService.user");
    });
  }

  // @override
  // List<ReactiveServiceMixin> get reactiveServices => [_authService];
}
