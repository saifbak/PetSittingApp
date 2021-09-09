import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class TermsConditionsViewModel extends BaseViewModel {
  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;
  set termsAccepted(bool val) {
    _termsAccepted = val;
    notifyListeners();
  }

  ScrollController scrollController = ScrollController();

  List<String> get termsDemoData => [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cursus et scelerisque risus quam porta aenean sed cursus. Vestibulum aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet.\n\nAnte in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, ante in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet.\n\nAnte in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, ante in fames scelerisque ridiculus elementum ornare pellentesque arcu. Volutpat nec nunc, aliquet eros, euismod platea felis velit. Consectetur arcu proin vel laoreet."
      ];
}
