import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class RatingDisplayBox extends StatefulWidget {
  final String text;
  final ValueChanged<int> rating;

  const RatingDisplayBox({required this.text, required this.rating});

  @override
  _RatingDisplayBoxState createState() => _RatingDisplayBoxState();
}

class _RatingDisplayBoxState extends State<RatingDisplayBox> {
  int _ratingCount = 0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Would you hire again?',
              style: AppTextStyles.xxLarge(weight: FontWeight.w500),
            ),
            VerticalSpacing(),
            Row(
              children: [
                RatingBar(
                  glow: false,
                  itemSize: 28,
                  ratingWidget: RatingWidget(
                    empty: Icon(
                      Icons.star_border,
                      color: AppColors.primaryColor,
                    ),
                    half: Icon(
                      Icons.star_half,
                      color: AppColors.primaryColor,
                    ),
                    full: Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  onRatingUpdate: (updatedCount) {
                    setState(() => _ratingCount = updatedCount.toInt());
                    widget.rating(_ratingCount);
                  },
                ),
                HorizontalSpacing(),
                Text(
                  '(${_ratingCount.toInt()}/5)',
                  style: AppTextStyles.xLarge(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
