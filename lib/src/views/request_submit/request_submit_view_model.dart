import 'package:stacked/stacked.dart';

class RequestSubmitViewModel extends BaseViewModel {
  List<String> get petSittingOptions => ['Own home', "Sitter's home"];

  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }
}
