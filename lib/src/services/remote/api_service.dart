import 'package:dio/dio.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/models/wrappers/formdata_wrapper.dart';
import 'package:whiskers_away_app/src/models/wrappers/response_wrapper.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_client.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';

class ApiService {
  late ApiClient _apiClient;

  ApiService() {
    var dio = Dio();
    _apiClient = ApiClient(dio);
  }

  ApiClient get client {
    return _apiClient;
  }

  Future<ApiResult<dynamic>> register(User userRequest) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/signup", data: userRequest.toJson());
      // SnackbarService().showSnackbar(message: "");
      AppUtils.toastShow("User Registered Successfully");
      return ApiResult.success(data: response.data);
    } catch (e) {
      AppUtils.toastShow("Unsuccessful Registration !");
      // SnackbarService().showSnackbar(message: "Unsuccessful Registration !");
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<User>> login(Map<String, dynamic> userLoginRequest) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/login", data: userLoginRequest);

      LocalStorage.saveSP('token', 'Bearer ' + response.data['token']);

      final User userDetails = User(
        email: response.data['email'],
        name: response.data['name'],
        password: response.data['password'],
        address: response.data['address'],
        phone: response.data['phone'],
        id: response.data['id'],
        roleId: response.data['role_id'],
        profileImg: response.data['profile_img'],
      );
      return ApiResult.success(data: userDetails);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<dynamic>> uploadJobImage(Map<String, dynamic> data) async {
    try {
      var response = await _apiClient.postReq(
        "job/upload/image",
        data: FormDataWrapper.instance.fromMap(data),
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> uploadProfileImage(
      Map<String, dynamic> data) async {
    try {
      var response = await _apiClient.postReq(
        "user/upload/profileimage",
        data: FormDataWrapper.instance.fromMap(data),
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<User>> getUserDetails() async {
    try {
      ResponseWrapper response = await _apiClient.getReq("/user/details");

      final User userDetails = User(
        email: response.data['email'],
        name: response.data['name'],
        password: response.data['password'],
        phone: response.data['phone'],
        address: response.data['address'],
        id: response.data['id'],
        roleId: response.data['role_id'],
        profileImg: response.data['profile_img'],
      );

      return ApiResult.success(data: userDetails);
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<dynamic>> updateUserDetails(userData) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/user/updatedetails", data: userData);

      return ApiResult.success(data: response.data);
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<dynamic>> sendPetRequest(
      Map<String, dynamic> request) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/createjob", data: request);

      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<dynamic>> createPayment(payload) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/payment", data: payload);

      return ApiResult.success(data: response.data);
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<List<Job>>> getNewJobs() async {
    try {
      ResponseWrapper response =
          await _apiClient.getReq("/job/list?status=NEW");
      List<Job> jobs = response.data.map<Job>((item) {
        return new Job.fromJson(item);
      }).toList();
      return ApiResult.success(data: jobs);
    } catch (e) {
      print(e);
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<List<Job>>> getJobList(params) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/job/list", data: params);
      List<Job> jobs = response.data.map<Job>((item) {
        return new Job.fromJson(item);
      }).toList();
      return ApiResult.success(data: jobs);
    } catch (e) {
      print(e);
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<List<Job>>> getExploreJobs() async {
    try {
      ResponseWrapper response =
          await _apiClient.getReq("/job/list?status=NEW");
      List<Job> jobs = response.data.map<Job>((item) {
        return new Job.fromJson(item);
      }).toList();
      return ApiResult.success(data: jobs);
    } catch (e) {
      print(e);
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<dynamic>> requestToPetSit(request, desc) async {
    try {
      ResponseWrapper response = await _apiClient
          .postReq("/job/RequestToPetSit/${request.toString()}", data: desc);

      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<List<Map<String, dynamic>>>> getJobResponses(jobID) async {
    try {
      //print(request);
      print(jobID.toString());
      ResponseWrapper response =
          await _apiClient.getReq("/job/seeproposals/${jobID.toString()}");

      List<Map<String, dynamic>> jobResp =
          List<Map<String, dynamic>>.from(response.data);
      print(jobResp);
      return ApiResult.success(data: jobResp);
    } catch (e) {
      print(e);
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  // Future<ApiResult<List<Review>>> reviewResponses() async {
  //   try {
  //     ResponseWrapper response = await _apiClient.getReq("/job/viewreview/6");
  //     print(response.data);
  //     List<Review> reviews = response.data.map<Review>((item) {
  //       return new Review.fromJson(item);
  //     }).toList();
  //     return ApiResult.success(data: reviews);
  //   } catch (e) {
  //     print(e);
  //     return ApiResult.failure(
  //       error: NetworkExceptions.getDioException(e),
  //     );
  //   }
  // }
}
