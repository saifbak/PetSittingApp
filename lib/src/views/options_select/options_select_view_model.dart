import 'package:stacked/stacked.dart';

enum Roles {
  petOwner,
  petSitter,
  manager,
}

class OptionsSelectViewModel extends BaseViewModel {
  List<Roles> get petSittingOptions => [Roles.petSitter, Roles.petOwner];

  Roles _selectedRole = Roles.petSitter;
  Roles get selectedRole => _selectedRole;
  set selectedRole(Roles val) {
    _selectedRole = val;
    notifyListeners();
  }
}
