import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/services/local/navigation_service.dart';
import 'package:whiskers_away_app/src/shared/app_heading.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_base_styles.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    required this.text,
    this.color,
    this.centerText = false,
  });

  final String text;
  final Color? color;
  final bool? centerText;

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    final backButtonSplashColor = AppColors.primaryColor.withOpacity(.1);

    return Container(
      padding: AppBaseStyles.horizontalPadding,
      margin:
          EdgeInsets.only(top: context.topSpace() + screenSize.height * .05),
      child: Row(
        children: [
          IconButton(
            onPressed: () => NavService.popOut,
            splashRadius: 24,
            splashColor: backButtonSplashColor,
            focusColor: backButtonSplashColor,
            highlightColor: backButtonSplashColor,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.arrow_back_ios),
            color: color ?? AppColors.primaryColor,
          ),
          Spacer(),
          AppHeading(
            text: this.text,
            color: color,
          ),
          if (centerText!) HorizontalSpacing(30),
          Spacer(flex: centerText! ? 1 : 2),
        ],
      ),
    );
  }
}
