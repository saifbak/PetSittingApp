import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/configs/app_setup.router.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class ApprovedCard extends StatelessWidget {
  const ApprovedCard({required this.petSitter});

  final Map<String, dynamic> petSitter;

  @override
  Widget build(BuildContext context) {
    print(petSitter['job']['period']);
    return AppBaseCard(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageDisplayBox(
            size: 60,
            imgUrl: petSitter['images'].length > 0
                ? petSitter['images'][0]['image_url']
                : '',
            assetDefaultImage: 'pet.jpg',
          ),
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
                          petSitter['job']['pet_name'] ?? '',
                          style: AppTextStyles.xLarge(
                            weight: FontWeight.w500,
                          ),
                        ),
                        VerticalSpacing(6),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          petSitter['price'] != null
                              ? '\$' + petSitter['price']
                              : '',
                          style: AppTextStyles.xLarge(
                            weight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        HorizontalSpacing(4),
                        GestureDetector(
                            child: AppStatusVisibilityTag(text: 'Pay now'),
                            onTap: () {
                              NavService.payment(
                                  arguments: PaymentViewArguments(
                                user: petSitter,
                              ));
                            })
                      ],
                    ),
                  ],
                ),
                // Text('Total Bookings'),
                // VerticalSpacing(12),
                Row(
                  children: [
                    petSitter['petsitter']['name'] != null
                        ? Icon(
                            IconlyBold.profile,
                            size: 16,
                            color: AppColors.primaryColor,
                          )
                        : Container(),
                    HorizontalSpacing(4),
                    Text(
                      petSitter['petsitter']['name'] ?? '',
                      style: AppTextStyles.xxMedium(
                        color: AppColors.darkGray,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        // petSitter['petsitter']['address'] != null
                        //     ? Icon(
                        //         IconlyBold.location,
                        //         size: 16,
                        //         color: AppColors.primaryColor,
                        //       )
                        //     : Container(),
                        // HorizontalSpacing(4),
                        // Text(
                        //   petSitter['petsitter']['address'] ?? '',
                        //   style: AppTextStyles.xxMedium(
                        //     color: AppColors.darkGray,
                        //   ),
                        // ),
                        // HorizontalSpacing(4),
                        Text(
                          petSitter['job']['period'] ?? '',
                          style: AppTextStyles.xMedium(
                            weight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
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
