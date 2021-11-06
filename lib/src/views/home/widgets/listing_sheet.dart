import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/pet_sitter_card.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class ListingSheet extends StatelessWidget {
  const ListingSheet({
    required this.list,
  });
  final List<Map<String, dynamic>> list;

  @override
  Widget build(BuildContext context) {
    print(list);
    final screenSize = context.screenSize();
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      constraints: BoxConstraints(
        maxHeight: screenSize.height * .8,
        minHeight: screenSize.height * .8,
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
            Text(
              'Pet Sitters',
              style: AppTextStyles.large(
                color: AppColors.primaryColor,
                weight: FontWeight.w500,
              ),
            ),
            VerticalSpacing(4),
            Text('Available Pet Sitters for this request'),
            VerticalSpacing(8),
            // ignore: unnecessary_null_comparison
            list.length > 0
                ? Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final sitter = list[index];
                        return GestureDetector(
                            onTap: () {
                              NavService.popOut;
                              NavService.profile(
                                  arguments: ProfileViewArguments(
                                user: sitter,
                              ));
                            },
                            child: PetSitterCard(petSitter: sitter));
                      },
                      separatorBuilder: (_, __) => VerticalSpacing(16),
                      itemCount: list.length,
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        'No sitters have responded yet, check back soon!',
                        style:
                            AppTextStyles.xLarge(color: AppColors.primaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
