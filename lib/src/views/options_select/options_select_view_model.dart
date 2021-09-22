import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/core/enums/role_enum.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';

enum Roles {
  petOwner,
  petSitter,
  manager,
}

class OptionsSelectViewModel extends BaseViewModel {
  List<Role> get petSittingOptions => [Role.PET_SITTER, Role.PET_OWNER];
  final _authService = locator<AuthService>();

  Role _selectedRole = Role.PET_SITTER;
  Role get selectedRole => _selectedRole;

  set selectedRole(Role val) {
    _selectedRole = val;
    _authService.role = val;
    notifyListeners();
  }

  setDefaultRole() {
    selectedRole = Role.PET_SITTER;
  }
}
