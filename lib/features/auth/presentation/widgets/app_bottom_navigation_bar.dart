import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key, this.title, this.buttonText, this.onPressed});
  final String? title;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? 'Don\'t have an account?',
            style: AppTextStyle.getSmallText(color: AppColors.darkColor),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText ?? 'Login',
              style: AppTextStyle.getSmallText(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
