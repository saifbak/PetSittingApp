import 'package:stacked/stacked.dart';

class Request {
  final String dogName;
  final String status;
  final String date;
  final String location;
  final String dogBreed;
  final String dogImgUrl;
  final int dogAge;
  final double dogWeight;

  Request(
    this.dogName,
    this.status,
    this.date,
    this.location,
    this.dogBreed,
    this.dogImgUrl,
    this.dogAge,
    this.dogWeight,
  );
}

class HomeViewModel extends BaseViewModel {
  List<Request> get myRequestsList => [
        Request(
          'Sully',
          'In progress',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/dog_pic1.jpg',
          14,
          28,
        ),
        Request(
          'Sasha',
          'Completed',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/dog_pic2.jpg',
          8,
          20,
        ),
      ];
}
