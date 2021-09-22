import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_tab_bar.dart';
import 'package:whiskers_away_app/src/shared/pet_sitter_card.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/my_employees/my_employees_view_model.dart';

class MyEmployeesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyEmployeesViewModel>.nonReactive(
      viewModelBuilder: () => MyEmployeesViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final MyEmployeesViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Padding(
          padding: AppBaseStyles.horizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeading(text: 'My Employees'),
              VerticalSpacing(12),
              Text(
                'Month of March',
                style: AppTextStyles.xLarge(
                  color: AppColors.primaryColor,
                  weight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        VerticalSpacing(12),
        AppTabBar(
          tabs: model.weekDaysSequence,
          onChanged: (val) {},
          pagesContent: List.generate(
            model.weekDaysSequence.length,
            (idx) {
              return ListView.separated(
                shrinkWrap: true,
                padding: AppBaseStyles.horizontalPadding.copyWith(
                  bottom: 16,
                  top: 12,
                ),
                itemBuilder: (_, index) {
                  final sitter = model.petSittersList[index];
                  return Container();
                  /* return GestureDetector(
                    onTap: NavService.employeeDetails,
                    child: PetSitterCard(petSitter: sitter),
                  ); */
                },
                separatorBuilder: (_, __) => VerticalSpacing(16),
                itemCount: idx % 2 == 1
                    ? model.petSittersList.length - 2
                    : model.petSittersList.length,
              );
            },
          ),
          customTab: (isActive, value) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Text(
                    'Week of',
                    style: AppTextStyles.xxMedium(
                      color: isActive ? Colors.white : AppColors.gray,
                      weight: FontWeight.w300,
                    ),
                  ),
                  VerticalSpacing(4),
                  Text(
                    value,
                    style: AppTextStyles.xLarge(
                      weight: FontWeight.w500,
                      color: isActive ? Colors.white : AppColors.gray,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
