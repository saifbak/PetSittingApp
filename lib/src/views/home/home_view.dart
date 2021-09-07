import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final HomeViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          VerticalSpacing(context.topSpace() + screenSize.height * .05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WelcomeHeading(name: 'John Carter'),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.whisper,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_pic.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
