import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../src/models/JobResponse.dart';

class Jobs with ChangeNotifier {
  // List<JobResp> _items = [];
  // bool loading = false;
  final _apiService = locator<ApiService>();

  // List<Job> get items {
  //   return [..._items];
  // }
  //JobResp post;

  // getAprrovedJobResponse() async {
  //   ApiResult<dynamic> apiResult = await _apiService.getAprrovedJobResponses();
  //   apiResult.when(
  //       success: (data) {
  //         post = data;
  //       },
  //       failure: (NetworkExceptions error) {});
  //   notifyListeners();
  // }
}
