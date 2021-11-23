import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_base_card.dart';
import 'package:whiskers_away_app/src/shared/app_status_visibility_tag.dart';
import 'package:whiskers_away_app/src/shared/image_display_box.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/home/home_view_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({required this.notification});

  final Map<String, dynamic> notification;

  @override
  Widget build(BuildContext context) {
    print('Card===>Notification');
    print(notification!['message']);
    return AppBaseCard(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            IconlyBold.notification,
            size: 30,
            color: AppColors.primaryColor,
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
                        Container(
                          width: 250.0,
                          child: Text(
                            notification['message'] ?? '',
                            style: AppTextStyles.xLarge(
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                        VerticalSpacing(6),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       // notification['price'] != null
                    //       //     ? '\$' + notification['price']
                    //       //     :
                    //       '',
                    //       style: AppTextStyles.xLarge(
                    //         weight: FontWeight.w500,
                    //         color: AppColors.primaryColor,
                    //       ),
                    //     ),
                    //     HorizontalSpacing(4),
                    //     GestureDetector(
                    //         child: AppStatusVisibilityTag(text: 'Pay now'),
                    //         onTap: () {
                    //           NavService.payment();
                    //         })
                    //   ],
                    // ),
                  ],
                ),
                // Text('Total Bookings'),
                VerticalSpacing(12),
                // Row(
                //   children: [
                //     /* Icon(
                //       IconlyBold.bookmark,
                //       size: 16,
                //       color: AppColors.primaryColor,
                //     ),
                //     HorizontalSpacing(4),
                //     Text(
                //       '${5}',
                //       style: AppTextStyles.xxMedium(
                //         color: AppColors.darkGray,
                //       ),
                //     ), */
                //     Spacer(),
                //     notification != null
                //         ? Icon(
                //             IconlyBold.location,
                //             size: 16,
                //             color: AppColors.primaryColor,
                //           )
                //         : Container(),
                //     HorizontalSpacing(4),
                //     Text(
                //       // notification['petsitter']['address'] ??
                //       '',
                //       style: AppTextStyles.xxMedium(
                //         color: AppColors.darkGray,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
