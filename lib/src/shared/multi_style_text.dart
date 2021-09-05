import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

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
    return RichText(
      text: new TextSpan(
        text: firstText,
        style: firstTextStyle ??
            TextStyle(
              fontSize: 13,
              fontFamily: 'Airbnb Cereal',
              color: Color(0xFFB8B8B8),
            ),
        children: <TextSpan>[
          if (secondText != null)
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onPressed,
              text: secondText,
              style: secondTextStyle ??
                  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Airbnb Cereal',
                    color: AppColors.primaryColor,
                  ),
            )
        ],
      ),
    );
  }
}
