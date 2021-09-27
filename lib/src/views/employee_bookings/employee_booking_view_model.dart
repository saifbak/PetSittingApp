import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class EmployeeBookingsViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();
  final _jobService = locator<JobService>();

  List<dynamic> _employees = [];

  List<dynamic> get employees {
    return _employees;
  }

  set employees(List<dynamic> val) {
    _employees = val;
    notifyListeners();
  }

  List<String> get managerEmployeeJobs => ['Filled jobs', "Open jobs"];

  List<Request> get filledJobs => [
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

  List<Request> get openJobs => [
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
        Request(
          'Sasha',
          '   Open   ',
          'May 01-04',
          'Houston',
          'Husky',
          'assets/images/dog_pic2.jpg',
          8,
          20,
          "Need someone to take care of my doggy for some days.",
        ),
      ];

  Future<List<dynamic>?> getAllBookings() async {
    setBusy(true);
    ApiResult<List<dynamic>> apiResult = await _apiService.getAllEmployees();
    apiResult.when(success: (data) {
      employees = data;
      print(employees);
      print(data);
      setBusy(false);
    }, failure: (NetworkExceptions error) {
      setBusy(false);
    });
  }
}
