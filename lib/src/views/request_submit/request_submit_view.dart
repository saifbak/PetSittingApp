import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_textfield.dart';
import 'package:whiskers_away_app/src/shared/app_top_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/request_submit/request_submit_view_model.dart';

class RequestSubmitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestSubmitViewModel>.nonReactive(
      viewModelBuilder: () => RequestSubmitViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final RequestSubmitViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      children: [
        AppTopBar(text: 'Submit a Request'),
        VerticalSpacing(16),
        Form(
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
                    child: Container(
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
                    ),
                  ),
                ),
                VerticalSpacing(30),
                PetSittingPlace(),
                VerticalSpacing(20),
                AppTextField(
                  hintText: 'Enter pet name',
                  label: 'Pet Name',
                  padding: EdgeInsets.zero,
                ),
                AppTextField(
                  hintText: 'Enter location',
                  label: 'Location',
                  padding: EdgeInsets.zero,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        hintText: 'Enter age',
                        label: 'Age',
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    HorizontalSpacing(14),
                    Expanded(
                      child: AppTextField(
                        hintText: 'Enter weight',
                        label: 'Weight',
                        padding: EdgeInsets.zero,
                      ),
                    )
                  ],
                ),
                AppTextField(
                  hintText: 'Enter breed',
                  label: 'Breed',
                  padding: EdgeInsets.zero,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        hintText: 'Select date',
                        label: 'From',
                        padding: EdgeInsets.zero,
                        suffixIcon: IconlyLight.calendar,
                        readOnlyField: true,
                        onTap: () {},
                      ),
                    ),
                    HorizontalSpacing(14),
                    Expanded(
                      child: AppTextField(
                        hintText: 'Select date',
                        label: 'To',
                        padding: EdgeInsets.zero,
                        suffixIcon: IconlyLight.calendar,
                        readOnlyField: true,
                        onTap: () {},
                      ),
                    )
                  ],
                ),
                AppTextField(
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
                      onPressed: () => NavService.popOut,
                    ),
                  ],
                ),
                VerticalSpacing(screenSize.height * .04),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PetSittingPlace extends ViewModelWidget<RequestSubmitViewModel> {
  @override
  Widget build(BuildContext context, RequestSubmitViewModel model) {
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
