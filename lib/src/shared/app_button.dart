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
    this.child,
    this.isDisabled = false,
    this.dangerColor = false,
  });

  final AppButtonType type;
  final String text;
  final bool fullWidth;
  final VoidCallback? onPressed;
  final double? horizontalPadding;
  final Widget? child;
  final bool? isDisabled;
  final bool? dangerColor;

  @override
  Widget build(BuildContext context) {
    final buttonTypeSolid = type == AppButtonType.solid ? true : false;

    final buttonText = Center(
      child: child ??
          Text(
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
          color: !isDisabled!
              ? Colors.transparent.withOpacity(1)
              : Colors.transparent.withOpacity(0.4),
          borderRadius: borderRadius,
          gradient: LinearGradient(
              colors: dangerColor!
                  ? [
                      Color(0xFFB22222),
                      Color(0xFF8B0000),
                    ]
                  : [
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
          /* color: !isDisabled!
              ? Colors.transparent.withOpacity(1)
              : Colors.transparent.withOpacity(0.5), */
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
