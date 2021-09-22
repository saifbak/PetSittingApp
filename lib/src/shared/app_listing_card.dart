import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class AppListingCard extends StatelessWidget {
  const AppListingCard(
    this.modell, {
    required this.request,
    required this.role,
  });
  final modell;
  final Job request;
  final Roles role;
  @override
  Widget build(BuildContext context) {
    print('AppListingCard');
    print(modell);
    print(role);
    final petSitterRole = role == Roles.petSitter;

    return AppBaseCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  NavService.petDetails(
                      arguments: PetDetailsViewArguments(
                    request: request,
                    role: Roles.petOwner,
                  ));
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.whisper,
                    image: DecorationImage(
                      image: AssetImage('assets/images/dog_pic1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              HorizontalSpacing(10),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavService.petDetails(
                            arguments: PetDetailsViewArguments(
                          request: request,
                          role: Roles.petOwner,
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.petName,
                            style: AppTextStyles.xLarge(
                              weight: FontWeight.w500,
                            ),
                          ),
                          VerticalSpacing(2),
                          Text(
                            request.breed ?? '',
                            style: AppTextStyles.xMedium(
                              color: AppColors.gray,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (petSitterRole) ...[
                      Row(
                        children: [
                          Text(
                            '${request.age} years old',
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
                            '${request.weight} lbs',
                            style:
                                AppTextStyles.xxMedium(color: AppColors.gray),
                          ),
                        ],
                      ),
                    ] else
                      Row(children: [
                        AppStatusVisibilityTag(text: request.status ?? ''),
                        Container(
                            padding: EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              // padding: EdgeInsets.only(left: 10),
                              onTap: () {
                                modell.bottomSheetService
                                    .showCustomSheet(variant: 'listing');
                              },
                              child: Icon(
                                Icons.more_vert_rounded,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                            ))
                      ])
                  ],
                ),
              ),
            ],
          ),
          if (petSitterRole) ...[
            VerticalSpacing(12),
            Text(
              request.description ?? '',
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
                request.location ?? '',
                style: AppTextStyles.xxMedium(
                  color: AppColors.darkGray,
                ),
              ),
              Spacer(),
              Text(
                request.period ?? '',
                style: AppTextStyles.xMedium(
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
