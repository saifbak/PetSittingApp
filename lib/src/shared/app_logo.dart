import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';
import 'package:whiskers_away_app/src/shared/spacing.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize();

    return Container(
      width: width ?? screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/image.png'),
          VerticalSpacing(screenSize.height * .025),
          Hero(
            tag: 'logo_text',
            child: Text(
              'Pet Sitting',
              style: TextStyle(
                  fontSize: screenSize.height * 0.03,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600),
            ),
            // Image.asset('assets/images/logo_text.png'),
          ),
        ],
      ),
    );
  }
}
