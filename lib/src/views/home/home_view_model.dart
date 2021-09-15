import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';

class Request {
  final String dogName;
  final String status;
  final String date;
  final String location;
  final String dogBreed;
  final String dogImgUrl;
  final int dogAge;
  final double dogWeight;
  final String desc;

  Request(
    this.dogName,
    this.status,
    this.date,
    this.location,
    this.dogBreed,
    this.dogImgUrl,
    this.dogAge,
    this.dogWeight,
    this.desc,
  );
}

class PetSitter {
  final String name;
  final String location;
  final String imgUrl;

  PetSitter(this.name, this.location, this.imgUrl);
}

class HomeViewModel extends BaseViewModel {
  final bottomSheetService = locator<BottomSheetService>();

  List<PetSitter> get petSittersList => [
        PetSitter(
          'Ralph Edwards',
          'Houston',
          'assets/images/profile_pic.jpg',
        )
      ];

  List<Request> get requestsList => [
        Request(
          'Sully',
          '   Filled   ',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/dog_pic1.jpg',
          14,
          28,
          "Need someone to take care of my doggy for some days.",
        ),
        Request(
          'Sasha',
          '   Filled   ',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/dog_pic2.jpg',
          8,
          20,
          "Need someone to take care of my doggy for some days.",
        ),
        Request(
          'Sully',
          '   Filled   ',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/dog_pic1.jpg',
          14,
          28,
          "Need someone to take care of my doggy for some days.",
        ),
        Request(
          'Sasha',
          '   Filled   ',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/dog_pic2.jpg',
          8,
          20,
          "Need someone to take care of my doggy for some days.",
        ),
      ];

  List<Request> get newRequestsList => [
        Request(
          'Sully',
          '   Open   ',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/dog_pic1.jpg',
          14,
          28,
          "Need someone to take care of my doggy for some days.",
        ),
      ];

  List<String> get ownerRequests => ['Requests', "New requests"];
  List<String> get managerEmployeeJobs => ['Filled jobs', "Open jobs"];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }
}
