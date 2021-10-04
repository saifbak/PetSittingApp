import 'dart:async';
import 'dart:io';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';

import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();
  late TextEditingController locationCtrl;

  bool _imageUploadDisplay = false;
  bool imageUploadLoading = false;
  late File? _selectedImageFile;

  Future<dynamic> signup(Map<String, dynamic> payload, ctx) async {
    setBusy(true);
    print('payload[licenseImg]===>');
    print(payload['licenseImg']);
    print(payload['license_image']);
    print('location controller===>');
    print(locationCtrl);
    try {
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      User user = new User(
        name: payload['name'],
        email: payload['email'],
        password: payload['password'],
        phone: payload['phone'],
        address: payload['address'],
        username: payload['username'],
        licenseImg: payload['licenseImg'],
        description:
            payload['description'] != null ? payload['description'] : "",
        roleId: _authService.getRoleById(),
        location: locationCtrl.text.trim(),
      );

      ApiResult apiResult = await _apiService.register(user);

      apiResult.when(success: (data) {
        showSuccessAlert();
        AppUtils.toastShow("User Registered Successfully");
        print(data);
      }, failure: (NetworkExceptions error) {
        AppUtils.toastShow("Unsuccessful Registration !");
        showErrorAlert(error);
      });

      setBusy(false);
    } catch (e) {
      print(e.toString());
      setBusy(false);
    }
  }

  init() {
    locationCtrl = TextEditingController(text: '0');
  }

  handleLocationChange(value) {
    locationCtrl.text = value ?? '';
    notifyListeners();
  }

  showErrorAlert(e) {
    dialogService.showDialog(
      title: 'Error Occurred',
      description: NetworkExceptions.getErrorMessage(e),
      buttonTitle: 'Cancel',
      buttonTitleColor: AppColors.primaryColor,
    );
  }

  showSuccessAlert() {
    dialogService.showDialog(
      title: 'Success',
      description:
          'Congratulations, your account has been created successfully.',
      buttonTitle: 'Okay',
      buttonTitleColor: AppColors.primaryColor,
    );
    Timer(Duration(seconds: 2), () {
      NavService.loginReplace();
    });
  }

  bool isPetSitter() {
    return _authService.isPetSitter();
  }

  setSignUser(Map<String, dynamic> user) {
    _authService.signupUser = user;
    notifyListeners();
  }

  //License Image getting functions

  bool get imageUploadDisplay => _imageUploadDisplay;
  set imageUploadDisplay(bool val) {
    _imageUploadDisplay = val;
    notifyListeners();
  }

  File? get selectedImageFile => _selectedImageFile;
  set selectedImageFile(File? val) {
    _selectedImageFile = val;
    imageUploadDisplay = true;
    notifyListeners();
  }

  // Future<void> uploadImage(File image) async {
  //   final data = {
  //     'license_img': Dio.MultipartFile.fromBytes(
  //       image.readAsBytesSync(),
  //       filename: image.path.split('/').last,
  //     ),
  //   };
  //   final res = await _apiService.uploadProfileImage(data);
  //   res.when(
  //     success: (data) {
  //       // _authService.user!.profileImg = data['license_img'];
  //       notifyListeners();
  //       //imagePath = data['image_path'];
  //       //profileImage = data['image_url'];
  //     },
  //     failure: (error) {},
  //   );
  // }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
      //maxWidth: 1800,
      //maxHeight: 1800,
    );
    if (pickedFile != null) {
      // Image();
      selectedImageFile = File(pickedFile.path);
    }
  }

  /// Get from Camera
  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
      //maxWidth: 1800,
      //maxHeight: 1800,
    );

    if (pickedFile != null) {
      // Image();
      selectedImageFile = File(pickedFile.path);
    }
  }

  // File selectedImageFile!;
  // await uploadImage(selectedImageFile!);
  // upload() {
  //   if (selectedImageFile != null) {
  //     Map<String, Dio.MultipartFile> data;
  //     return data = {
  //       'license_img': Dio.MultipartFile.fromBytes(
  //         selectedImageFile!.readAsBytesSync(),
  //         filename: selectedImageFile!.path.split('/').last,
  //       ),
  //     };
  //   }
  // }
}
