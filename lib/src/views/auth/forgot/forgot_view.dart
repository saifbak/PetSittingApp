import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
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

class ForgotView extends StatelessWidget {
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

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  //Controllers
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return ListView(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () => NavService.popOut,
            splashRadius: 24,
            padding: EdgeInsets.only(left: 30),
            constraints: BoxConstraints(),
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.primaryColor,
          ),
        ),
        VerticalSpacing(context.topSpace()),
        Center(child: AppLogo(width: screenSize.width / 2.5)),
        VerticalSpacing(screenSize.height * .05),
        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                controller: emailCtrl,
                hintText: 'Enter your username / email',
                label: 'Username / Email',
                prefixIcon: IconlyLight.profile,
                validator: (val) {
                  return DefaultValidator.required(val, "Email/Username");
                },
              ),
              Padding(
                padding: AppBaseStyles.horizontalPadding,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text(
                //       'Forgot Password ?',
                //       style: AppTextStyles.xMedium(
                //         color: AppColors.primaryColor,
                //       ),
                //     ),
                //   ],
                // ),
              ),
              VerticalSpacing(screenSize.height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                      text: 'Submit',
                      horizontalPadding: 50,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          autoValidate = AutovalidateMode.onUserInteraction;
                          return;
                        }
                        onSubmit(context);
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
                    ), */
                      }),
                ],
              ),
              // VerticalSpacing(24),
              // MultiStyleText(
              //   firstText: 'Don\'t have an account? ',
              //   secondText: 'Sign Up',
              //   onPressed: NavService.signupReplace,
              // ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> onSubmit(ctx) async {
    try {
      await model.login({
        "username": emailCtrl.text.trim(),
        "password": passwordCtrl.text.trim(),
      }, ctx);
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
