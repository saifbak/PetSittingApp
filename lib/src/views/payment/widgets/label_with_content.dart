import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/app_label_text.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class LabelWithContent extends StatelessWidget {
  const LabelWithContent({
    required this.labelText,
    this.contentIcon,
    required this.content,
  });

  final String labelText;
  final IconData? contentIcon;
  final dynamic content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: AppLabelText(text: labelText),
        ),
        VerticalSpacing(contentIcon != null ? 4 : 6),
        if (contentIcon != null)
          Row(
            children: [
              Icon(
                contentIcon,
                size: 20,
                color: AppColors.primaryColor,
              ),
              HorizontalSpacing(4),
              Text(
                content,
                style: AppTextStyles.xxMedium(
                  color: AppColors.darkGray,
                ),
              ),
            ],
          )
        else if (content is String)
          Text(
            content,
            style: AppTextStyles.xxMedium(
              color: AppColors.darkGray,
            ),
          )
        else
          content,
      ],
    );
  }
}
