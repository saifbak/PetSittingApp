import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/base_view.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/widgets/option_card.dart';

class OptionsSelectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OptionsSelectViewModel>.nonReactive(
      viewModelBuilder: () => OptionsSelectViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: BaseView(
            bgImageUrl: 'assets/images/bg_img_1.png',
            child: _Body(model),
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final OptionsSelectViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(context.topSpace() + screenSize.height * .05),
          Align(
            alignment: Alignment.centerLeft,
            child: MultiStyleText(
              firstText: 'Welcome,',
              firstTextStyle: AppTextStyles.xxLarge(),
              secondText: '\nJohn Carter',
              secondTextStyle: AppTextStyles.heading(),
            ),
          ),
          VerticalSpacing(screenSize.height * .04),
          Text(
            'Choose from the options below',
            style: AppTextStyles.xLarge(),
          ),
          VerticalSpacing(16),
          OptionCard(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.primaryColor.withOpacity(.16),
                    endIndent: 18,
                  ),
                ),
                Text(
                  'OR',
                  style: AppTextStyles.xLarge(
                    color: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: AppColors.primaryColor.withOpacity(.16),
                    indent: 18,
                  ),
                )
              ],
            ),
          ),
          OptionCard(
            textRight: false,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                onPressed: NavService.onBoarding,
                text: 'Continue',
                horizontalPadding: 50,
              ),
            ],
          ),
          VerticalSpacing(screenSize.height * .04),
        ],
      ),
    );
  }
}
