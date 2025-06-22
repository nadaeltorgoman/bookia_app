import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        socialCard(AppAssets.facebookIcon, () {
          // Handle Facebook login
        }),
        socialCard(AppAssets.googleIcon, () {
          // Handle Google login
        }),
        socialCard(AppAssets.appleIcon, () {
          // Handle Apple login
        }),
      ],
    );
  }

  InkWell socialCard(String? assetName, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          assetName ?? AppAssets.facebookIcon,
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
