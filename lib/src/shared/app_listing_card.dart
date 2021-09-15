import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class AppListingCard extends StatelessWidget {
  const AppListingCard({
    required this.request,
    required this.role,
  });
  final Request request;
  final Roles role;

  @override
  Widget build(BuildContext context) {
    final petSitterRole = role == Roles.petSitter;

    return AppBaseCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whisper,
                  image: DecorationImage(
                    image: AssetImage(request.dogImgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              HorizontalSpacing(10),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.dogName,
                          style: AppTextStyles.xLarge(
                            weight: FontWeight.w500,
                          ),
                        ),
                        VerticalSpacing(2),
                        Text(
                          request.dogBreed,
                          style: AppTextStyles.xMedium(
                            color: AppColors.gray,
                          ),
                        )
                      ],
                    ),
                    if (petSitterRole) ...[
                      Row(
                        children: [
                          Text(
                            '${request.dogAge} years old',
                            style:
                                AppTextStyles.xxMedium(color: AppColors.gray),
                          ),
                          HorizontalSpacing(4),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          HorizontalSpacing(4),
                          Text(
                            '${request.dogWeight.toInt()} lbs',
                            style:
                                AppTextStyles.xxMedium(color: AppColors.gray),
                          ),
                        ],
                      ),
                    ] else
                      AppStatusVisibilityTag(text: request.status)
                  ],
                ),
              ),
            ],
          ),
          if (petSitterRole) ...[
            VerticalSpacing(12),
            Text(
              request.desc,
              style: AppTextStyles.xMedium(color: AppColors.gray),
            ),
          ],
          VerticalSpacing(4),
          Row(
            children: [
              Icon(
                IconlyBold.location,
                size: 16,
                color: AppColors.primaryColor,
              ),
              HorizontalSpacing(4),
              Text(
                request.location,
                style: AppTextStyles.xxMedium(
                  color: AppColors.darkGray,
                ),
              ),
              Spacer(),
              Text(
                request.date,
                style: AppTextStyles.large(
                  weight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
