import 'package:flutter/cupertino.dart';
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
  List<Job> _filteredJobs = [];
  List<Job> _newJobs = [];
  List<Job> _newJobsFiltered = [];
  List<Job> _jobHistory = [];
  List<Job> _jobHistoryFiltered = [];
  // List<Job> _approvedJobs = [];
  // List<Job> _approvedJobsFiltered = [];
  List<Map<String, dynamic>> _jobResponses = [];
  List<Map<String, dynamic>> _approvedJobs = [];

  TextEditingController openJobSearchController = TextEditingController();
  TextEditingController historyJobSearchController = TextEditingController();
  TextEditingController approvedJobSearchController = TextEditingController();

  Map<String, dynamic> loading = {
    'open': false,
    'history': false,
    'approved': false
  };

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

  List<String> get ownerRequests => [
        'Open Jobs',
        "Approved Jobs",
        "Job History",
      ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  User? get user {
    return this._authService.user;
  }

  getOpenJobs() async {
    setLoading('open', true);

    Map<String, dynamic> payload = {};

    if (_authService.isOwner()) {
      payload = {
        'status': ['NEW', 'IN_PROGRESS'],
        'role_id': 3,
        'user_id': _authService.user!.id,
        'relations': ['owner', 'images', 'reviews']
      };
    } else {
      payload = {
        'status': ['NEW', 'IN_PROGRESS', 'COMPELETED'],
        'relations': ['owner', 'images']
      };
    }

    ApiResult<List<Job>> apiResult = await getJobs(payload);

    apiResult.when(success: (data) {
      newJobs = data;
      setLoading('open', false);
    }, failure: (NetworkExceptions error) {
      setLoading('open', false);
    });
  }

  getFilteredJobs() async {
    setLoading('open', true);

    Map<String, dynamic> payload = {};

    if (_authService.isOwner()) {
      payload = {
        'status': ['NEW', 'IN_PROGRESS'],
        'role_id': 3,
        'user_id': _authService.user!.id,
        'relations': ['owner', 'images', 'reviews']
      };
    } else {
      payload = {
        'status': ['NEW', 'IN_PROGRESS', 'COMPELETED'],
        'relations': ['owner', 'images']
      };
    }

    ApiResult<List<Job>> apiResult = await getJobs(payload);

    apiResult.when(success: (data) {
      filteredJobs = data;
      setLoading('open', false);
    }, failure: (NetworkExceptions error) {
      setLoading('open', false);
    });
  }

  getJobHistory() async {
    setLoading('history', true);

    ApiResult<List<Job>> apiResult = await getJobs({
      'status': ['COMPELETED'],
      'role_id': 3,
      'user_id': _authService.user!.id,
      'relations': ['owner', 'images', 'assigned.petsitter', 'assigned.review']
    });

    apiResult.when(success: (data) {
      jobHistory = data;
      setLoading('history', false);
    }, failure: (NetworkExceptions error) {
      setLoading('history', false);
    });
  }

  Future<ApiResult<List<Job>>> getJobs(params) async {
    ApiResult<List<Job>> apiResult = await _apiService.getJobList(params);
    return apiResult;
  }

  Future<List<Map<String, dynamic>>?> getJobResponse(jobID) async {
    setBusy(true);

    ApiResult<dynamic> apiResult = await _apiService.getJobResponses(jobID);
    apiResult.when(success: (data) {
      jobResponses = data;
      print(jobResponses);
      setLoading('history', false);

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

  Future<List<Map<String, dynamic>>?> getAprrovedJobResponse() async {
    setLoading('approved', true);

    setBusy(true);

    ApiResult<dynamic> apiResult = await _apiService.getAprrovedJobResponses();
    apiResult.when(success: (data) {
      approvedJobs = data;
      // approvedJobs = approvedJobs.map((item)=>{
      //   return item;
      //   }}).toList();
      print('approvedJobs===>');
      print(approvedJobs);
      setLoading('approved', false);
      // setBusy(false);
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

  List<Job> get filteredJobs {
    return _filteredJobs;
  }

  List<Map<String, dynamic>> get jobResponses {
    return _jobResponses;
  }

  List<Map<String, dynamic>> get approvedJobs {
    return _approvedJobs;
  }

  set newJobs(List<Job> val) {
    _newJobs = val;
    _jobService.jobs = val;
    newJobsFiltered = val;
    notifyListeners();
  }

  set filteredJobs(List<Job> val) {
    _filteredJobs = val;
    _jobService.jobs = val;
    notifyListeners();
  }

  set jobResponses(List<Map<String, dynamic>> val) {
    _jobResponses = val;
    notifyListeners();
  }

  set approvedJobs(List<Map<String, dynamic>> val) {
    _approvedJobs = val.map<Map<String, dynamic>>((e) {
      e['base_price'] = e['price'];
      return e;
    }).toList();

    notifyListeners();
  }

  bool isOwner() {
    return _authService.isOwner();
  }

  setLoading(key, bool val) {
    loading[key] = val;
    notifyListeners();
  }

  get isOpenJobLoading {
    return this.loading['open'];
  }

  get isHistoryJobLoading {
    return this.loading['history'];
  }

  get isApprovedJobLoading {
    return this.loading['approved'];
  }

  List<Job> get jobHistory {
    return _jobHistory;
  }

  set jobHistory(List<Job> val) {
    _jobHistory = val;
    jobHistoryFiltered = val;
    notifyListeners();
  }

  set newJobsFiltered(List<Job> val) {
    _newJobsFiltered = val.toList();
    notifyListeners();
  }

  List<Job> get newJobsFiltered {
    return _newJobsFiltered;
  }

  set jobHistoryFiltered(List<Job> val) {
    _jobHistoryFiltered = val.toList();
    notifyListeners();
  }

  List<Job> get jobHistoryFiltered {
    return _jobHistoryFiltered;
  }

  searchResult(String type, String text) {
    final regex = RegExp("^.*($text).*\$", caseSensitive: false);
    List<Job> selectedJobs =
        type == 'open' ? newJobs.toList() : jobHistory.toList();

    if (text.isEmpty) {
      if (type == 'open') {
        newJobsFiltered = newJobs;
      } else {
        jobHistoryFiltered = jobHistory;
      }
      return;
    }

    List<Job> searchedJobs = selectedJobs.where((job) {
      return regex.hasMatch(job.petName);
    }).toList();

    if (type == 'open') {
      newJobsFiltered = searchedJobs;
    } else {
      jobHistoryFiltered = searchedJobs;
    }
  }
}
