import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomRowWidget extends StatelessWidget {
  const CustomRowWidget({super.key, required this.title, required this.onPressed});
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyColor.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyle.getBodyText(color: AppColors.blackColor)),
              const SizedBox(height: 10),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.blackColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
