import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({this.rightSide = true});

  final bool rightSide;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        thickness: 2,
        color: AppColors.primaryColor.withOpacity(.16),
        endIndent: rightSide ? 18 : 0,
        indent: rightSide ? 0 : 18,
      ),
    );
  }
}
