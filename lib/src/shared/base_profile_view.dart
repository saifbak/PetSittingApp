import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class BaseProfileView extends StatelessWidget {
  const BaseProfileView(
      {required this.centerContent,
      required this.bottomContent,
      required this.appTopBarText,
      this.user});

  final Widget centerContent;
  final Widget bottomContent;
  final String appTopBarText;
  final User? user;

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
                  centerText: true,
                ),
                VerticalSpacing(16),
                Stack(
                  children: [
                    AppBaseCard(
                      padding: EdgeInsets.zero,
                      height: screenSize.height -
                          (profileAvatarSize +
                              context.topSpace() +
                              screenSize.height * .09 +
                              42),
                      margin: EdgeInsets.only(
                        top: profileAvatarSize / 2,
                        left: 20,
                        right: 20,
                      ),
                      child: ListView(
                        padding: EdgeInsets.all(16),
                        children: [
                          VerticalSpacing((profileAvatarSize / 2) - 6),
                          Center(
                            child: Text(
                              user?.name ?? 'Ralph Johnson',
                              style: AppTextStyles.xLarge(
                                color: AppColors.darkGray,
                                weight: FontWeight.w500,
                              ),
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
                          VerticalSpacing(12),
                          centerContent,
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: profileAvatarSize,
                        height: profileAvatarSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                VerticalSpacing(20),
                Padding(
                  padding: AppBaseStyles.horizontalPadding,
                  child: bottomContent,
                ),
                AppSpacing(context).bottomSpacing,
              ],
            ),
          ],
        )
      ],
    );
  }
}
