import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';

class Review {
  final String authorName;
  final String date;
  final String authorImgUrl;
  final String reviewText;

  Review(this.authorName, this.date, this.authorImgUrl, this.reviewText);
}

class ProfileViewModel extends BaseViewModel {
  final _jobService = locator<JobService>();
  bool _fullReviewsDisplay = false;
  bool get fullReviewsDisplay => _fullReviewsDisplay;
  set fullReviewsDisplay(bool val) {
    _fullReviewsDisplay = val;
    notifyListeners();
  }

  Map<String, dynamic> _userDetails = {
    'petsitter': {},
    'job': {},
  };
  Map<String, dynamic> get userDetails => _userDetails;
  set userDetails(Map<String, dynamic> val) {
    _userDetails = val;
    _jobService.selectedJobProposal = val;
    notifyListeners();
  }

  // final _reviewService = locator<ReviewService>();
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();

  // List<Review> _reviews = [];

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

  User get petUser {
    return User.fromJson(_jobService.selectedJobProposal['petsitter']);
  }
}
