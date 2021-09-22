import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class PetSitterCard extends StatelessWidget {
  const PetSitterCard({required this.petSitter});

  final Map<String, dynamic> petSitter;

  @override
  Widget build(BuildContext context) {
    //print(petSitter.hourlyRates);
    return AppBaseCard(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageDisplayBox(size: 60, imgUrl: 'assets/images/profile_pic.jpg'),
          HorizontalSpacing(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          petSitter['name'],
                          style: AppTextStyles.xLarge(
                            weight: FontWeight.w500,
                          ),
                        ),
                        VerticalSpacing(6),
                      ],
                    ),
                    Text(
                      '\$' + petSitter['hourly_rate'] + '/hr',
                      style: AppTextStyles.xLarge(
                        weight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                // Text('Total Bookings'),
                VerticalSpacing(2),
                Row(
                  children: [
                    /* Icon(
                      IconlyBold.bookmark,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                    HorizontalSpacing(4),
                    Text(
                      '${5}',
                      style: AppTextStyles.xxMedium(
                        color: AppColors.darkGray,
                      ),
                    ), */
                    Spacer(),
                    Icon(
                      IconlyBold.location,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                    HorizontalSpacing(4),
                    Text(
                      petSitter['address'],
                      style: AppTextStyles.xxMedium(
                        color: AppColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
