import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';

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
  final int totalBookings;
  final String hourlyRates;

  PetSitter(
    this.name,
    this.location,
    this.imgUrl,
    this.totalBookings,
    this.hourlyRates,
  );
}

class HomeViewModel extends BaseViewModel {
  final bottomSheetService = locator<BottomSheetService>();
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();
  final _jobService = locator<JobService>();
  List<Job> _newJobs = [];
  List<Map<String, dynamic>> _jobResponses = [];

  List<PetSitter> get petSittersList => [
        PetSitter(
          'Ralph Edwards',
          'Houston',
          'assets/images/profile_pic.jpg',
          5,
          '10',
        )
      ];

  List<Job> get requestsList => [
        /* Request(
          'Sully',
          'In progress',
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
          'Completed',
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
          'Completed',
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
          'In progress',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/dog_pic2.jpg',
          8,
          20,
          "Need someone to take care of my doggy for some days.",
        ), */
      ];

  List<Request> get newRequestsList => [
        Request(
          'Sully',
          'New Request',
          'May 20-24',
          'Houston',
          'Golden Retriever',
          'assets/images/dog_pic1.jpg',
          14,
          28,
          "Need someone to take care of my doggy for some days.",
        ),
      ];

  List<String> get ownerRequests => ['Open Jobs', "Job History"];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  User? get user {
    return this._authService.user;
  }

  Future<List<Job>?> getNewJobs() async {
    setBusy(true);

    ApiResult<List<Job>> apiResult = await _apiService.getNewJobs();
    apiResult.when(success: (data) {
      newJobs = data;
      setBusy(false);
    }, failure: (NetworkExceptions error) {
      setBusy(false);
      //print(error.toString());
      /* _snackService.showSnackbar(
          message: NetworkExceptions.getErrorMessage(error)); */
      //print(err);
      //print("[FAILUER] _authService.user");
    });
  }

  Future<List<Map<String, dynamic>>?> getJobResponse(jobID) async {
    setBusy(true);

    ApiResult<dynamic> apiResult = await _apiService.getJobResponses(jobID);
    apiResult.when(success: (data) {
      jobResponses = data;
      setBusy(false);
    }, failure: (NetworkExceptions error) {
      setBusy(false);
      //print(error.toString());
      /* _snackService.showSnackbar(
          message: NetworkExceptions.getErrorMessage(error)); */
      //print(err);
      //print("[FAILUER] _authService.user");
    });
  }

  List<Job> get newJobs {
    return _newJobs;
  }

  List<Map<String, dynamic>> get jobResponses {
    return _jobResponses;
  }

  set newJobs(List<Job> val) {
    _newJobs = val;
    _jobService.jobs = val;
    notifyListeners();
  }

  set jobResponses(List<Map<String, dynamic>> val) {
    _jobResponses = val;
    notifyListeners();
  }

  bool isOwner() {
    return _authService.isOwner();
  }
}
