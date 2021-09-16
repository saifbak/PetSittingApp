import 'package:dio/dio.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/models/wrappers/response_wrapper.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_client.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';

class AuthService with ReactiveServiceMixin {
  ReactiveValue<User?> _user = ReactiveValue<User?>(null);
  User? get user => _user.value;

  AuthService() {
    listenToReactiveValues([_user]);
  }

  set user(User? user) {
    _user.value = user;
  }

  Future<ApiResult<dynamic>> register(User userRequest) async {
    try {
      final apiService = locator<ApiService>();
      ResponseWrapper response = await apiService.client
          .postReq("/signup", data: userRequest.toJson());

      return ApiResult.success(data: response.data);
    } catch (e) {
      DioError res = e as DioError;
      //var x = NetworkExceptions.getDioException(e);
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
      //print(NetworkExceptions.getErrorMessage(x));
      /* return ApiResult.failure(
        error: NetworkExceptions.getDioException(DioErrorType.response),
      ); */
    }
  }

  Future<ApiResult<dynamic>> login(
      Map<String, dynamic> userLoginRequest) async {
    try {
      final apiService = locator<ApiService>();
      ResponseWrapper response =
          await apiService.client.postReq("/login", data: userLoginRequest);

      LocalStorage.saveSP('token', 'Bearer ' + response.data['token']);

      final User userDetails = User(
        email: response.data['email'],
        name: response.data['name'],
        password: response.data['password'],
        id: response.data['id'],
      );
      user = userDetails;

      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }

  Future<ApiResult<User>> getUserDetails() async {
    try {
      final apiService = locator<ApiService>();
      ResponseWrapper response =
          await apiService.client.getReq("/user/details");

      final User userDetails = User(
        email: response.data['email'],
        name: response.data['name'],
        password: response.data['password'],
        id: response.data['id'],
      );
      user = userDetails;
      print(user.toString());
      print(response.data);
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
      final apiService = locator<ApiService>();
      // print(request);
      // print(request.toString());
      ResponseWrapper response =
          await apiService.client.postReq("/createjob", data: request);

      return ApiResult.success(data: response.data);
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
      );
    }
  }
}
