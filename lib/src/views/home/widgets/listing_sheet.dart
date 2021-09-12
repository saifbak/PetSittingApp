import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class ListingSheet extends StatelessWidget {
  const ListingSheet({
    required this.request,
    required this.completer,
    required this.list,
  });

  final SheetRequest request;
  final Function(SheetResponse) completer;
  final List<PetSitter> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
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
          VerticalSpacing(12),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final sitter = list[index];
              return GestureDetector(
                onTap: () {
                  NavService.popOut;
                  NavService.profile();
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        color: Colors.black.withOpacity(.08),
                      ),
                    ],
                  ),
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
        ],
      ),
    );
  }
}
