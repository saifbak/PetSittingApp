import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';

import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:image_picker/image_picker.dart';

class UserProfileViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _apiService = locator<ApiService>();
  final formKey = GlobalKey<FormState>();
  late TextEditingController addressCtrl, nameCtrl, phoneCtrl, descriptionCtrl;
  File? _selectedImageFile;

  Future<dynamic> updateUserDetails(userData) async {
    ApiResult apiResult = await _apiService.updateUserDetails(userData);
    apiResult.when(success: (data) async {
      _authService.user!.name = data['name'];
      _authService.user!.address = data['address'];
      _authService.user!.phone = data['phone'];
      _authService.user!.description = data['description'];
      //_authService.user!.hourlyRate = data['hourlyRate'];
      if (selectedImageFile != null) {
        await uploadImage(selectedImageFile!);
      }
      _authService.navigateHomeScreen();
    }, failure: (err) {
      print(err);
      NavService.optionsSelect();
    });
  }

  File? get selectedImageFile => _selectedImageFile;
  set selectedImageFile(File? val) {
    _selectedImageFile = val;
    notifyListeners();
  }

  void init() {
    nameCtrl = TextEditingController(text: user!.name);
    phoneCtrl = TextEditingController(text: user!.phone);
    addressCtrl = TextEditingController(text: user!.address);
    descriptionCtrl = TextEditingController(text: user!.description);

    print('description');
    print(user!.description);
    // hourlRateCtrl = TextEditingController(text: user!.hourlyRate.toString());
  }

  User? get user {
    return this._authService.user;
  }

  bool isPetSitter() {
    return _authService.isPetSitter();
  }

  /// Get from Camera
  getFromCamera() async {
    /* XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      //maxWidth: 1800,
      //maxHeight: 1800,
    );
    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
    } */
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
      //maxWidth: 1800,
      //maxHeight: 1800,
    );
    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
    }
  }

  Future<void> uploadImage(File image) async {
    final data = {
      'profile_img': Dio.MultipartFile.fromBytes(
        image.readAsBytesSync(),
        filename: image.path.split('/').last,
      ),
    };
    final res = await _apiService.uploadProfileImage(data);
    res.when(
      success: (data) {
        _authService.user!.profileImg = data['profile_img'];
        notifyListeners();
        //imagePath = data['image_path'];
        //profileImage = data['image_url'];
      },
      failure: (error) {},
    );
  }
}
