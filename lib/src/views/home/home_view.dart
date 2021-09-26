import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/core/enums/role_enum.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_listing_card.dart';
import 'package:whiskers_away_app/src/shared/app_tab_bar.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/home/widgets/listing_sheet.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.getOpenJobs();
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
              GestureDetector(
                onTap: NavService.userProfile,
                child: ImageDisplayBox(
                  size: 50,
                  imgUrl: model.user!.profileImg,
                  assetDefaultImage: "profile.png",
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(14),
        AppTabBar(
          onChanged: (type) {
            if (type == model.ownerRequests[0]) {
              model.getOpenJobs();
            }
            if (type == model.ownerRequests[1]) {
              model.getJobHistory();
            }
          },
          tabs: model.ownerRequests,
          pagesContent: [
            model.isOpenJobLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : model.newJobs.length > 0
                    ? ListView.separated(
                        padding: AppBaseStyles.horizontalPadding
                            .copyWith(bottom: 16, top: 16),
                        itemBuilder: (_, index) {
                          final request = model.newJobs[index];
                          return GestureDetector(
                            onTap: () async {
                              await model.getJobResponse(request.id);

                              print(model.jobResponses);

                              await showMaterialModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) {
                                    return model.isBusy
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            ),
                                          )
                                        : ListingSheet(
                                            list: model.jobResponses);
                                    //return Text('sdsdsdds');
                                    //await model.getJobResponse(request.id);
                                    //return ListingSheet(list: model.petSittersList);
                                    /* return FutureBuilder<dynamic>(
                                  future: model.getJobResponse(request
                                      .id), // function where you call your api
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    // AsyncSnapshot<Your object type>
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text('sdsd');
                                    } else {
                                      print("-------->coming");
                                      print(snapshot.data);
                                      if (snapshot.hasError)
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      else
                                        return Center(
                                            child: new Text('saddsa')); // s
                                    }
                                  },
                                ); */
                                  });

                              //  NavService.petDetails(
                              //      arguments: PetDetailsViewArguments(
                              //   request: request,
                              //    role: Roles.petOwner,
                              //   ));
                            },
                            child: AppListingCard(
                              model,
                              request: request,
                              role: Role.PET_OWNER,
                              // model: model,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => VerticalSpacing(16),
                        itemCount: model.newJobs.length,
                      )
                    : noRecord('No job request submitted...'),
            model.isHistoryJobLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : Column(
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
                      model.jobHistory.length > 0
                          ? Expanded(
                              child: ListView.separated(
                                  padding: AppBaseStyles.horizontalPadding
                                      .copyWith(bottom: 16, top: 16),
                                  itemBuilder: (_, index) {
                                    final request = model.jobHistory[index];
                                    return GestureDetector(
                                      onTap: () => NavService.petDetails(
                                        arguments: PetDetailsViewArguments(
                                          request: request,
                                          role: Roles.petOwner,
                                        ),
                                      ),
                                      child: AppListingCard(
                                        model,
                                        request: request,
                                        role: Role.PET_OWNER,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, __) =>
                                      VerticalSpacing(16),
                                  itemCount: model.jobHistory.length),
                            )
                          : noRecord('No job completed at the moment...'),
                    ],
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

  Widget noRecord(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.xLarge(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
