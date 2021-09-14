import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/read_more_scrollable_content.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/terms_conditions/terms_conditions_view_model.dart';

class TermsConditionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermsConditionsViewModel>.nonReactive(
      viewModelBuilder: () => TermsConditionsViewModel(),
      onModelReady: (model) {},
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final TermsConditionsViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTopBar(text: 'Terms & Conditions'),
        VerticalSpacing(16),
        Center(
          child: Image.asset(
            'assets/images/terms_bg.png',
            width: screenSize.width / 1.3,
          ),
        ),
        VerticalSpacing(16),
        Expanded(
          child: AppBaseCard(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Terms & Conditions',
                  style: AppTextStyles.large(
                    color: AppColors.darkGray,
                    weight: FontWeight.w500,
                  ),
                ),
                VerticalSpacing(),
                AppDivider(),
                VerticalSpacing(),
                ReadMoreScrollableContent(
                  contentLength: model.termsDemoData.length,
                  contentItemBuilder: (_, index) {
                    return Text(
                      model.termsDemoData[index],
                      style: AppTextStyles.xxLarge(color: Color(0xFF5C5C5C)),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        VerticalSpacing(20),
        Padding(
          padding: AppBaseStyles.horizontalPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TermsAgreementCheck(),
              VerticalSpacing(24),
              Row(
                children: [
                  AppButton(
                    text: 'Accept',
                    fullWidth: true,
                    onPressed: NavService.payment,
                  ),
                  HorizontalSpacing(18),
                  AppButton(
                    text: 'Reject',
                    type: AppButtonType.outline,
                    fullWidth: true,
                    onPressed: () => NavService.popOut,
                  ),
                ],
              )
            ],
          ),
        ),
        VerticalSpacing(screenSize.height * .04),
      ],
    );
  }
}

class TermsAgreementCheck extends ViewModelWidget<TermsConditionsViewModel> {
  @override
  Widget build(BuildContext context, TermsConditionsViewModel model) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => model.termsAccepted = !model.termsAccepted,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xFF9C9C9C)),
            ),
            child: model.termsAccepted
                ? Icon(
                    Icons.check,
                    size: 16,
                    color: AppColors.primaryColor,
                  )
                : SizedBox(),
          ),
        ),
        HorizontalSpacing(),
        MultiStyleText(
          firstText: 'I agree with the ',
          firstTextStyle: AppTextStyles.xMedium(color: Color(0xFF5C5C5C)),
          secondText: 'Terms and Conditions',
          secondTextStyle: AppTextStyles.xMedium(color: AppColors.primaryColor)
              .copyWith(decoration: TextDecoration.underline),
        ),
      ],
    );
  }
}
