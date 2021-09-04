import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/shared/base_view.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/views/splash/splash_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (_, model, __) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.white,
          ),
          child: Scaffold(
            body: BaseView(
              bgImageUrl: 'assets/images/bg_img_1.png',
              child: _Body(model),
            ),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final SplashViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Container(
      width: screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/logo_img.png'),
          VerticalSpacing(screenSize.height * .025),
          Image.asset('assets/images/logo_text.png'),
        ],
      ),
    );
  }
}
