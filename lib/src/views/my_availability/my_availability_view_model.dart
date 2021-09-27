import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';

class MyAvailabilityViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();
  final _jobService = locator<JobService>();

  List<Job> _jobBookings = [];

  List<Job> get jobBookings {
    return _jobBookings;
  }

  set jobBookings(List<Job> val) {
    _jobBookings = val;
    notifyListeners();
  }

  User? get user {
    return this._authService.user;
  }

  Future<List<Job>?> getAllBookings() async {
    setBusy(true);
    ApiResult<List<Job>> apiResult = await _apiService.getJobList({
      'status': ['COMPELETED'],
      'relations': ['owner', 'images']
    });
    apiResult.when(success: (data) {
      jobBookings = data;
      //print(newJobs[0]);
      print(data);
      setBusy(false);
    }, failure: (NetworkExceptions error) {
      setBusy(false);
    });
  }
}
