import 'dart:convert';

import 'package:whiskers_away_app/src/models/wrappers/response_wrapper.dart';
import 'package:whiskers_away_app/src/services/remote/api_client.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:flutter/foundation.dart';

class ApproveJob with ChangeNotifier {
  final _apiService = locator<ApiService>();
  final _jobService = locator<JobService>();
  final _authService = locator<AuthService>();

  List<Map<String, dynamic>> _approvedJobs = [];
  List<Job> _openJobs = [];

  List<Map<String, dynamic>> get approvedJobs {
    return _approvedJobs;
  }

  List<Job> get openJobs {
    return _openJobs;
  }

  Future get approveJobs async {
    ApiResult<dynamic> apiResult = await _apiService.getAprrovedJobResponses();
    apiResult.when(success: (data) {
      _approvedJobs = data;
      notifyListeners();
    }, failure: (NetworkExceptions error) {
      print("error");
      print(error);
    });
    return _approvedJobs;
  }

  Future<ApiResult<List<Job>>> getJobs(params) async {
    ApiResult<List<Job>> apiResult = await _apiService.getJobList(params);
    print('Get All Open Jobs');
    print(apiResult);
    return apiResult;
  }

  Future get getOpenJobs async {
    //setLoading('open', true);

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

    apiResult.when(
        success: (data) {
          _openJobs = data;
        },
        failure: (NetworkExceptions error) {});
  }

  // set newJobs(List<Job> val) {
  //   _openJobs = val;
  //   _jobService.jobs = val;
  //   //newJobsFiltered = val;
  //   notifyListeners();
  // }
}
