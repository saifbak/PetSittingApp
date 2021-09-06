import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

enum AppButtonType {
  solid,
  outline,
}

class AppButton extends StatelessWidget {
  const AppButton({
    this.type = AppButtonType.solid,
    required this.text,
    this.fullWidth = false,
    this.onPressed,
    this.horizontalPadding = 20,
  });

  final AppButtonType type;
  final String text;
  final bool fullWidth;
  final VoidCallback? onPressed;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final buttonTypeSolid = type == AppButtonType.solid ? true : false;

    final buttonText = Center(
      child: Text(
        text,
        style: AppTextStyles.xLarge(
          color: buttonTypeSolid ? Colors.white : AppColors.primaryColor,
        ),
      ),
    );
    final padding = EdgeInsets.symmetric(
      vertical: 10,
      horizontal: horizontalPadding!,
    );
    final borderRadius = BorderRadius.circular(10);

    final solidButton = GestureDetector(
      onTap: onPressed,
      child: Container(
        child: buttonText,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(colors: [
            Color(0xFF4ECEAF),
            Color(0xFF63DFC1),
          ]),
        ),
      ),
    );

    final outlineButton = GestureDetector(
      onTap: onPressed,
      child: Container(
        child: buttonText,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
      ),
    );

    final button = buttonTypeSolid ? solidButton : outlineButton;

    if (fullWidth) return Expanded(child: button);
    return button;
  }
}
