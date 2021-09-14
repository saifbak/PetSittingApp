import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/base/utils/utils.dart';

class VerticalSpacing extends SizedBox {
  const VerticalSpacing([double height = 8]) : super(height: height);
}

class HorizontalSpacing extends SizedBox {
  const HorizontalSpacing([double width = 8]) : super(width: width);
}

class AppSpacing {
  final BuildContext _context;

  AppSpacing(this._context);

  VerticalSpacing get bottomSpacing =>
      VerticalSpacing(_context.screenSize().height * .035);
}
