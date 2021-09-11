import 'package:stacked/stacked.dart';

class Request {
  final String dogName;
  final String status;
  final String date;
  final String location;
  final String dogBreed;
  final String dogImgUrl;

  Request(this.dogName, this.status, this.date, this.location, this.dogBreed,
      this.dogImgUrl);
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
        ),
        Request(
          'Sasha',
          'Completed',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/profile_pic.jpg',
        ),
        Request(
          'Sully',
          'In progress',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/profile_pic.jpg',
        ),
        Request(
          'Sasha',
          'Completed',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/profile_pic.jpg',
        ),
        Request(
          'Sully',
          'In progress',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/profile_pic.jpg',
        ),
        Request(
          'Sasha',
          'Completed',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/profile_pic.jpg',
        ),
      ];
}
