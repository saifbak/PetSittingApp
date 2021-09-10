import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class BaseProfileView extends StatelessWidget {
  const BaseProfileView({
    required this.centerContent,
    required this.bottomContent,
    required this.appTopBarText,
  });

  final Widget centerContent;
  final Widget bottomContent;
  final String appTopBarText;

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    final profileAvatarSize = 120.0;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenSize.height / 2.75,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
            Column(
              children: [
                AppTopBar(
                  text: appTopBarText,
                  color: Colors.white,
                ),
                VerticalSpacing(16),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: profileAvatarSize / 2, left: 20, right: 20),
                      child: Column(
                        children: [
                          VerticalSpacing((profileAvatarSize / 2) - 12),
                          Text(
                            'Ralph Edwards',
                            style: AppTextStyles.xLarge(
                              color: AppColors.darkGray,
                              weight: FontWeight.w500,
                            ),
                          ),
                          VerticalSpacing(4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconlyBold.location,
                                size: 16,
                                color: AppColors.primaryColor,
                              ),
                              HorizontalSpacing(4),
                              Text(
                                'Houston',
                                style: AppTextStyles.xxMedium(
                                  color: AppColors.darkGray,
                                ),
                              ),
                            ],
                          ),
                          VerticalSpacing(16),
                          centerContent,
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 20,
                            color: Colors.black.withOpacity(.08),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: profileAvatarSize,
                        height: profileAvatarSize,
                        decoration: BoxDecoration(
                          color: AppColors.whisper,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalSpacing(18),
                Padding(
                  padding: AppBaseStyles.horizontalPadding,
                  child: bottomContent,
                ),
                VerticalSpacing(screenSize.height * .04),
              ],
            ),
          ],
        )
      ],
    );
  }
}
