import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

enum AvailabilityStatus {
  availabile,
  unavailable,
}

class AppDateAvailabilityTile extends StatelessWidget {
  const AppDateAvailabilityTile({
    required this.date,
    required this.status,
  });

  final String date;
  final AvailabilityStatus status;

  @override
  Widget build(BuildContext context) {
    late Color color, bgColor;
    FontWeight? fontWeight;

    if (status == AvailabilityStatus.availabile) {
      color = Colors.white;
      bgColor = AppColors.primaryColor;
      fontWeight = FontWeight.w500;
    } else {
      color = AppColors.primaryColor;
      bgColor = Colors.white;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Icon(
            IconlyLight.calendar,
            size: 20,
            color: color,
          ),
          HorizontalSpacing(6),
          Text(
            date,
            style: AppTextStyles.xxLarge(color: color, weight: fontWeight),
          ),
          Spacer(),
          Text(
            '${describeEnum(status)[0].toUpperCase()}${describeEnum(status).substring(1, describeEnum(status).length)}',
            style: AppTextStyles.xxLarge(color: color, weight: fontWeight),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
    );
  }
}
