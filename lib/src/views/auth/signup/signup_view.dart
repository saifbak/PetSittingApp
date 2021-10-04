import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_dropdown_menu.dart';
import 'package:whiskers_away_app/src/shared/app_label_text.dart';
import 'package:whiskers_away_app/src/shared/app_logo.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/auth/signup/signup_view_model.dart';
import 'package:whiskers_away_app/src/views/explore/explore_view.dart';
import 'package:whiskers_away_app/src/views/landing/landing_view.dart';
import 'package:whiskers_away_app/src/views/my_availability/my_availability_view.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final SignUpViewModel model;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  //Controllers
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  // final locationCtrl = TextEditingController();

  _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return ListView(
      children: [
        VerticalSpacing(context.topSpace()),
        Center(child: AppLogo(width: screenSize.width / 2.5)),
        VerticalSpacing(screenSize.height * .05),
        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                controller: nameCtrl,
                hintText: 'Enter your full name',
                label: 'Full Name',
                prefixIcon: IconlyLight.profile,
                validator: (val) {
                  return DefaultValidator.required(val, "Full Name");
                },
              ),
              AppTextField(
                controller: usernameCtrl,
                hintText: 'Enter your username',
                label: 'Username',
                prefixIcon: IconlyLight.profile,
                validator: (val) {
                  return DefaultValidator.required(val, "Username");
                },
              ),
              AppTextField(
                controller: emailCtrl,
                hintText: 'Enter your email address',
                label: 'Email',
                prefixIcon: IconlyLight.message,
                textInputType: TextInputType.emailAddress,
                validator: (val) {
                  String? emailRequired =
                      DefaultValidator.required(val, "Email");
                  if (emailRequired == null) {
                    return DefaultValidator.email(val);
                  }
                  return emailRequired;
                },
              ),
              AppTextField(
                controller: phoneCtrl,
                hintText: 'Enter your phone number',
                label: 'Phone Number',
                prefixIcon: IconlyLight.call,
                textInputType: TextInputType.phone,
                validator: (val) {
                  return DefaultValidator.required(val, "Phone");
                },
              ),
              RadioCheck(),
              // DropDown(),
              // AppTextField(
              //   controller: addressCtrl,
              //   hintText: 'Enter your address',
              //   label: 'Address',
              //   prefixIcon: IconlyLight.location,
              //   validator: (val) {
              //     return DefaultValidator.required(val, "Address");
              //   },
              // ),
              AppTextField(
                controller: passwordCtrl,
                hintText: 'Enter your password',
                label: 'Password',
                prefixIcon: IconlyLight.lock,
                hasPasswordEye: true,
                validator: (val) {
                  return DefaultValidator.minLength(val, 6, "Password")();
                },
              ),
              model.isPetSitter()
                  ? Container(
                      padding: AppBaseStyles.horizontalPadding,
                      child: Column(children: [
                        // HorizontalSpacing(16),
                        AppTextField(
                          padding: EdgeInsets.zero,
                          controller: descriptionCtrl,
                          hintText: 'Profile Description',
                          label: 'Profile Description',
                          textInputType: TextInputType.text,
                          maxLines: 4,
                          validator: (val) {
                            return DefaultValidator.required(
                                val, "Description");
                          },
                        ),
                        DottedBorder(
                          dashPattern: [6],
                          borderType: BorderType.RRect,
                          strokeWidth: 1.5,
                          radius: Radius.circular(16),
                          color: AppColors.primaryColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: model.imageUploadDisplay == false ||
                                    model.selectedImageFile == null
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    width: double.infinity,
                                    color:
                                        AppColors.primaryColor.withOpacity(.15),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/icons/add_img.png',
                                          width: 50,
                                        ),
                                        VerticalSpacing(),
                                        Text(
                                          'Add license image',
                                          style: AppTextStyles.xxLarge(
                                              color: AppColors.primaryColor),
                                        )
                                      ],
                                    ),
                                  )
                                : Image.file(model.selectedImageFile!),
                          ),
                        ),
                        ImageUploadOptions(),
                        //  padding: AppBaseStyles.horizontalPadding,
                      ]),
                    )
                  : Container(),
              VerticalSpacing(screenSize.height * .025),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: 'Sign Up',
                    horizontalPadding: 50,
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        autoValidate = AutovalidateMode.onUserInteraction;
                        return;
                      }
                      onSubmit(context);
                      /* 
                      Timer(Duration(seconds: 1), () {
                        print("---------->");
                        //model.dialogService.completeDialog(dialogz
                      });
                      print("0000000000000000"); */

                      /* NavService.landing(
                        arguments: LandingViewArguments(
                          navBarItems: [
                            // NavBarItem(
                            //   IconlyLight.search,
                            //   'Bookings',
                            //   HomeView(),
                            // ),
                            // NavBarItem(
                            //   IconlyLight.user2,
                            //   'My Employees',
                            //   MyEmployeesView(),
                            // ),
                            NavBarItem(
                              IconlyLight.search,
                              'Explore',
                              ExploreView(),
                            ),
                            NavBarItem(
                              IconlyLight.work,
                              'My Availability',
                              MyAvailabilityView(),
                            ),
                          ],
                        ),
                      ); */
                    },
                  ),
                ],
              ),
              VerticalSpacing(24),
              MultiStyleText(
                firstText: 'Already have an account? ',
                secondText: 'Login In',
                onPressed: NavService.loginReplace,
              ),
              VerticalSpacing(screenSize.height * .05),
            ],
          ),
        )
      ],
    );
  }

  Future<void> onSubmit(ctx) async {
    var data;
    if (model.selectedImageFile != null) {
      final data = {
        'license_img': Dio.MultipartFile.fromBytes(
          model.selectedImageFile!.readAsBytesSync(),
          filename: model.selectedImageFile!.path.split('/').last,
        ),
      };
    }
    print('dat===>');
    print(data);

    model.setSignUser({
      "email": emailCtrl.text.trim(),
      "password": passwordCtrl.text.trim(),
      "username": usernameCtrl.text.trim(),
      "name": nameCtrl.text.trim(),
      "address": addressCtrl.text.trim(),
      "description": model.isPetSitter() ? descriptionCtrl.text.trim() : null,
      "license_image": data,
      "phone": phoneCtrl.text.trim(),
      // "location": locationCtrl,
      // "location":
    });

    NavService.termsConditions();
  }
}

