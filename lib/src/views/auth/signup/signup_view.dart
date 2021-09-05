import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/app_logo.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
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
            children: [],
          ),
        )
      ],
    );
  }
}
