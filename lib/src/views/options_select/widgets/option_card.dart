import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/core/enums/role_enum.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';
import 'package:whiskers_away_app/src/views/options_select/options_select_view_model.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    required this.role,
    required this.isSelected,
  });
  final Role role;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final petSitter = role == Role.PET_SITTER;

    final textColor = isSelected ? Colors.white : AppColors.primaryColor;

    final text = MultiStyleText(
      firstText: petSitter ? 'I am' : 'I need',
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
          left: petSitter ? 9 : 0,
          child: Image.asset(
            'assets/images/illustration_${petSitter ? '2' : '1'}.png',
            width: 90,
          ),
        ),
      ],
    );

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Spacer(),
          if (petSitter) image else text,
          Spacer(
            flex: petSitter ? 1 : 2,
          ),
          if (petSitter) text else image,
          Spacer(
            flex: petSitter ? 2 : 1,
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
        ],
      ),
    );
  }
}
