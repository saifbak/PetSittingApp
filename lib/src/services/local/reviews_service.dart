import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/Reviews.dart';
// import 'package:whiskers_away_app/src/views/profile/profile_view_model.dart';

class ReviewService with ReactiveServiceMixin {
  ReactiveValue<List<Review>> _reviews = ReactiveValue<List<Review>>([]);

  set reviews(List<Review> reviewList) {
    _reviews.value = reviewList;
  }

  List<Review> get jobs {
    return _reviews.value;
  }

  addReviews(Review newReview) {
    _reviews.value.add(newReview);
  }
}
