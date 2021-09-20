import 'package:dio/dio.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/models/User.dart';
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
        id: response.data['id'],
      );
      return ApiResult.success(data: userDetails);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<User>> getUserDetails() async {
    try {
      ResponseWrapper response = await _apiClient.getReq("/user/details");

      final User userDetails = User(
        email: response.data['email'],
        name: response.data['name'],
        password: response.data['password'],
        id: response.data['id'],
      );

      return ApiResult.success(data: userDetails);
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

  Future<ApiResult<List<Job>>> getNewJobs() async {
    try {
      ResponseWrapper response =
          await _apiClient.getReq("/job/list?status=NEW");
      List<Job> jobs = response.data.map<Job>((item) {
        return new Job.fromJson(item);
      }).toList();
      return ApiResult.success(data: jobs);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }
}
