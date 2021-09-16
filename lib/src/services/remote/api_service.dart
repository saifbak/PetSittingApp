import 'package:dio/dio.dart';
import 'package:whiskers_away_app/src/services/remote/api_client.dart';

class ApiService {
  late ApiClient _apiClient;

  ApiService() {
    var dio = Dio();
    _apiClient = ApiClient(dio);
  }

  ApiClient get client {
    return _apiClient;
  }
}
