import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class MultiStyleText extends StatelessWidget {
  const MultiStyleText({
    this.onPressed,
    required this.firstText,
    this.firstTextStyle,
    this.secondText,
    this.secondTextStyle,
  });

  final VoidCallback? onPressed;
  final String firstText;
  final TextStyle? firstTextStyle;
  final String? secondText;
  final TextStyle? secondTextStyle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: firstTextStyle ??
                AppTextStyles.xMedium(color: Color(0xFFB8B8B8)),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onPressed,
            text: secondText,
            style: secondTextStyle ??
                AppTextStyles.xxLarge(
                  color: AppColors.primaryColor,
                  weight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
