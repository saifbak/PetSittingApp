import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/shared/multi_style_text.dart';
import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: MultiStyleText(
        firstText: 'Welcome,',
        firstTextStyle: AppTextStyles.xLarge(),
        secondText: '\n$name',
        secondTextStyle: AppTextStyles.heading(),
      ),
    );
  }
}

class AppHeading extends StatelessWidget {
  const AppHeading({
    required this.text,
    this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.heading(color: this.color),
    );
  }
}
