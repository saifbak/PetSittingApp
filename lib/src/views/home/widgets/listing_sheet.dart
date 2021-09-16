import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class ListingSheet extends StatelessWidget {
  const ListingSheet({
    required this.list,
  });
  final List<PetSitter> list;

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final sitter = list[index];
                  return GestureDetector(
                    onTap: () {
                      NavService.popOut;
                      NavService.profile();
                    },
                    child: AppBaseCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.whisper,
                              image: DecorationImage(
                                image: AssetImage(sitter.imgUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          HorizontalSpacing(10),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sitter.name,
                                      style: AppTextStyles.xLarge(
                                        weight: FontWeight.w500,
                                      ),
                                    ),
                                    VerticalSpacing(6),
                                    Row(
                                      children: [
                                        Icon(
                                          IconlyBold.location,
                                          size: 16,
                                          color: AppColors.primaryColor,
                                        ),
                                        HorizontalSpacing(4),
                                        Text(
                                          sitter.location,
                                          style: AppTextStyles.xxMedium(
                                            color: AppColors.darkGray,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.more_vert_rounded,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => VerticalSpacing(16),
                itemCount: list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
