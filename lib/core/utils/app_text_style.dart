import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle getHeadline1({double? fontSize, FontWeight? fontWeight, Color? color}) =>
      TextStyle(
        fontSize: fontSize ?? 30,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.darkColor,
      );

  static TextStyle getHeadline2({double? fontSize, FontWeight? fontWeight, Color? color}) =>
      TextStyle(
        fontSize: fontSize ?? 24,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.darkColor,
      );

  static TextStyle getTitleText({double? fontSize, FontWeight? fontWeight, Color? color}) =>
      TextStyle(
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.darkColor,
      );

  static TextStyle getSmallText({double? fontSize, FontWeight? fontWeight, Color? color}) =>
      TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.greyColor,
      );

  static TextStyle getBodyText({double? fontSize, FontWeight? fontWeight, Color? color}) =>
      TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.greyColor,
      );

  static TextStyle getButton({double? fontSize, FontWeight? fontWeight, Color? color}) => TextStyle(
    fontSize: fontSize ?? 14,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color ?? AppColors.darkColor,
  );
}
