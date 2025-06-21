import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() => ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.darkColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    fontFamily: 'DMSerifDisplay',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.whiteColor,
      surface: AppColors.whiteColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.darkColor,
      onSurface: AppColors.darkColor,
      onError: AppColors.errorColor,
    ),
    dividerTheme: DividerThemeData(color: AppColors.borderColor, thickness: 1, space: 20),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.accentColor,
      hintStyle: AppTextStyle.getSmallText(color: AppColors.greyColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.darkColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.errorColor),
      ),
    ),
  );

  static ThemeData darkTheme() => ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    fontFamily: 'DMSerifDisplay',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.greyColor,
      surface: AppColors.darkColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
      onSurface: AppColors.whiteColor,
      onError: AppColors.errorColor,
    ),
  );
}
