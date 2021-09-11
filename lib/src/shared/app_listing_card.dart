import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class AppListingCard extends StatelessWidget {
  const AppListingCard({required this.request});
  final Request request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Colors.black.withOpacity(.08),
          ),
        ],
      ),
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
                    AppStatusVisibilityTag(text: request.status)
                  ],
                ),
              ),
            ],
          ),
          VerticalSpacing(12),
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
