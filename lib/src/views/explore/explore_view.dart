import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/enums/role_enum.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_listing_card.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/explore/explore_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(),
      onModelReady: (model) {
        model.getExploreJobs();
      },
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final ExploreViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    // contains(obj, query) {
    //   var check = query.toLowerCase();
    //   var name = obj.name;
    //   if (name.toLowerCase().includes(check)) {
    //     return true;
    //   }
    //   return false;
    // }

    return Column(
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Padding(
          padding: AppBaseStyles.horizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: NavService.userProfile,
                    child: ImageDisplayBox(
                      size: 50,
                      imgUrl: model.user!.profileImg,
                      assetDefaultImage: "profile.png",
                    ),
                  ),
                  HorizontalSpacing(6),
                  WelcomeHeading(name: model.user?.name ?? ''),
                ],
              ),
              HorizontalSpacing(6),
              Row(
                children: [
                  GestureDetector(
                    onTap: NavService.notifications,
                    child: Row(
                      children: [
                        Icon(
                          IconlyBold.notification,
                          size: 30,
                          color: AppColors.primaryColor,
                        ),
                        // Positioned(
                        //   top: 0.0,
                        //   right: 0.0,
                        //   child: new Container(
                        //     padding: EdgeInsets.all(1),
                        //     decoration: new BoxDecoration(
                        //       color: Colors.red,
                        //       borderRadius: BorderRadius.circular(6),
                        //     ),
                        //     constraints: BoxConstraints(
                        //       minWidth: 12,
                        //       minHeight: 12,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        VerticalSpacing(14),
        Container(
          margin: AppBaseStyles.horizontalPadding,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              AppUtils.boxShadow1(),
            ],
          ),
          child: TextField(
            controller: model.searchController,
            onChanged: (e) => handleSearch(e),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16),
              suffixIcon: Icon(
                IconlyLight.filter,
                color: AppColors.primaryColor,
              ),
              hintText: 'Search ...',
              hintStyle: AppTextStyles.xMedium(color: Color(0xFF858585)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
            ),
          ),
        ),
        !model.isBusy
            ? Expanded(
                child: model.filteredJobs.length > 0
                    ? ListView.separated(
                        padding: AppBaseStyles.horizontalPadding
                            .copyWith(bottom: 16, top: 16),
                        itemBuilder: (_, index) {
                          final request = model.filteredJobs[index];
                          return GestureDetector(
                            onTap: () => NavService.petDetails(
                              arguments: PetDetailsViewArguments(
                                request: request,
                                role: Roles.petSitter,
                              ),
                            ),
                            child: AppListingCard(
                              model,
                              request: request,
                              role: Role.PET_SITTER,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => VerticalSpacing(16),
                        itemCount: model.filteredJobs.length,
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            "No Records Found...",
                            style: AppTextStyles.xLarge(
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
              )
            : Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
      ],
    );
  }

  handleSearch(String text) {
    model.filteredJobs.clear();
    model.searchResult(text);
  }

  // Widget noRecord(String text) {
  //   return Expanded(
  //     child: Center(
  //       child: Text(
  //         text,
  //         style: AppTextStyles.xLarge(color: AppColors.primaryColor),
  //       ),
  //     ),
  //   );
  // }
}
