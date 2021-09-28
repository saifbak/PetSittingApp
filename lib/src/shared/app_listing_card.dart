import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/enums/role_enum.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
import 'package:whiskers_away_app/src/views/user_review/user_review_view.dart';

class AppListingCard extends StatelessWidget {
  AppListingCard(
    this.model, {
    required this.request,
    required this.role,
    this.hideResponse = false,
    this.showRating = false,
    this.bottomSheetCallback,
  });

  final model;
  final Job request;
  final Role role;
  Function? bottomSheetCallback;
  bool hideResponse;
  bool showRating;
  @override
  Widget build(BuildContext context) {
    final petSitterRole = role == Role.PET_SITTER;
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
                    role: petSitterRole ? Roles.petSitter : Roles.petOwner,
                  ));
                },
                child: ImageDisplayBox(
                  imgUrl: request.publicImage,
                  assetDefaultImage: 'pet.jpg',
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
                          role:
                              petSitterRole ? Roles.petSitter : Roles.petOwner,
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
                        AppStatusVisibilityTag(text: request.jobStatus ?? ''),
                        hideResponse == false
                            ? Container(
                                padding: EdgeInsets.only(left: 5),
                                child: GestureDetector(
                                  // padding: EdgeInsets.only(left: 10),
                                  onTap: () {
                                    //onSubmit(context);
                                    print(bottomSheetCallback);
                                    if (bottomSheetCallback != null) {
                                      bottomSheetCallback!();
                                    }
                                  },
                                  child: Icon(
                                    Icons.more_vert_rounded,
                                    size: 18,
                                    color: AppColors.primaryColor,
                                  ),
                                ))
                            : Container()
                      ])
                  ],
                ),
              ),
            ],
          ),
          /*  if (petSitterRole || role == Role.MANAGER) ...[
            VerticalSpacing(12),
            Text(
              request.description ?? '',
              style: AppTextStyles.xMedium(color: AppColors.gray),
            ),
          ], */
          VerticalSpacing(4),
          Row(
            children: [
              Icon(
                IconlyBold.location,
                size: 16,
                color: AppColors.primaryColor,
              ),
              HorizontalSpacing(4),
              // VerticalSpacing(2),
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
              ),
            ],
          ),
          showRating
              ? InkWell(
                  child: Column(
                    children: [
                      VerticalSpacing(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconlyBold.star,
                            size: 16,
                            color: AppColors.primaryColor,
                          ),
                          HorizontalSpacing(4),
                          Text(
                            'Give Rating',
                            style: AppTextStyles.xxMedium(
                              color: AppColors.darkGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    NavService.userReviewView(
                      arguments: UserReviewViewArguments(
                        assignedJob: request,
                      ),
                    );
                  },
                )
              : Container()
        ],
      ),
    );
  }

  Future<void> onSubmit(ctx) async {
    try {
      await model.getJobResponses(request.id, ctx);
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
