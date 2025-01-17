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
import 'package:firebase_messaging/firebase_messaging.dart';

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

class _Body extends StatefulWidget {
  final LoginViewModel model;

  _Body(this.model);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  String? dtoken;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        dtoken = value;
      });
    });
  }

  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  //Controllers
  final emailCtrl = TextEditingController();

  final passwordCtrl = TextEditingController();

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
                controller: emailCtrl,
                hintText: 'Enter your username / email',
                label: 'Username / Email',
                prefixIcon: IconlyLight.profile,
                validator: (val) {
                  return DefaultValidator.required(val, "Email/Username");
                },
              ),
              AppTextField(
                controller: passwordCtrl,
                hintText: 'Enter your password',
                label: 'Password',
                prefixIcon: IconlyLight.lock,
                hasPasswordEye: true,
                validator: (val) {
                  return DefaultValidator.required(val, "Password");
                },
              ),
              Padding(
                padding: AppBaseStyles.horizontalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavService.forgot();
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: AppTextStyles.xMedium(
                          color: AppColors.primaryColor,
                        ),
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

  Future<void> onSubmit(ctx) async {
    try {
      await widget.model.login({
        "username": emailCtrl.text.trim(),
        "password": passwordCtrl.text.trim(),
        "devicetoken": dtoken
      }, ctx);
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
