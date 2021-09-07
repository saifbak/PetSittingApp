import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    this.textRight = true,
  });
  final bool? textRight;

  @override
  Widget build(BuildContext context) {
    final textColor = textRight! ? Colors.white : AppColors.primaryColor;

    final text = MultiStyleText(
      firstText: textRight! ? 'I am' : 'I need',
      firstTextStyle: AppTextStyles.heading(color: textColor),
      secondText: '\na pet sitter',
      secondTextStyle: AppTextStyles.heading(
        color: textColor,
        weight: FontWeight.w400,
      ),
    );

    final image = Image.asset(
      'assets/images/illustration_${textRight! ? '1' : '2'}.png',
      width: 100,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Spacer(),
          if (textRight!) image else text,
          Spacer(
            flex: textRight! ? 1 : 2,
          ),
          if (textRight!) text else image,
          Spacer(
            flex: textRight! ? 2 : 1,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: textRight! ? AppColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: textRight! ? Colors.transparent : AppColors.primaryColor,
        ),
      ),
    );
  }
}
