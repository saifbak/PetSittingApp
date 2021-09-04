import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/shared/base_view.dart';
import 'package:whiskers_away_app/src/views/onboarding/onboarding_view_model.dart';

class OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnBoardingViewModel>.nonReactive(
      viewModelBuilder: () => OnBoardingViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: BaseView(
            bgImageUrl: 'assets/images/bg_img_2.png',
            child: _Body(model),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final OnBoardingViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
