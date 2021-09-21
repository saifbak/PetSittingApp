import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/user_profile/user_profile_view_model.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserProfileViewModel>.nonReactive(
      viewModelBuilder: () => UserProfileViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final UserProfileViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    final noPadding = EdgeInsets.zero;

    return BaseProfileView(
      centerContent: Column(
        children: [
          AppTextField(
            padding: noPadding,
            hintText: 'Enter your fullname',
            label: 'Full Name',
            prefixIcon: IconlyLight.profile,
          ),
          AppTextField(
            padding: noPadding,
            hintText: 'Enter your phone number',
            label: 'Phone Number',
            prefixIcon: IconlyLight.call,
            textInputType: TextInputType.phone,
          ),
          AppTextField(
            padding: noPadding,
            hintText: 'Enter your address',
            label: 'Address',
            prefixIcon: IconlyLight.location,
          ),
          AppButton(
            text: 'Save',
            onPressed: () {},
          ),
        ],
      ),
      bottomContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: AppButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.square_arrow_right,
                color: Colors.white,
                size: 22,
              ),
              HorizontalSpacing(12),
              Text(
                'Logout',
                style: AppTextStyles.large(color: Colors.white),
              ),
            ],
          ),
          text: '',
        ),
      ),
      appTopBarText: 'Profile Edit',
    );
  }
}
