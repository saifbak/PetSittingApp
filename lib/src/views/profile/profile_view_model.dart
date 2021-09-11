import 'package:stacked/stacked.dart';

class Review {
  final String authorName;
  final String date;
  final String authorImgUrl;
  final String reviewText;

  Review(this.authorName, this.date, this.authorImgUrl, this.reviewText);
}

class ProfileViewModel extends BaseViewModel {
  bool _fullReviewsDisplay = false;
  bool get fullReviewsDisplay => _fullReviewsDisplay;
  set fullReviewsDisplay(bool val) {
    _fullReviewsDisplay = val;
    notifyListeners();
  }

  List<Review> get reviewsList => [
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        ),
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        ),
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        ),
        Review(
          'Cameron Williamson',
          'Mar 21, 2021',
          'assets/images/profile_pic.jpg',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
        )
      ];
}
