import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

enum AppButtonType {
  solid,
  outline,
}

class AppButton extends StatelessWidget {
  const AppButton({
    this.type = AppButtonType.solid,
    required this.text,
    this.fullWidth = false,
  });

  final AppButtonType type;
  final String text;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    // TODO: styling of below text widget
    final buttonText = Center(
      child: Text('$text'),
    );
    final padding = const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    );
    final borderRadius = BorderRadius.circular(10);

    final solidButton = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
      ),
    );

    final outlineButton = Container(
      child: buttonText,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
    );

    final button = type == AppButtonType.solid ? solidButton : outlineButton;

    if (fullWidth) return Expanded(child: button);
    return button;
  }
}
