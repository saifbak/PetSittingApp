import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_button.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/app_listing_card.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        AppUtils.setupCustomBottomSheetBuilders(model.petSittersList);
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
  final HomeViewModel model;
  const _Body(this.model);

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Column(
      children: [
        VerticalSpacing(context.topSpace() + screenSize.height * .05),
        Padding(
          padding: AppBaseStyles.horizontalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WelcomeHeading(name: 'John Carter'),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.whisper,
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_pic.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing(14),
        Container(
          padding: EdgeInsets.all(6),
          margin: AppBaseStyles.horizontalPadding,
          child: Row(
            children: List.generate(
              model.ownerRequests.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () => model.selectedIndex = index,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        model.ownerRequests[index],
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
        VerticalSpacing(14),
        Container(
          margin: AppBaseStyles.horizontalPadding,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 20,
                color: Colors.black.withOpacity(.08),
              ),
            ],
          ),
          child: TextField(
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
        VerticalSpacing(16),
        Expanded(
          child: ListView.separated(
            padding: AppBaseStyles.horizontalPadding.copyWith(bottom: 16),
            itemBuilder: (_, index) {
              final request = model.selectedIndex == 0
                  ? model.requestsList[index]
                  : model.newRequestsList[index];
              return GestureDetector(
                onTap: model.selectedIndex == 0
                    ? () => NavService.petDetails(
                          arguments: PetDetailsViewArguments(request: request),
                        )
                    : () {
                        model.bottomSheetService
                            .showCustomSheet(variant: 'listing');
                      },
                child: AppListingCard(
                  request: request,
                ),
              );
            },
            separatorBuilder: (_, __) => VerticalSpacing(16),
            itemCount: model.selectedIndex == 0
                ? model.requestsList.length
                : model.newRequestsList.length,
          ),
        ),
        VerticalSpacing(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              text: 'Submit a request',
              horizontalPadding: 30,
              onPressed: NavService.requestSubmit,
            ),
          ],
        ),
        VerticalSpacing(screenSize.height * .04),
      ],
    );
  }
}
