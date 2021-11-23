import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/shared/notifications_card.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/notifications/notifications_view_model.dart';
// import 'package:whiskers_away_app/src/views/request_submit/request_submit_view_model.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsViewModel>.reactive(
      viewModelBuilder: () => NotificationsViewModel(),
      onModelReady: (model) => model.getNotifications(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final NotificationsViewModel model;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  //Controllers
  final petCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final weightCtrl = TextEditingController();
  final breedCtrl = TextEditingController();
  final fromDateCtrl = TextEditingController();
  final toDateCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  _Body(this.model);
  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    print('model.selectedIndex');
    print(model.selectedIndex);

    return Column(
      children: [
        AppTopBar(text: 'Notifications', centerText: true),
        VerticalSpacing(16),
        model.isNotificationLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              )
            : VerticalSpacing(12),
        model.notifications.length > 0
            ? Expanded(
                child: ListView.separated(
                  padding: AppBaseStyles.horizontalPadding
                      .copyWith(bottom: 16, top: 16),
                  itemBuilder: (_, index) {
                    final request = model.notifications[index];
                    return GestureDetector(
                      onTap: () async {
                        //  NavService.petDetails(
                        //      arguments: PetDetailsViewArguments(
                        //   request: request,
                        //    role: Roles.petOwner,
                        //   ));
                      },
                      child: NotificationCard(
                        notification: request,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => VerticalSpacing(16),
                  itemCount: model.notifications.length,
                ),
              )
            : noRecord('No notifications yet...')

        // Form(
        //   key: formKey,
        //   child: Expanded(
        //     child: ListView(
        //       shrinkWrap: true,
        //       padding: AppBaseStyles.horizontalPadding,
        //       children: [
        //         Text(
        //           'Pet sitting services offered in yor own home are sales tax exempt, whereas pet sitting services offered in the sitter’s home are subject to standard sales tax rates',
        //           style: AppTextStyles.xxMedium(color: AppColors.gray),
        //         ),
        //         VerticalSpacing(16),
        //         DottedBorder(
        //           dashPattern: [6],
        //           borderType: BorderType.RRect,
        //           strokeWidth: 1.5,
        //           radius: Radius.circular(16),
        //           color: AppColors.primaryColor,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.all(Radius.circular(12)),
        //             child: model.imageUploadDisplay == false ||
        //                     model.selectedImageFile == null
        //                 ? Container(
        //                     padding: EdgeInsets.symmetric(vertical: 16),
        //                     width: double.infinity,
        //                     color: AppColors.primaryColor.withOpacity(.15),
        //                     child: Column(
        //                       children: [
        //                         Image.asset(
        //                           'assets/images/icons/add_img.png',
        //                           width: 50,
        //                         ),
        //                         VerticalSpacing(),
        //                         Text(
        //                           'Add image',
        //                           style: AppTextStyles.xxLarge(
        //                               color: AppColors.primaryColor),
        //                         )
        //                       ],
        //                     ),
        //                   )
        //                 : Image.file(model.selectedImageFile!),
        //           ),
        //         ),
        //         ImageUploadOptions(),
        //         VerticalSpacing(30),
        //         PetSittingPlace(),
        //         VerticalSpacing(20),
        //         AppTextField(
        //           controller: petCtrl,
        //           hintText: 'Enter pet name',
        //           label: 'Pet Name',
        //           padding: EdgeInsets.zero,
        //           validator: (val) {
        //             return DefaultValidator.required(val, "Pet Name");
        //           },
        //         ),
        //         AppTextField(
        //           controller: locationCtrl,
        //           hintText: 'Enter location',
        //           label: 'Location',
        //           padding: EdgeInsets.zero,
        //           validator: (val) {
        //             return DefaultValidator.required(val, "Location");
        //           },
        //         ),
        //         Row(
        //           children: [
        //             Expanded(
        //               child: AppTextField(
        //                 controller: ageCtrl,
        //                 hintText: 'Enter years',
        //                 label: 'Age',
        //                 textInputType: TextInputType.phone,
        //                 padding: EdgeInsets.zero,
        //                 validator: (val) {
        //                   return DefaultValidator.required(val, "Age");
        //                 },
        //               ),
        //             ),
        //             HorizontalSpacing(14),
        //             Expanded(
        //               child: AppTextField(
        //                 controller: weightCtrl,
        //                 hintText: 'Enter weight',
        //                 // textInputType: TextInputType.phone,
        //                 label: 'Weight',
        //                 padding: EdgeInsets.zero,
        //                 validator: (val) {
        //                   return DefaultValidator.required(val, "Weight");
        //                 },
        //               ),
        //             )
        //           ],
        //         ),
        //         AppTextField(
        //           controller: breedCtrl,
        //           hintText: 'Enter breed',
        //           label: 'Breed',
        //           padding: EdgeInsets.zero,
        //         ),
        //         Row(
        //           children: [
        //             Expanded(
        //               child: AppTextField(
        //                 controller: fromDateCtrl,
        //                 hintText: 'YYYY-MM-DD',
        //                 label: 'From',
        //                 padding: EdgeInsets.zero,
        //                 suffixIcon: IconlyLight.calendar,
        //                 //readOnlyField: true,
        //                 onTap: () {
        //                   DatePicker.showDatePicker(
        //                     context,
        //                     showTitleActions: true,
        //                     onChanged: (date) {
        //                       fromDateCtrl.text = DateFormat("yyyy-MM-dd")
        //                           .format(date)
        //                           .toString();
        //                       print('change $date in time zone ' +
        //                           date.timeZoneOffset.inHours.toString());
        //                     },
        //                     onConfirm: (date) {
        //                       print(
        //                           'From Date ${DateFormat("yyyy-MM-dd").format(date).toString()}');
        //                     },
        //                   );
        //                 },
        //               ),
        //             ),
        //             HorizontalSpacing(14),
        //             Expanded(
        //               child: AppTextField(
        //                 controller: toDateCtrl,
        //                 hintText: 'YYYY-MM-DD',
        //                 label: 'To',
        //                 padding: EdgeInsets.zero,
        //                 suffixIcon: IconlyLight.calendar,
        //                 //readOnlyField: true,
        //                 onTap: () {
        //                   DatePicker.showDatePicker(
        //                     context,
        //                     showTitleActions: true,
        //                     onChanged: (date) {
        //                       toDateCtrl.text = DateFormat("yyyy-MM-dd")
        //                           .format(date)
        //                           .toString();
        //                       print('change $date in time zone ' +
        //                           date.timeZoneOffset.inHours.toString());
        //                     },
        //                     onConfirm: (date) {
        //                       print(
        //                           'confirm ${DateFormat("yyyy-MM-dd").format(date).toString()}');
        //                     },
        //                   );
        //                   // model.datePicker(context);
        //                 },
        //               ),
        //             )
        //           ],
        //         ),
        //         AppTextField(
        //           controller: descriptionCtrl,
        //           hintText: 'Enter description',
        //           label: 'Description',
        //           padding: EdgeInsets.zero,
        //           maxLines: 4,
        //         ),
        //         VerticalSpacing(20),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             AppButton(
        //               text: 'Submit',
        //               horizontalPadding: 70,
        //               onPressed: () {
        //                 if (!formKey.currentState!.validate()) {
        //                   autoValidate = AutovalidateMode.onUserInteraction;
        //                   return;
        //                 }
        //                 // onSubmit(context);
        //               },
        //             ),
        //           ],
        //         ),
        //         AppSpacing(context).bottomSpacing,
        //       ],
        //     ),
        //   ),
        // ),
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
  // Future<void> onSubmit(ctx) async {
  //   print('from date');
  //   print(fromDateCtrl);
  //   print('to date');
  //   print(toDateCtrl);
  //   try {
  //     await model.sendPetRequest({
  //       "pet_name": petCtrl.text.trim(),
  //       "location": locationCtrl.text.trim(),
  //       "age": ageCtrl.text.trim(),
  //       "weight": weightCtrl.text.trim(),
  //       "from_date": fromDateCtrl.text.trim(),
  //       "to_date": toDateCtrl.text.trim(),
  //       "breed": breedCtrl.text.trim(),
  //       "description": descriptionCtrl.text.trim(),
  //       "sittingat": model.selectedIndex,
  //     }, ctx);
  //   } catch (e) {
  //     /* Timer(Duration(seconds: 1), () {
  //       model.showErrorAlert(e);
  //     }); */
  //   }
  // }
}
