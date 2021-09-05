import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_logo.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/views/auth/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final LoginViewModel model;
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
                hintText: 'Enter your username / email',
                label: 'Username / Email',
                prefixIconName: 'profile',
              ),
              AppTextField(
                hintText: 'Enter your password',
                label: 'Password',
                prefixIconName: 'lock',
                hasPasswordEye: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Airbnb Cereal',
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpacing(screenSize.height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: 'Log In',
                    horizontalPadding: 50,
                  ),
                ],
              ),
              VerticalSpacing(24),
              RichText(
                text: new TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Airbnb Cereal',
                    color: Color(0xFFB8B8B8),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = NavService.signupReplace,
                      text: 'Sign Up',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Airbnb Cereal',
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
