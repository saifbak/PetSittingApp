import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/core/validators/default_validator.dart';
import 'package:whiskers_away_app/src/models/Job.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/edit_submitted_request/edit_submitted_request_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditSubmittedRequestView extends StatelessWidget {
  final Job request;
  final Roles role;

  const EditSubmittedRequestView({
    required this.request,
    required this.role,
  });
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditSubmittedRequestViewModel>.reactive(
      viewModelBuilder: () => EditSubmittedRequestViewModel(),
      onModelReady: (model) => model.init(request),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model, request, role),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final EditSubmittedRequestViewModel model;
  final Job request;
  final Roles role;

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  //Controllers

  _Body(this.model, this.request, this.role);
  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();
    print('request params edit submit ==>');
    print(request.id);
    print('model.selectedIndex');
    print(model.selectedIndex);
    print('Role.petOwner');
    print(role);

    // final petCtrl = TextEditingController(text: request.petName);
    // final locationCtrl = TextEditingController(text: request.location);
    // final ageCtrl = TextEditingController(text: request.age.toString());
    // final weightCtrl = TextEditingController(text: request.weight);
    // final breedCtrl = TextEditingController(text: request.breed);
    // final fromDateCtrl = TextEditingController(text: request.fromDate);
    // final toDateCtrl = TextEditingController(text: request.toDate);
    // final descriptionCtrl = TextEditingController(text: request.description);

    return Column(
      children: [
        AppTopBar(text: 'Edit Submitted Request'),
        VerticalSpacing(16),
        Form(
          key: formKey,
          child: Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: AppBaseStyles.horizontalPadding,
              children: [
                Text(
                  'Pet sitting services offered in yor own home are sales tax exempt, whereas pet sitting services offered in the sitter’s home are subject to standard sales tax rates',
                  style: AppTextStyles.xxMedium(color: AppColors.gray),
                ),
                VerticalSpacing(16),
                DottedBorder(
                  dashPattern: [6],
                  borderType: BorderType.RRect,
                  strokeWidth: 1.5,
                  radius: Radius.circular(16),
                  color: AppColors.primaryColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: model.imageUploadDisplay == false ||
                            model.selectedImageFile == null
                        ? (request.publicImage == null ||
                                request.publicImage == '')
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                width: double.infinity,
                                color: AppColors.primaryColor.withOpacity(.15),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/icons/add_img.png',
                                      width: 50,
                                    ),
                                    VerticalSpacing(),
                                    Text(
                                      'Add image',
                                      style: AppTextStyles.xxLarge(
                                          color: AppColors.primaryColor),
                                    )
                                  ],
                                ),
                              )
                            : Image.network(
                                request.publicImage!,
                              )
                        : Image.file(model.selectedImageFile!),
                  ),
                ),
                ImageUploadOptions(),
                VerticalSpacing(30),
                PetSittingPlace(),
                VerticalSpacing(20),
                AppTextField(
                  controller: model.petCtrl,
                  hintText: 'Enter pet name',
                  label: 'Pet Name',
                  padding: EdgeInsets.zero,
                  validator: (val) {
                    return DefaultValidator.required(val, "Pet Name");
                  },
                ),
                AppTextField(
                  controller: model.locationCtrl,
                  hintText: 'Enter location',
                  label: 'Location',
                  padding: EdgeInsets.zero,
                  validator: (val) {
                    return DefaultValidator.required(val, "Location");
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: model.ageCtrl,
                        hintText: 'Enter years',
                        label: 'Age',
                        textInputType: TextInputType.number,
                        padding: EdgeInsets.zero,
                        validator: (val) {
                          return DefaultValidator.required(val, "Age");
                        },
                      ),
                    ),
                    HorizontalSpacing(14),
                    Expanded(
                      child: AppTextField(
                        controller: model.weightCtrl,
                        hintText: 'Enter weight',
                        // textInputType: TextInputType.phone,
                        label: 'Weight',
                        padding: EdgeInsets.zero,
                        validator: (val) {
                          return DefaultValidator.required(val, "Weight");
                        },
                      ),
                    )
                  ],
                ),
                AppTextField(
                  controller: model.breedCtrl,
                  hintText: 'Enter breed',
                  label: 'Breed',
                  padding: EdgeInsets.zero,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: model.fromDateCtrl,
                        hintText: 'YYYY-MM-DD',
                        label: 'From',
                        padding: EdgeInsets.zero,
                        suffixIcon: IconlyLight.calendar,
                        //readOnlyField: true,
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            currentTime: request.fromDate != null
                                ? DateTime.parse(request.fromDate!)
                                : null,
                            onChanged: (date) {
                              model.fromDateCtrl.text = DateFormat("yyyy-MM-dd")
                                  .format(date)
                                  .toString();
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours.toString());
                            },
                            onConfirm: (date) {
                              print(
                                  'From Date ${DateFormat("yyyy-MM-dd").format(date).toString()}');
                            },
                          );
                        },
                      ),
                    ),
                    HorizontalSpacing(14),
                    Expanded(
                      child: AppTextField(
                        controller: model.toDateCtrl,
                        hintText: 'YYYY-MM-DD',
                        label: 'To',
                        padding: EdgeInsets.zero,
                        suffixIcon: IconlyLight.calendar,
                        //readOnlyField: true,
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            currentTime: request.toDate != null
                                ? DateTime.parse(request.toDate!)
                                : null,
                            onChanged: (date) {
                              model.toDateCtrl.text = DateFormat("yyyy-MM-dd")
                                  .format(date)
                                  .toString();
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours.toString());
                            },
                            onConfirm: (date) {
                              print(
                                  'confirm ${DateFormat("yyyy-MM-dd").format(date).toString()}');
                            },
                          );
                          // model.datePicker(context);
                        },
                      ),
                    )
                  ],
                ),
                AppTextField(
                  controller: model.descriptionCtrl,
                  hintText: 'Enter description',
                  label: 'Description',
                  padding: EdgeInsets.zero,
                  maxLines: 4,
                ),
                VerticalSpacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      text: 'Submit',
                      horizontalPadding: 70,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          autoValidate = AutovalidateMode.onUserInteraction;
                          return;
                        }
                        onSubmit(context);
                      },
                    ),
                  ],
                ),
                AppSpacing(context).bottomSpacing,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onSubmit(ctx) async {
    model.consolelog();
    print('from date');
    print(model.fromDateCtrl.text.trim());
    print('to date');
    print(model.toDateCtrl.text.trim());
    print('name');
    print(model.petCtrl.text.trim());
    try {
      await model.sendEditSubmitRequest({
        "job_id": request.id,
        "pet_name": model.petCtrl.text.trim(),
        "location": model.locationCtrl.text.trim(),
        "age": model.ageCtrl.text.trim(),
        "weight": model.weightCtrl.text.trim(),
        "from_date": model.fromDateCtrl.text.trim(),
        "to_date": model.toDateCtrl.text.trim(),
        "breed": model.breedCtrl.text.trim(),
        "description": model.descriptionCtrl.text.trim(),
        "sittingat": model.selectedIndex,
      }, ctx);
    } catch (e) {
      // Timer(Duration(seconds: 1), () {
      //   model.showErrorAlert(e);
      // });
    }
  }
}

