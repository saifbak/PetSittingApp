import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/shared/app_divider.dart';
import 'package:whiskers_away_app/src/shared/app_label_text.dart';
import 'package:whiskers_away_app/src/shared/base_profile_view.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/employee_details/employee_details_view_model.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class EmployeeDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeDetailsViewModel>.nonReactive(
      viewModelBuilder: () => EmployeeDetailsViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final EmployeeDetailsViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return BaseProfileView(
      centerContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(),
          Row(
            children: [
              Icon(
                IconlyLight.call,
                size: 20,
                color: AppColors.primaryColor,
              ),
              HorizontalSpacing(),
              Text('9876543210')
            ],
          ),
          VerticalSpacing(),
          Row(
            children: [
              Icon(
                IconlyLight.message,
                size: 20,
                color: AppColors.primaryColor,
              ),
              HorizontalSpacing(),
              Text('ralphedwards 123@gmail.com')
            ],
          ),
          VerticalSpacing(),
          Row(
            children: [
              Icon(
                Icons.cake_outlined,
                size: 20,
                color: AppColors.primaryColor,
              ),
              HorizontalSpacing(),
              Text('October 23, 1993')
            ],
          ),
          VerticalSpacing(screenSize.height * .025),
          Center(child: AppDivider()),
          VerticalSpacing(screenSize.height * .025),
          AppLabelText(text: 'Availability'),
          VerticalSpacing(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  IconlyLight.calendar,
                  size: 20,
                  color: Colors.white,
                ),
                HorizontalSpacing(6),
                Text(
                  'Oct. 11 - 14',
                  style: AppTextStyles.xLarge(color: Colors.white),
                ),
                Spacer(),
                Text(
                  'Available',
                  style: AppTextStyles.xLarge(color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          VerticalSpacing(16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  IconlyLight.calendar,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
                HorizontalSpacing(6),
                Text(
                  'Oct. 20-30',
                  style: AppTextStyles.xLarge(color: AppColors.primaryColor),
                ),
                Spacer(),
                Text(
                  'Unavailable',
                  style: AppTextStyles.xLarge(color: AppColors.primaryColor),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryColor),
            ),
          ),
          VerticalSpacing(16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Icon(
                  IconlyLight.calendar,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
                HorizontalSpacing(6),
                Text(
                  'Nov. 10',
                  style: AppTextStyles.xLarge(color: AppColors.primaryColor),
                ),
                Spacer(),
                Text(
                  'Unavailable',
                  style: AppTextStyles.xLarge(color: AppColors.primaryColor),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
      bottomContent: SizedBox(),
      appTopBarText: 'Employee Details',
    );
  }
}
