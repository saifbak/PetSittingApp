import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/services/remote/network_exceptions.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_logo.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/views/auth/signup/signup_view_model.dart';
import 'package:whiskers_away_app/src/views/explore/explore_view.dart';
import 'package:whiskers_away_app/src/views/landing/landing_view.dart';
import 'package:whiskers_away_app/src/views/my_availability/my_availability_view.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.nonReactive(
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
                hintText: 'Enter your fullname',
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
              AppTextField(
                controller: addressCtrl,
                hintText: 'Enter your address',
                label: 'Address',
                prefixIcon: IconlyLight.location,
                validator: (val) {
                  return DefaultValidator.required(val, "Address");
                },
              ),
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
    try {
      await model.signup({
        "email": emailCtrl.text.trim(),
        "password": passwordCtrl.text.trim(),
        "username": usernameCtrl.text.trim(),
        "name": nameCtrl.text.trim(),
        "address": addressCtrl.text.trim(),
        "phone": phoneCtrl.text.trim(),
      }, ctx);
      NavService.loginReplace();
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
