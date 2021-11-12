import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DIO;
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
      return ApiResult.success(data: response.data);
    } catch (e) {
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
        description: response.data['description'],
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

  Future<ApiResult<dynamic>> forgotPass(
      Map<String, dynamic> forgotPassRequest) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/password/reset", data: forgotPassRequest);
      return ApiResult.success(data: response.data);
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
        data: DIO.FormData.fromMap(data),
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> updateJobImage(Map<String, dynamic> data) async {
    try {
      var response = await _apiClient.postReq(
        "job/editjobimage",
        data: DIO.FormData.fromMap(data),
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> uploadProfileImage(
      Map<String, dynamic> data) async {
    try {
      var response = await _apiClient.postReq(
        "user/upload/profileimage",
        data: DIO.FormData.fromMap(data),
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<dynamic>> uploadLicenseImage(
      Map<String, dynamic> data) async {
    try {
      print('Payload data == >');
      print(data);
      var response = await _apiClient.postReq(
        "/upload/licenseimage",
        data: DIO.FormData.fromMap(data),
      );
      print('response.data===>');
      print(response.data);
      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<User>> getUserDetails() async {
    try {
      ResponseWrapper response = await _apiClient.getReq("/user/details");
      print(response.data);
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

  Future<ApiResult<dynamic>> submitReview(userData) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/job/reviewsubmit", data: userData);

      return ApiResult.success(data: response.data);
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<dynamic>> addToFavourite(userData) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/addtofavourite", data: userData);
      print('addToFavourite');
      print(response.message);
      return ApiResult.success(data: response.data);
    } catch (e) {
      print(e.toString());
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<dynamic>> sentEmail(userData) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/approve", data: userData);
      // print('addToFavourite');
      // print(response.message);
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

  Future<ApiResult<dynamic>> sendEditSubmitPetRequest(
      Map<String, dynamic> request) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("job/editjobdetails", data: request);

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
        print("item");
        print(item);
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

  Future<ApiResult<List<Job>>> completedJobs() async {
    try {
      ResponseWrapper response = await _apiClient.getReq("/job/completed");
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

  Future<ApiResult<List<dynamic>>> getAllEmployees() async {
    try {
      ResponseWrapper response = await _apiClient.getReq("/employees");
      List<dynamic> employees = response.data.map<dynamic>((item) {
        //return new Job.fromJson(item);
        return item;
      }).toList();
      print(employees);
      return ApiResult.success(data: employees);
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

  Future<ApiResult<dynamic>> deleteJob(data) async {
    try {
      ResponseWrapper response =
          await _apiClient.postReq("/job/delete", data: data);
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
