import 'package:stacked/stacked.dart';

class OptionsSelectViewModel extends BaseViewModel {
  bool _isSelected = true;
  bool get isSelected => _isSelected;
  set isSelected(bool val) {
    _isSelected = val;
    notifyListeners();
  }
}
