import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/core/utils/app_theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final Color? colorBorderSide;
  const MainButton({
    super.key,
    this.title,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.colorBorderSide,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 55,
      width: width ?? context.screenWidth * 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color:
                  colorBorderSide ?? AppTheme.lightTheme().colorScheme.primary,
            ),
          ),
          backgroundColor: bgColor ?? AppTheme.lightTheme().colorScheme.primary,
        ),
        child: Text(
          title ?? 'Login',
          style: AppTextStyle.getButton(
            color: textColor ?? AppTheme.lightTheme().colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
