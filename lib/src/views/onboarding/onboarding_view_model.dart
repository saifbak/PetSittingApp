import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';

class OnBoardingViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();

  List<Map<String, dynamic>> get onBoardingContent => [
        {
          'bg_imgUrl': 'assets/images/bg_img_2.png',
          'imgUrl': 'assets/images/bg_illustration_1.png',
          'card_heading': "Pet Sitting App",
          'card_about_app_text': "The Pet Sitting App created by Enorness",
          'card_desc':
              "Earn \$1 in Pet Sitting Rewards for use on your own future pet sitting needs every time you book a gig through Pet Sitting App",
        },
        {
          'bg_imgUrl': 'assets/images/bg_img_3.png',
          'imgUrl': 'assets/images/bg_illustration_2.png',
          'card_heading':
              "Post Your Pet Sitting need, Pet Sitters Come to You!",
          'card_about_app_text':
              "No need for scrolling through endless Pet Sitters",
          'card_desc':
              "Earn 1% back in Pet Sitting Rewards for use on future bookings every time you pay a sitter through Pet Sitting App",
        }
      ];

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  bool isPetSitter() {
    return _authService.isPetSitter();
  }

  // double get pageIndicatorSize => 8;
}
