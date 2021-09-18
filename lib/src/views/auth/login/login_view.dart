import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_logo.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
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
                prefixIcon: IconlyLight.profile,
              ),
              AppTextField(
                hintText: 'Enter your password',
                label: 'Password',
                prefixIcon: IconlyLight.lock,
                hasPasswordEye: true,
              ),
              Padding(
                padding: AppBaseStyles.horizontalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password ?',
                      style: AppTextStyles.xMedium(
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
                    onPressed: NavService.home,
                  ),
                ],
              ),
              VerticalSpacing(24),
              MultiStyleText(
                firstText: 'Don\'t have an account? ',
                secondText: 'Sign Up',
                onPressed: NavService.signupReplace,
              ),
            ],
          ),
        )
      ],
    );
  }
}