class ImageUploadOptions extends ViewModelWidget<SignUpViewModel> {
  @override
  Widget build(BuildContext context, SignUpViewModel model) {
    return Container(
        //duration: Duration(milliseconds: 250),
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              model.getFromCamera();
            },
            child: Row(
              children: [
                Icon(
                  Icons.camera,
                  color: AppColors.primaryColor,
                ),
                HorizontalSpacing(4),
                Text(
                  'Camera',
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              model.getFromGallery();
            },
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  color: AppColors.primaryColor,
                ),
                HorizontalSpacing(4),
                Text('Gallery'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

enum SingingCharacter { yes, no }
final locationCtrl = TextEditingController();

class RadioCheck extends ViewModelWidget<SignUpViewModel> {
  SingingCharacter? _character = SingingCharacter.no;
  @override
  Widget build(BuildContext context, SignUpViewModel model) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 22),
          child: Text('Live in New Jersey?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.left),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: <Widget>[
              Radio<SingingCharacter>(
                activeColor: AppColors.primaryColor,
                value: SingingCharacter.yes,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  model.locationCtrl.text = value as String;
                  print('Yes ===>');
                  print(value);
                  // setState(() { _character = value; });
                },
              ),
              Text(
                'Yes',
                style: new TextStyle(fontSize: 17.0),
              ),
              Radio<SingingCharacter>(
                activeColor: AppColors.primaryColor,
                value: SingingCharacter.no,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  model.locationCtrl.text = value as String;
                  print('No ===>');
                  print(value);
                  // setState(() { _character = value; });
                },
              ),
              Text(
                'No',
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
