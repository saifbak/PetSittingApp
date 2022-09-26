import 'package:firebase_core/firebase_core.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
import 'package:provider/provider.dart';
import '../../../provider/job_provider.dart';
import '../../models/approveJob.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.getOpenJobs();
        model.getAprrovedJobResponse();
        // model.getFilteredJobs();
      },
      builder: (_, model, __) {
        return Scaffold(
          body: ChangeNotifierProvider(
            create: (context) => ApproveJob(),
            child: _Body(model),
          ),
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  final HomeViewModel model;
  const _Body(this.model);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  //late final FirebaseMessaging _messaging;

  @override
  void initState() {
    super.initState();
    context.read<ApproveJob>().approveJobs;
    context.read<ApproveJob>().openJobs;
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    initControllers();
  }

  void _filteredJobs(text) {
    var filteredData = widget.model.newJobs
        .where((job) => job.petName.toLowerCase().contains(text));
    print('Filter data');
    print(filteredData);
  }

  Future<void> initControllers() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title

      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,

                icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('gelleo');
    final screenSize = context.screenSize();
    //final jobsAppData = Provider.of<ApproveJob>(context).fetchData;
    //final comingJobs = jobsAppData.getAprrovedJobResponse();
    print('newJobsFiltered home ===>');
    print(widget.model.newJobsFiltered);
    return Consumer<ApproveJob>(
      builder: (context, value, child) => Column(
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
                        imgUrl: widget.model.user!.profileImg,
                        assetDefaultImage: "profile.png",
                      ),
                    ),
                    HorizontalSpacing(6),
                    WelcomeHeading(name: widget.model.user?.name ?? ''),
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
          widget.model.isOwner()
              ? AppTabBar(
                  onChanged: (type) {
                    if (type == widget.model.ownerRequests[0]) {
                      widget.model.getOpenJobs();
                      // model.getFilteredJobs();
                    }

                    if (type == widget.model.ownerRequests[1]) {
                      // widget.model.getAprrovedJobResponse();
                    }
                    if (type == widget.model.ownerRequests[2]) {
                      widget.model.getJobHistory();
                    }
                  },
                  tabs: widget.model.ownerRequests,
                  pagesContent: [
                    jobs(context),
                    widget.model.isApprovedJobLoading
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
                              value.approvedJobs.length > 0
                                  ? Expanded(
                                      child: ListView.separated(
                                          padding: AppBaseStyles
                                              .horizontalPadding
                                              .copyWith(bottom: 16, top: 16),
                                          itemBuilder: (_, index) {
                                            final newRequest = value;
                                            final request = widget
                                                .model.approvedJobs[index];
                                            return GestureDetector(
                                              onTap: () async {
                                                print(newRequest
                                                    .approvedJobs[index]);
                                              },
                                              child: ApprovedCard(
                                                  petSitter: newRequest
                                                      .approvedJobs[index]),
                                            );
                                          },
                                          separatorBuilder: (_, __) =>
                                              VerticalSpacing(16),
                                          itemCount: value.approvedJobs.length),
                                    )
                                  : noRecord('No job request submitted...')
                            ],
                          ),
                    widget.model.isHistoryJobLoading
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
                                      widget.model.searchResult('history', val),
                                  controller:
                                      widget.model.historyJobSearchController,
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
                              widget.model.jobHistoryFiltered.length > 0
                                  ? Expanded(
                                      child: ListView.separated(
                                          padding: AppBaseStyles
                                              .horizontalPadding
                                              .copyWith(bottom: 16, top: 16),
                                          itemBuilder: (_, index) {
                                            final request = widget.model
                                                .jobHistoryFiltered[index];
                                            return GestureDetector(
                                              onTap: () =>
                                                  NavService.petDetails(),
                                              child: AppListingCard(
                                                widget.model,
                                                request: request,
                                                role: Role.PET_OWNER,
                                                hideResponse: true,
                                                showRating: request.assigned?[
                                                            'review'] !=
                                                        null
                                                    ? false
                                                    : true,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (_, __) =>
                                              VerticalSpacing(16),
                                          itemCount: widget
                                              .model.jobHistoryFiltered.length),
                                    )
                                  : noRecord(
                                      'No job completed at the moment...'),
                            ],
                          ),
                  ],
                )
              : Expanded(child: jobs(context)),
          VerticalSpacing(16),
          widget.model.isOwner()
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
      ),
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
    return widget.model.isOpenJobLoading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          )
        : Consumer<ApproveJob>(
            builder: (context, value, child) => Column(
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
                    controller: widget.model.openJobSearchController,
                    onChanged: (val) => widget.model.searchResult('open', val),
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
                widget.model.newJobsFiltered.length > 0
                    ? Expanded(
                        child: ListView.separated(
                          padding: AppBaseStyles.horizontalPadding
                              .copyWith(bottom: 16, top: 16),
                          itemBuilder: (_, index) {
                            final request = widget.model.newJobsFiltered[index];
                            final newReq = value.openJobs;
                            return GestureDetector(
                              onTap: () async {
                                print("openJobss==");
                                //print(value.approveJobs=]);
                              },
                              child: AppListingCard(
                                widget.model,
                                request: request,
                                role: Role.PET_OWNER,
                                showRating: false,
                                hideResponse:
                                    widget.model.isOwner() ? false : true,
                                bottomSheetCallback:
                                    showBottomSheet(request, context),
                                // model: model,
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => VerticalSpacing(16),
                          itemCount: widget.model.newJobsFiltered.length,
                        ),
                      )
                    : noRecord('No new job request submitted...')
              ],
            ),
          );
  }

  Function showBottomSheet(request, context) {
    return () async {
      await widget.model.getJobResponse(request.id).then((value) => null);

      if (widget.model.isOwner()) {
        await showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) {
              return widget.model.isBusy
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : ListingSheet(list: widget.model.jobResponses);
            });
      }
    };
  }
}
