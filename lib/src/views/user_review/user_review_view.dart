import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.locator.dart';
import 'package:whiskers_away_app/src/models/User.dart';
import 'package:whiskers_away_app/src/services/local/auth_service.dart';
import 'package:whiskers_away_app/src/services/local/local_storage_service.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/rating_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/user_review/user_review_view_model.dart';

class UserReviewView extends StatelessWidget {
  final dynamic assignedJob;
  User? petsitter;

  UserReviewView({this.assignedJob});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserReviewViewModel>.reactive(
      viewModelBuilder: () => UserReviewViewModel(),
      onModelReady: (model) {
        model.init();
        model.assignedJob = assignedJob;
        model.petsitter = model.assignedJob.assigned['petsitter'];
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
  // final formKey = GlobalKey<FormState>();

  final UserReviewViewModel model;
  // final addressCtrl = TextEditingController();
  // final nameCtrl = TextEditingController();
  // final phoneCtrl = TextEditingController();
  _Body(this.model);
  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();
    final _authService = locator<AuthService>();
    final noPadding = EdgeInsets.zero;

    Future<void> onSubmit() async {
      Map<String, dynamic> payload = {
        "comment": model.commentCtrl.text.trim(),
        "question1": model.question1,
        "question2": model.question2,
        "question3": model.question3,
        "job_id": model.assignedJob.id,
        "petsitter_id": model.assignedJob.assigned['petsitter_id'],
      };
      try {
        await model.submitReview(payload);
      } catch (e) {
        /* Timer(Duration(seconds: 1), () {
        model.showErrorAlert(e);
      }); */
      }
    }

    return SingleChildScrollView(
      child: BaseProfileView(
        networkImage: model.petsitter?.profileImg,
        uploadImage: model.selectedImageFile,
        centerContent: Form(
          key: model.formKey,
          child: Column(
            children: [
              RatingDisplayBox(
                text: 'How well did they take care of your pet',
                rating: (val) {
                  model.question1 = val;
                  //return 5;
                },
              ),
              VerticalSpacing(10.0),
              RatingDisplayBox(
                text: 'Would you recommend?',
                rating: (val) {
                  model.question2 = val;
                  //return 5;
                },
              ),
              VerticalSpacing(10.0),
              RatingDisplayBox(
                text: 'Would you hire again?',
                rating: (val) {
                  print(val);
                  model.question3 = val;
                  //return 5;
                },
              ),
              VerticalSpacing(10.0),
              AppTextField(
                controller: model.commentCtrl,
                hintText: 'Type here any other comments...',
                label: 'Any other comments:',
                padding: EdgeInsets.zero,
                maxLines: 4,
              ),
              VerticalSpacing(10.0),
              AppButton(
                text: 'Submit',
                onPressed: () {
                  onSubmit();
                },
              ),
            ],
          ),
        ),
        bottomContent: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container()),
        appTopBarText: 'Review Pet Sitter',
        user: model.petsitter,
      ),
    );
  }
}
