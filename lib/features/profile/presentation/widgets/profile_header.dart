import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/services/cache_helper.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var userInfo = SharedPref.getUserInfo();
    return Row(
      children: [
        if (userInfo?.image?.isNotEmpty == true)
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: userInfo?.image ?? AppAssets.backgroundImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorWidget:
                  (context, url, error) =>
                      const Icon(Icons.error, color: AppColors.blackColor, size: 30),
            ),
          ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userInfo?.name ?? 'User Name',
              style: AppTextStyle.getTitleText(color: AppColors.blackColor),
            ),
            const SizedBox(height: 10),
            Text(userInfo?.email ?? 'user.email@example.com', style: AppTextStyle.getBodyText()),
          ],
        ),
      ],
    );
  }
}
