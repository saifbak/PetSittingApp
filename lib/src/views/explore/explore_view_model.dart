import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/job_service.dart';

import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

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

class PetOwner {
  final String name;
  final String imgUrl;
  final String date;
  final String desc;

  PetOwner(
    this.name,
    this.imgUrl,
    this.date,
    this.desc,
  );
}

class ExploreViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();
  final _jobService = locator<JobService>();

  List<Job> _exploreJobs = [];
  List<Job> _filteredJobs = [];

  TextEditingController searchController = TextEditingController();

  List<Job> get requestsList => [
        /* Request(
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
        ), */
      ];

  User? get user {
    return this._authService.user;
  }

  Future<List<Job>?> getExploreJobs() async {
    setBusy(true);
    ApiResult<List<Job>> apiResult = await _apiService.getJobList({
      'status': ['NEW'],
      'relations': ['owner', 'images']
    });
    apiResult.when(success: (data) {
      newJobs = data;
      print(data);
      setBusy(false);
    }, failure: (NetworkExceptions error) {
      setBusy(false);
    });
  }

  List<Job> get newJobs {
    return _exploreJobs;
  }

  set newJobs(List<Job> val) {
    _exploreJobs = val.toList();
    _filteredJobs = val.toList();
    _jobService.jobs = val.toList();
    notifyListeners();
  }

  List<Job> get filteredJobs {
    return _filteredJobs;
  }

  set filteredJobs(List<Job> val) {
    _filteredJobs = val;
    notifyListeners();
  }

  searchResult(String text) {
    final regex = RegExp("^.*($text).*\$", caseSensitive: false);

    if (text.isEmpty) {
      filteredJobs = newJobs.toList();
      return;
    }

    List<Job> searchedJobs = newJobs.where((job) {
      return regex.hasMatch(job.petName);
    }).toList();

    filteredJobs = searchedJobs;
  }
}
