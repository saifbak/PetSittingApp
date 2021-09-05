import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_logo.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/views/auth/login/login_view_model.dart';
import 'package:whiskers_away_app/src/views/auth/signup/signup_view_model.dart';

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
  const _Body(this.model);
  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return ListView(
      children: [
        VerticalSpacing(context.topSpace()),
        Center(child: AppLogo(width: screenSize.width / 2.5)),
        VerticalSpacing(screenSize.height * .05),
        Form(
          child: Column(
            children: [
              AppTextField(
                hintText: 'Enter your fullname',
                label: 'Full Name',
                prefixIconName: 'user',
              ),
              AppTextField(
                hintText: 'Enter your username',
                label: 'Username',
                prefixIconName: 'profile',
              ),
              AppTextField(
                hintText: 'Enter your email address',
                label: 'Email',
                prefixIconName: 'mail',
              ),
              AppTextField(
                hintText: 'Enter your phone number',
                label: 'Phone Number',
                prefixIconName: 'phone',
              ),
              AppTextField(
                hintText: 'Enter your address',
                label: 'Address',
                prefixIconName: 'pin',
              ),
              AppTextField(
                hintText: 'Enter your password',
                label: 'Password',
                prefixIconName: 'lock',
                hasPasswordEye: true,
              ),
              VerticalSpacing(screenSize.height * .025),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: 'Sign Up',
                    horizontalPadding: 50,
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
}
