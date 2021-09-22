import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_listing_card.dart';
import 'package:whiskers_away_app/src/shared/app_tab_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/views/employee_bookings/employee_booking_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class EmployeeBookingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeBookingsViewModel>.nonReactive(
      viewModelBuilder: () => EmployeeBookingsViewModel(),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final EmployeeBookingsViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: AppHeading(text: 'Employee Bookings'),
        ),
        VerticalSpacing(14),
        AppTabBar(
          tabs: model.managerEmployeeJobs,
          onChanged: (val) {},
          pagesContent: [
            Expanded(
              child: ListView.separated(
                  padding: AppBaseStyles.horizontalPadding
                      .copyWith(bottom: 16, top: 16),
                  itemBuilder: (_, index) {
                    final request = model.filledJobs[index];
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
                        role: Roles.manager,
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => VerticalSpacing(16),
                  itemCount: model.filledJobs.length),
            ),
            Expanded(
              child: ListView.separated(
                padding: AppBaseStyles.horizontalPadding
                    .copyWith(bottom: 16, top: 16),
                itemBuilder: (_, index) {
                  final request = model.openJobs[index];
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
                      role: Roles.manager,
                    ),
                  );
                },
                separatorBuilder: (_, __) => VerticalSpacing(16),
                itemCount: model.openJobs.length,
              ),
            ),
          ],
        )
      ],
    );
  }
}
