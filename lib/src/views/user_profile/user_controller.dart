import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';
import 'package:whiskers_away_app/src/views/user_profile/user_profile_view_model.dart';

class UserController {
  var url =
      Uri.parse('http://whiskersaway.enorness.com/api/user/updatedetails');
  //http://whiskersaway.enorness.com/api/user/updatedetails

  User model = User(name: "ABc", email: "ABC");
  void updateUser() async {
    var params = {"name": "New User", "address": "karachi"};

    print(params);
    var response = await http.post(url, body: params, headers: {
      'Authorization': 'Bearer${LocalStorage.readSP('token').toString()}'
      // '${LocalStorage.readSP('token')}',
    });
    print(LocalStorage.readSP("token"));
    print(response.body);
  }
}
