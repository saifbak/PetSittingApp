import 'package:stacked/stacked.dart';

class Request {
  final String dogName;
  final String status;
  final String date;
  final String location;
  final String dogBreed;
  final String dogImgUrl;
  final int dogAge;

  Request(this.dogName, this.status, this.date, this.location, this.dogBreed,
      this.dogImgUrl, this.dogAge);
}

class HomeViewModel extends BaseViewModel {
  List<Request> get myRequestsList => [
        Request(
          'Sully',
          'In progress',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/profile_pic.jpg',
          14,
        ),
        Request(
          'Sasha',
          'Completed',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/profile_pic.jpg',
          8,
        ),
        Request(
          'Sully',
          'In progress',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/profile_pic.jpg',
          14,
        ),
        Request(
          'Sasha',
          'Completed',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/profile_pic.jpg',
          8,
        ),
        Request(
          'Sully',
          'In progress',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/profile_pic.jpg',
          14,
        ),
        Request(
          'Sasha',
          'Completed',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/profile_pic.jpg',
          8,
        ),
      ];
}
