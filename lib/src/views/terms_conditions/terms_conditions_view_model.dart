import 'package:stacked/stacked.dart';

class TermsConditionsViewModel extends BaseViewModel {
  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;
  set termsAccepted(bool val) {
    _termsAccepted = val;
    notifyListeners();
  }
}
