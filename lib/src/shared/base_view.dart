import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  const BaseView({
    required this.child,
    this.bgImageUrl,
  });

  final Widget child;
  final String? bgImageUrl;

  @override
  Widget build(BuildContext context) {
    if (bgImageUrl != null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  bgImageUrl!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          child,
        ],
      );
    }
    return child;
  }
}