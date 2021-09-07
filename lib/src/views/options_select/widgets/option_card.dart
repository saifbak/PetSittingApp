import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    this.textRight = true,
    required this.isSelected,
    required this.onSelected,
  });
  final bool? textRight;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    bool check = isSelected;

    final textColor = isSelected ? Colors.white : AppColors.primaryColor;

    final text = MultiStyleText(
      firstText: textRight! ? 'I am' : 'I need',
      firstTextStyle: AppTextStyles.heading(color: textColor),
      secondText: '\na pet sitter',
      secondTextStyle: AppTextStyles.heading(
        color: textColor,
        weight: FontWeight.w400,
      ),
    );

    final image = Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/images/illustration_${isSelected ? '3' : '4'}.png',
          width: 90,
        ),
        Positioned(
          bottom: 0,
          top: 0,
          left: textRight! ? 9 : 0,
          child: Image.asset(
            'assets/images/illustration_${textRight! ? '2' : '1'}.png',
            width: 90,
          ),
        ),
      ],
    );

    return GestureDetector(
      onTap: () {
        check = !check;
        onSelected(check);
      },
      child: Container(
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
            color: isSelected ? AppColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? Colors.transparent : AppColors.primaryColor,
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 20,
                color: isSelected
                    ? AppColors.primaryColor.withOpacity(.2)
                    : Colors.transparent,
              ),
            ]),
      ),
    );
  }
}
