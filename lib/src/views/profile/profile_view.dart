import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/expanded_section.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/read_more_scrollable_content.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/payment/widgets/label_with_content.dart';
import 'package:whiskers_away_app/src/views/profile/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final ProfileViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return BaseProfileView(
        centerContent: Column(
          children: [
            ExpandedSection(
              expand: !model.fullReviewsDisplay,
              child: Column(
                children: [
                  Text(
                      "Dogs are my life. I have been doing this for 10 years now and I would not choose anything else. I love taking the dogs to the park and having them run around."),
                  VerticalSpacing(12),
                  Row(
                    children: [
                      LabelWithContent(
                        labelText: 'Experience',
                        content: '10 years',
                        contentIcon: IconlyLight.work,
                      ),
                      Spacer(),
                      LabelWithContent(
                        labelText: 'Prefers',
                        content: 'Dogs 10-24',
                        contentIcon: IconlyLight.category,
                      ),
                      Spacer(),
                    ],
                  ),
                  VerticalSpacing(12),
                  AppDivider(),
                  VerticalSpacing(12),
                ],
              ),
            ),
            Row(
              children: [
                MultiStyleText(
                  firstText: 'Reviews ',
                  firstTextStyle: AppTextStyles.xLarge(weight: FontWeight.w500),
                  secondText: '(20)',
                  secondTextStyle:
                      AppTextStyles.xLarge(weight: FontWeight.w300),
                ),
                Spacer(),
                Text(
                  '5.0',
                  style: AppTextStyles.xxLarge(color: AppColors.gray),
                ),
                HorizontalSpacing(4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            VerticalSpacing(),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              height: model.fullReviewsDisplay ? 175 * 1.75 : 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.whisper),
              ),
              child: ReadMoreScrollableContent(
                toggleBehaviour: true,
                contentSeparator: VerticalSpacing(12),
                readMoreCallback: (val) => model.fullReviewsDisplay = val,
                readMoreContent: model.fullReviewsDisplay,
                contentLength: model.reviewsList.length,
                contentItemBuilder: (_, index) {
                  final review = model.reviewsList[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ImageDisplayBox(
                            size: 30,
                            imgUrl: review.authorImgUrl,
                          ),
                        ],
                      ),
                      HorizontalSpacing(),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  review.authorName,
                                  style: AppTextStyles.xMedium(),
                                ),
                                Text(
                                  review.date,
                                  style: AppTextStyles.xxSmall(
                                    color: AppColors.gray,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacing(4),
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  Icons.star,
                                  size: 16,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            VerticalSpacing(4),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                              style: AppTextStyles.xMedium(
                                color: AppColors.gray,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        bottomContent: Row(
          children: [
            AppButton(
              text: 'Approve',
              fullWidth: true,
              onPressed: NavService.termsConditions,
            ),
            HorizontalSpacing(18),
            AppButton(
              text: 'Reject',
              type: AppButtonType.outline,
              fullWidth: true,
              onPressed: () => NavService.popOut,
            ),
          ],
        ),
        appTopBarText: 'Pet Sitter Details');
  }
}
