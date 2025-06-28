import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/home/data/model/response/best_seller/product.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellerWidget extends StatelessWidget {
  const BestSellerWidget({super.key, required this.bestSellers});
  final List<Product> bestSellers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Best Sellers', style: AppTextStyle.getHeadline2(), textAlign: TextAlign.start),
          const Gap(10),
          Skeletonizer(
            enabled: bestSellers.isEmpty,
            containersColor: AppColors.borderColor,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 200,
              ),
              itemCount: bestSellers.isEmpty ? 4 : bestSellers.length,
              itemBuilder: (context, index) {
                if (bestSellers.isEmpty) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    bestSellers[index].image ?? AppAssets.backgroundImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
