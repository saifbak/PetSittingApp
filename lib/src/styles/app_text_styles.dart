import 'package:flutter/material.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';

class AppTextStyles extends TextStyle {
  AppTextStyles._([String fontFamily = 'Airbnb Cereal'])
      : super(fontFamily: fontFamily);

  static TextStyle heading({Color? color}) {
    final fontColor = color ?? AppColors.primaryColor;

    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: fontColor,
    );
  }

  static TextStyle xxSmall({Color? color, FontWeight? weight}) {
    final fontColor = color ?? Colors.black;
    final fontWeight = weight ?? FontWeight.w400;

    return TextStyle(
      fontSize: 10,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }

  static TextStyle xSmall({Color? color, FontWeight? weight}) {
    final fontColor = color ?? Colors.black;
    final fontWeight = weight ?? FontWeight.w400;

    return TextStyle(
      fontSize: 11,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }

  static TextStyle xxMedium({Color? color, FontWeight? weight}) {
    final fontColor = color ?? Colors.black;
    final fontWeight = weight ?? FontWeight.w400;

    return TextStyle(
      fontSize: 12,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }

  static TextStyle xMedium({Color? color, FontWeight? weight}) {
    final fontColor = color ?? Colors.black;
    final fontWeight = weight ?? FontWeight.w400;

    return TextStyle(
      fontSize: 13,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }

  static TextStyle xxLarge({Color? color, FontWeight? weight}) {
    final fontColor = color ?? Colors.black;
    final fontWeight = weight ?? FontWeight.w400;

    return TextStyle(
      fontSize: 14,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }

  static TextStyle xLarge({Color? color, FontWeight? weight}) {
    final fontColor = color ?? Colors.black;
    final fontWeight = weight ?? FontWeight.w400;

    return TextStyle(
      fontSize: 16,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }
}
