import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/user_profile/user_controller.dart';
import 'package:whiskers_away_app/src/views/user_profile/user_profile_view_model.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserProfileViewModel>.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      onModelReady: (model) => model.init(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  // final formKey = GlobalKey<FormState>();

  final UserProfileViewModel model;
  // final addressCtrl = TextEditingController();
  // final nameCtrl = TextEditingController();
  // final phoneCtrl = TextEditingController();
  _Body(this.model);
  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();
    final _authService = locator<AuthService>();
    final noPadding = EdgeInsets.zero;

    logoutUser() {
      LocalStorage.removeSP("token");
      NavService.loginClearAll();
      _authService.user = null;
    }

    // void logoutUser() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs?.clear();
    //   Navigator.pushAndRemoveUntil(context, ModalRoute.withName("/login-view"),
    //       ModalRoute.withName("/home-view"));
    // }

    Future<void> onSubmit() async {
      try {
        await model.updateUserDetails({
          "name": model.nameCtrl.text.trim(),
          "address": model.addressCtrl.text.trim(),
          "phone": model.phoneCtrl.text.trim(),
          /* "hourlyRate": model.isPetSitter()
              ? double.parse(model.hourlRateCtrl.text.trim())
              : null, */
        });
        NavService.home();
      } catch (e) {
        /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
      }
    }

    return BaseProfileView(
      isEditable: true,
      onClicked: changePhoto,
      networkImage: model.user?.profileImg,
      uploadImage: model.selectedImageFile,
      centerContent: Form(
        key: model.formKey,
        child: Column(
          children: [
            AppTextField(
              padding: noPadding,
              hintText: 'Enter your fullname',
              label: 'Full Name',
              prefixIcon: IconlyLight.profile,
              controller: model.nameCtrl,
            ),
            AppTextField(
              controller: model.phoneCtrl,
              padding: noPadding,
              hintText: 'Enter your phone number',
              label: 'Phone Number',
              prefixIcon: IconlyLight.call,
              textInputType: TextInputType.phone,
            ),
            AppTextField(
              controller: model.addressCtrl,
              padding: noPadding,
              hintText: 'Enter your address',
              label: 'Address',
              prefixIcon: IconlyLight.location,
            ),
            model.isPetSitter()
                ? AppTextField(
                    controller: model.hourlRateCtrl,
                    padding: noPadding,
                    hintText: 'Enter your hourly rate',
                    label: 'Hourly Rate',
                    prefixIcon: IconlyLight.wallet,
                    textInputType: TextInputType.phone,
                  )
                : Container(),
            AppButton(
              text: 'Save',
              onPressed: () {
                onSubmit();
              },
            ),
          ],
        ),
      ),
      bottomContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: AppButton(
          onPressed: () {
            logoutUser();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.square_arrow_right,
                color: Colors.white,
                size: 22,
              ),
              HorizontalSpacing(12),
              Text(
                'Logout',
                style: AppTextStyles.large(color: Colors.white),
              ),
            ],
          ),
          text: '',
        ),
      ),
      appTopBarText: 'Profile Edit',
      user: model.user!,
    );
  }

  changePhoto() {
    model.getFromCamera();
  }

  /* @protected
  void dispose() {
    model.selectedImageFile = null;
  } */
}