class PetSittingPlace extends ViewModelWidget<EditSubmittedRequestViewModel> {
  @override
  Widget build(BuildContext context, EditSubmittedRequestViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pet sitting at',
          style: AppTextStyles.xxLarge(
            weight: FontWeight.w500,
            color: AppColors.darkGray,
          ),
        ),
        VerticalSpacing(),
        Container(
          padding: EdgeInsets.all(6),
          child: Row(
            children: List.generate(
              model.petSittingOptions.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => model.selectedIndex = index,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        model.petSittingOptions[index],
                        style: AppTextStyles.xxLarge(
                          weight: FontWeight.w500,
                          color: model.selectedIndex == index
                              ? Colors.white
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: model.selectedIndex == index
                          ? AppColors.primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 20,
                color: Colors.black.withOpacity(.06),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageUploadOptions
    extends ViewModelWidget<EditSubmittedRequestViewModel> {
  @override
  Widget build(BuildContext context, EditSubmittedRequestViewModel model) {
    return Container(
        //duration: Duration(milliseconds: 250),
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              model.getFromCamera();
            },
            child: Row(
              children: [
                Icon(
                  Icons.camera,
                  color: AppColors.primaryColor,
                ),
                HorizontalSpacing(4),
                Text(
                  'Camera',
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              model.getFromGallery();
            },
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  color: AppColors.primaryColor,
                ),
                HorizontalSpacing(4),
                Text('Gallery'),
              ],
            ),
          ),
        ],
      ),
    )
        //: VerticalSpacing(30),
        );
  }
}
