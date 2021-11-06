import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/api_service.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/remote/api_result.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:intl/intl.dart';

class EditSubmittedRequestViewModel extends BaseViewModel {
  List<String> get petSittingOptions => ['Own home', "Sitter's home"];
  DateTime selectedDate = DateTime.now();
  late TextEditingController fromDateCtrl,
      toDateCtrl,
      petCtrl,
      locationCtrl,
      ageCtrl,
      weightCtrl,
      breedCtrl,
      descriptionCtrl;

  final _apiService = locator<ApiService>();
  final _authService = locator<AuthService>();
  final dialogService = locator<DialogService>();

  bool _imageUploadDisplay = false;
  bool imageUploadLoading = false;
  late File? _selectedImageFile;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  Future<void> sendEditSubmitRequest(Map<String, dynamic> payload, ctx) async {
    setBusy(true);
    try {
      print('Payloadd');
      print(payload);
      dialogService.showCustomDialog(
          variant: 'spinner', barrierDismissible: true);

      payload['petowner_id'] = _authService.user!.id;
      ApiResult apiResult = await _apiService.sendEditSubmitPetRequest(payload);

      apiResult.when(success: (data) async {
        print("WHEN EDIT REQUEST SUBMIT");
        print(selectedImageFile);
        if (selectedImageFile != null) {
          await updateImage(selectedImageFile!, data['id']);
        }
        setBusy(false);
        NavService.home();
      }, failure: (NetworkExceptions error) {
        showErrorAlert(error);
        setBusy(false);
        //NetworkExceptions.getErrorMessage(error);
      });
    } catch (e) {
      print(e.toString());
      setBusy(false);
    }
  }

  showErrorAlert(e) {
    dialogService.showDialog(
      title: 'Error Occurred',
      description: NetworkExceptions.getErrorMessage(e),
      buttonTitle: 'Cancel',
      buttonTitleColor: AppColors.primaryColor,
    );
  }

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

  Future<void> uploadImage(File image, jobID) async {
    imageUploadLoading = true;

    final data = {
      'image': Dio.MultipartFile.fromBytes(
        image.readAsBytesSync(),
        filename: image.path.split('/').last,
      ),
      'job_id': jobID
    };
    final res = await _apiService.uploadJobImage(data);
    res.when(
      success: (data) {
        imageUploadLoading = false;
        //imagePath = data['image_path'];
        //profileImage = data['image_url'];
      },
      failure: (error) {
        imageUploadLoading = false;
      },
    );
  }

  /// Get from gallery
  getFromGallery() async {
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

  /// Get from Camera
  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
      //maxWidth: 1800,
      //maxHeight: 1800,
    );
    if (pickedFile != null) {
      selectedImageFile = File(pickedFile.path);
    }
  }

  void init() {
    fromDateCtrl = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(selectedDate).toString());
    toDateCtrl = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(selectedDate).toString());
    petCtrl = TextEditingController();
    locationCtrl = TextEditingController();
    ageCtrl = TextEditingController();
    weightCtrl = TextEditingController();
    breedCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
    print('description');
    print(job?.breed);
  }

  consolelog() {
    print('checking the whole jobs==>');
    print(job);
  }

  // consolelog();
  // hourlRateCtrl = TextEditingController(text: user!.hourlyRate.toString());

  Job? get job {
    return this._authService.job;
  }

  datePicker(BuildContext ctx) async {
    final DateTime? selected = await showDatePicker(
      context: ctx,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
    }

    print(DateFormat("yyyy-MM-dd").format(selectedDate).toString());
  }

  Future<void> updateImage(File image, jobID) async {
    imageUploadLoading = true;

    final data = {
      'image': Dio.MultipartFile.fromBytes(
        image.readAsBytesSync(),
        filename: image.path.split('/').last,
      ),
      'job_id': jobID
    };
    final res = await _apiService.updateJobImage(data);
    res.when(
      success: (data) {
        imageUploadLoading = false;
        //imagePath = data['image_path'];
        //profileImage = data['image_url'];
      },
      failure: (error) {
        imageUploadLoading = false;
      },
    );
  }
}
