import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class AppBaseCard extends StatelessWidget {
  const AppBaseCard({
    required this.child,
    this.borderRadius = 16,
    this.boxShadowBlur,
    this.boxShadowOffset,
    this.boxShadowOpacity,
    this.margin,
    this.padding,
  });

  final Widget child;
  final double? boxShadowBlur;
  final double? boxShadowOpacity;
  final Offset? boxShadowOffset;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: this.margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius!),
        boxShadow: [
          AppUtils.boxShadow1(
            blurRadius: boxShadowBlur,
            colorOpacity: boxShadowOpacity,
            offset: boxShadowOffset,
          )
        ],
      ),
      child: this.child,
    );
  }
}
