import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.not_interested_rounded,
            size: 100,
            color: AppColors.primaryColor,
          ),
          const Gap(20),
          const Center(child: Text('No items in wishlist')),
        ],
      ),
    );
  }
}
