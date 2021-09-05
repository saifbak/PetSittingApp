import 'package:stacked/stacked.dart';

class OnBoardingViewModel extends BaseViewModel {
  List<Map<String, dynamic>> get onBoardingContent => [
        {
          'bg_imgUrl': 'assets/images/bg_img_2.png',
          'imgUrl': 'assets/images/bg_illustration_1.png',
          'card_heading': "Morris County's Exclusive Pet Sitting App",
          'card_about_app_text': "The Pet Sitting App created by Pet Sitters",
          'card_desc':
              "Earn \$1 in Whiskers Rewards for use on your own future pet sitting needs every time you book a gig through Whiskers Away",
        },
        {
          'bg_imgUrl': 'assets/images/bg_img_3.png',
          'imgUrl': 'assets/images/bg_illustration_2.png',
          'card_heading':
              "Post Your Pet Sitting need, Pet Sitters Come to You!",
          'card_about_app_text':
              "No need for scrolling through endless Pet Sitters",
          'card_desc':
              "Earn 1% back in Whiskers Rewards for use on future bookings every time you pay a sitter through Whiskers Away",
        }
      ];

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  double get pageIndicatorSize => 8;
}
