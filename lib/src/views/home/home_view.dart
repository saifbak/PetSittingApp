import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_listing_card.dart';
import 'package:whiskers_away_app/src/shared/app_tab_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        AppUtils.setupCustomBottomSheetBuilders(model.petSittersList);
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
  final HomeViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Padding(
          padding: AppBaseStyles.horizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WelcomeHeading(name: model.user?.name ?? ''),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.whisper,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_pic.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(14),
        AppTabBar(
          onChanged: (type) {
            if (type == model.ownerRequests[1]) {
              model.getNewJobs();
            }
          },
          tabs: model.ownerRequests,
          pagesContent: [
            Column(
              children: [
                VerticalSpacing(12),
                Container(
                  margin: AppBaseStyles.horizontalPadding,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16),
                      suffixIcon: Icon(
                        IconlyLight.filter,
                        color: AppColors.primaryColor,
                      ),
                      hintText: 'Search ...',
                      hintStyle:
                          AppTextStyles.xMedium(color: Color(0xFF858585)),
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
                Expanded(
                  child: ListView.separated(
                      padding: AppBaseStyles.horizontalPadding
                          .copyWith(bottom: 16, top: 16),
                      itemBuilder: (_, index) {
                        final request = model.requestsList[index];
                        return GestureDetector(
                          onTap: () => NavService.petDetails(
                            arguments: PetDetailsViewArguments(
                              request: request,
                              role: Roles.petOwner,
                            ),
                          ),
                          child: AppListingCard(
                            _,
                            request: request,
                            role: Roles.petOwner,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => VerticalSpacing(16),
                      itemCount: model.requestsList.length),
                ),
              ],
            ),
            model.isBusy
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : ListView.separated(
                    padding: AppBaseStyles.horizontalPadding
                        .copyWith(bottom: 16, top: 16),
                    itemBuilder: (_, index) {
                      final request = model.newJobs[index];
                      return GestureDetector(
                        // onTap: () {
                        //   //   // NavService.petDetails(
                        //   //   //     arguments: PetDetailsViewArguments(
                        //   //   //   request: request,
                        //   //   //   role: Roles.petOwner,
                        //   //   // ));
                        //   model.bottomSheetService
                        //       .showCustomSheet(variant: 'listing');
                        // },
                        child: AppListingCard(
                          model,
                          request: request,
                          role: Roles.petOwner,
                          // model: model,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => VerticalSpacing(16),
                    itemCount: model.newJobs.length,
                  ),
          ],
        ),
        VerticalSpacing(16),
        model.isOwner()
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: 'Submit a request',
                    horizontalPadding: 30,
                    onPressed: NavService.requestSubmit,
                  ),
                ],
              )
            : Container(),
        AppSpacing(context).bottomSpacing,
      ],
    );
  }
}
