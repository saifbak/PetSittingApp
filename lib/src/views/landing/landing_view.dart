import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/landing/landing_view_model.dart';

class NavBarItem {
  final IconData icon;
  final String title;
  final Widget view;

  NavBarItem(this.icon, this.title, this.view);
}

class LandingView extends StatelessWidget {
  const LandingView({required this.navBarItems});

  final List<NavBarItem> navBarItems;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingViewModel>.reactive(
      viewModelBuilder: () => LandingViewModel(navBarItems),
      builder: (_, model, __) {
        return Scaffold(
          body: _Body(model, navBarItems),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final LandingViewModel model;
  final List<NavBarItem> navBarItems;
  const _Body(this.model, this.navBarItems);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: model.getViewForIndex(model.currentTabIndex)),
        AppBaseCard(
          margin: AppBaseStyles.horizontalPadding,
          padding: EdgeInsets.zero,
          boxShadowOpacity: .1,
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  navBarItems.length,
                  (index) {
                    final item = navBarItems[index];
                    final isActive = model.currentTabIndex == index;
                    final color =
                        isActive ? AppColors.primaryColor : AppColors.gray;
                    return InkResponse(
                      radius: 50,
                      containedInkWell: false,
                      highlightColor: AppColors.primaryColor.withOpacity(.15),
                      overlayColor: MaterialStateProperty.all(Colors.white),
                      onTap: () => model.currentTabIndex = index,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                          children: [
                            Icon(item.icon, color: color),
                            VerticalSpacing(6),
                            Text(
                              item.title,
                              style: AppTextStyles.xSmall(color: color),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        VerticalSpacing(AppSpacing(context).bottomSpacing.height! - 12),
      ],
    );
  }
}
