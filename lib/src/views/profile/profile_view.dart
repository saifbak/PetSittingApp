import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/expanded_section.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/shared/read_more_scrollable_content.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/profile/profile_view_model.dart';

final _authService = locator<AuthService>();

class ProfileView extends StatelessWidget {
  final dynamic user;

  ProfileView(this.user);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) {
        model.userDetails = user;
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
  final ProfileViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    Map<String, dynamic> additionalDetails = {
      'price': model.userDetails['price']
    };
    print('Review modal data =>');
    print(model.petUser.reviews.length > 0 ? 'full' : 'empty');
    print(model.userDetails['job_id']);

    return BaseProfileView(
        networkImage: model.petUser.profileImg,
        user: model.petUser,
        metaData: additionalDetails,
        centerContent: Column(
          children: [
            ExpandedSection(
              expand: !model.fullReviewsDisplay,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile Description',
                          style: AppTextStyles.xLarge(
                              color: AppColors.primaryColor,
                              weight: FontWeight.w500),
                        ),
                        VerticalSpacing(5),
                        Text(model.userDetails['petsitter']['description'] ??
                            ''),
                      ],
                    ),
                  ),
                  VerticalSpacing(20),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job Description',
                          style: AppTextStyles.xLarge(
                              color: AppColors.primaryColor,
                              weight: FontWeight.w500),
                        ),
                        VerticalSpacing(5),
                        Text(model.userDetails['description'] ?? ''),
                      ],
                    ),
                  ),
                  VerticalSpacing(20),
                  VerticalSpacing(12),
                  AppDivider(),
                  VerticalSpacing(12),
                ],
              ),
            ),
            Row(
              children: [
                MultiStyleText(
                  firstText: 'Reviews ',
                  firstTextStyle: AppTextStyles.xLarge(weight: FontWeight.w500),
                  secondText:
                      '(' + model.petUser.reviews.length.toString() + ')',
                  secondTextStyle:
                      AppTextStyles.xLarge(weight: FontWeight.w300),
                ),
                Spacer(),
                Text(
                  model.petUser.ratingFormatted!,
                  style: AppTextStyles.xxLarge(color: AppColors.gray),
                ),
                HorizontalSpacing(4),
                Row(
                  children: List.generate(
                    model.petUser.overallRating!,
                    (index) => Icon(
                      Icons.star,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            VerticalSpacing(),
            model.petUser.reviews.length > 0
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    height: model.fullReviewsDisplay ? 175 * 1.75 : 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.whisper),
                    ),
                    child: ReadMoreScrollableContent(
                      toggleBehaviour: true,
                      contentSeparator: VerticalSpacing(12),
                      readMoreCallback: (val) => model.fullReviewsDisplay = val,
                      readMoreContent: model.fullReviewsDisplay,
                      contentLength: model.petUser.reviews.length,
                      contentItemBuilder: (_, index) {
                        final review = model.petUser.reviews[index];
                        // print(review);
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                ImageDisplayBox(
                                  imgUrl: review['petowner'] != null
                                      ? review['petowner']!['profile_img']
                                      : AssetImage('assets/images/pet.jpg'),
                                  size: 30,
                                ),
                              ],
                            ),
                            HorizontalSpacing(),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        review['petowner'] != null
                                            ? review['petowner']['name']
                                            : '',
                                        style: AppTextStyles.xMedium(),
                                      ),
                                      Text(
                                        review['job'] != null
                                            ? review['job']['period']
                                            : '',
                                        style: AppTextStyles.xxSmall(
                                          color: AppColors.gray,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalSpacing(4),
                                  Row(
                                    children: List.generate(
                                      review['overall_rating'] > 0
                                          ? review['overall_rating']
                                          : [],
                                      (index) => Icon(
                                        Icons.star,
                                        size: 16,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  VerticalSpacing(4),
                                  InkWell(
                                    onTap: () async {
                                      await showMaterialModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (_) {
                                            return reviewDetailDialog(
                                                _, review);
                                          });
                                    },
                                    child: Text(
                                      review['comment'] != null
                                          ? review['comment']
                                          : '',
                                      style: AppTextStyles.xMedium(
                                        color: AppColors.gray,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Text('No reviews yet'),
          ],
        ),
        bottomContent: Row(
          children: [
            AppButton(
              text: 'Approve',
              fullWidth: true,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                        "Confirmation",
                        "Upon accepting a sitter’s proposal, you will be provided with the sitter’s contact information and given the opportunity to talk further and arrange a meet and greet. Once it is confirmed that you are comfortable with your sitter, you will need to mark the job as confirmed and submit payment within the app. This will lock in your sitter and confirm that they are officially scheduled for your job. (Sitters will not be paid until completing the job)",
                        'Confirm',
                        model));
              },
            ),
            HorizontalSpacing(18),
            AppButton(
              text: 'Reject',
              type: AppButtonType.outline,
              fullWidth: true,
              onPressed: () => NavService.popOut,
            ),
          ],
        ),
        appTopBarText: 'Pet Sitter Details');
  }

  Widget reviewDetailDialog(context, review) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 35),
      constraints: BoxConstraints(
        maxHeight: screenSize.height * .5,
        minHeight: screenSize.height * .5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gray,
                    width: 2.0,
                  ),
                ),
              ),
              child: Text(
                'Pet Sitter Review Details',
                style: AppTextStyles.large(
                  color: AppColors.darkGray,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            VerticalSpacing(30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How well did they take care of your pet?',
                      style: AppTextStyles.xxLarge(weight: FontWeight.w500),
                    ),
                    VerticalSpacing(),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            review['question1'],
                            (index) => Icon(
                              Icons.star,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        HorizontalSpacing(),
                        Text(
                          '(' + review['question1'].toString() + '/5)',
                          style: AppTextStyles.xLarge(),
                        )
                      ],
                    )
                  ],
                ),
                VerticalSpacing(25.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Would you recommend?',
                      style: AppTextStyles.xxLarge(weight: FontWeight.w500),
                    ),
                    VerticalSpacing(),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            review['question2'],
                            (index) => Icon(
                              Icons.star,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        HorizontalSpacing(),
                        Text(
                          '(' + review['question2'].toString() + '/5)',
                          style: AppTextStyles.xLarge(),
                        )
                      ],
                    )
                  ],
                ),
                VerticalSpacing(25.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Would you hire again?',
                      style: AppTextStyles.xxLarge(weight: FontWeight.w500),
                    ),
                    VerticalSpacing(),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            review['question3'],
                            (index) => Icon(
                              Icons.star,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        HorizontalSpacing(),
                        Text(
                          '(' + review['question3'].toString() + '/5)',
                          style: AppTextStyles.xLarge(),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // sentEmail

}

class CustomDialog extends StatelessWidget {
  final model;
  final String title, description, buttonText;

  CustomDialog(
    this.title,
    this.description,
    this.buttonText,
    this.model,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDialogtwo(model));
                    // Navigator.pop(context);
                  },
                  //  () {
                  //   CustomDialogtwo(model);
                  // },
                  child: Text(buttonText),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDialogtwo extends StatelessWidget {
  final model;
  // final String title, description, buttonText;

  CustomDialogtwo(
    this.model,
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 50,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Sitter Details',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Sitter name: ${model.petUser?.name ?? ''}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 13.0),
              Text(
                'Sitter email: ${model.petUser?.email ?? ''}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 13.0),
              Text(
                'Sitter contact no: ${model.petUser?.phone ?? ''}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {
                    sentEmail(context);
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> sentEmail(ctx) async {
    Navigator.pop(ctx);
    try {
      await model.sentEmail({
        "petsitter_id": model.petUser.id,
        "job_id": model.userDetails['job_id'],
      }, ctx);
      // _authService.navigateHomeScreen();
    } catch (e) {
      /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
    }
  }
}
