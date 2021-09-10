import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class AppLabelText extends StatelessWidget {
  const AppLabelText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.xxLarge(
        weight: FontWeight.w500,
        color: AppColors.darkGray,
      ),
    );
  }
}
