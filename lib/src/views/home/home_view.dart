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
import 'package:whiskers_away_app/src/shared/approved_card.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/pet_sitter_card.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/home/widgets/listing_sheet.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
import 'package:provider/provider.dart';
import '../../../provider/job_provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Jobs(),
      child: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) {
          model.getOpenJobs();
          model.getAprrovedJobResponse();
          // model.getFilteredJobs();
        },
        builder: (_, model, __) {
          return Scaffold(
            body: _Body(model),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final HomeViewModel model;
  const _Body(this.model);
  void _filteredJobs(text) {
    var filteredData =
        model.newJobs.where((job) => job.petName.toLowerCase().contains(text));
    print('Filter data');
    print(filteredData);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();
    final jobsAppData = Provider.of<Jobs>(context);
    //final comingJobs = jobsAppData.getAprrovedJobResponse();
    print('newJobsFiltered home ===>');
    print(model.newJobsFiltered);
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
                        Image(
                          image: AssetImage(
                            'assets/images/notification.png',
                          ),
                          width: 25,
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        VerticalSpacing(14),
        model.isOwner()
            ? AppTabBar(
                onChanged: (type) {
                  if (type == model.ownerRequests[0]) {
                    model.getOpenJobs();
                    // model.getFilteredJobs();
                  }

                  if (type == model.ownerRequests[1]) {
                    model.getAprrovedJobResponse();
                  }
                  if (type == model.ownerRequests[2]) {
                    model.getJobHistory();
                  }
                },
                tabs: model.ownerRequests,
                pagesContent: [
                  jobs(context),
                  model.isApprovedJobLoading
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
                            ),
                            model.approvedJobs.length > 0
                                ? Expanded(
                                    child: ListView.separated(
                                      padding: AppBaseStyles.horizontalPadding
                                          .copyWith(bottom: 16, top: 16),
                                      itemBuilder: (_, index) {
                                        //final newRequest = comingJobs[index];
                                        final request =
                                            model.approvedJobs[index];
                                        return GestureDetector(
                                          onTap: () async {},
                                          child: ApprovedCard(
                                            petSitter: request,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (_, __) =>
                                          VerticalSpacing(16),
                                      itemCount: model.approvedJobs.length,
                                    ),
                                  )
                                : noRecord('No job request submitted...')
                          ],
                        ),
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
                                onChanged: (val) =>
                                    model.searchResult('history', val),
                                controller: model.historyJobSearchController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 16),
                                  suffixIcon: Icon(
                                    IconlyLight.filter,
                                    color: AppColors.primaryColor,
                                  ),
                                  hintText: 'Search ...',
                                  hintStyle: AppTextStyles.xMedium(
                                      color: Color(0xFF858585)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(0xFFE7E7E7)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Color(0xFFE7E7E7)),
                                  ),
                                ),
                              ),
                            ),
                            model.jobHistoryFiltered.length > 0
                                ? Expanded(
                                    child: ListView.separated(
                                        padding: AppBaseStyles.horizontalPadding
                                            .copyWith(bottom: 16, top: 16),
                                        itemBuilder: (_, index) {
                                          final request =
                                              model.jobHistoryFiltered[index];
                                          return GestureDetector(
                                            onTap: () =>
                                                NavService.petDetails(),
                                            child: AppListingCard(
                                              model,
                                              request: request,
                                              role: Role.PET_OWNER,
                                              hideResponse: true,
                                              showRating:
                                                  request.assigned?['review'] !=
                                                          null
                                                      ? false
                                                      : true,
                                            ),
                                          );
                                        },
                                        separatorBuilder: (_, __) =>
                                            VerticalSpacing(16),
                                        itemCount:
                                            model.jobHistoryFiltered.length),
                                  )
                                : noRecord('No job completed at the moment...'),
                          ],
                        ),
                ],
              )
            : Expanded(child: jobs(context)),
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

  Widget jobs(context) {
    return model.isOpenJobLoading
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
                  controller: model.openJobSearchController,
                  onChanged: (val) => model.searchResult('open', val),
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
              model.newJobsFiltered.length > 0
                  ? Expanded(
                      child: ListView.separated(
                        padding: AppBaseStyles.horizontalPadding
                            .copyWith(bottom: 16, top: 16),
                        itemBuilder: (_, index) {
                          final request = model.newJobsFiltered[index];
                          return GestureDetector(
                            onTap: () async {},
                            child: AppListingCard(
                              model,
                              request: request,
                              role: Role.PET_OWNER,
                              showRating: false,
                              hideResponse: model.isOwner() ? false : true,
                              bottomSheetCallback:
                                  showBottomSheet(request, context),
                              // model: model,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => VerticalSpacing(16),
                        itemCount: model.newJobsFiltered.length,
                      ),
                    )
                  : noRecord('No job request submitted...')
            ],
          );
  }

  Function showBottomSheet(request, context) {
    return () async {
      await model.getJobResponse(request.id).then((value) => null);

      if (model.isOwner()) {
        await showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return model.isBusy
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : ListingSheet(list: model.jobResponses);
            });
      }
    };
  }
}
