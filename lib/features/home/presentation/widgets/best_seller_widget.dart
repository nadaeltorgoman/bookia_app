import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/home/data/model/response/best_seller/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                mainAxisExtent: 280,
              ),
              itemCount: bestSellers.isEmpty ? 4 : bestSellers.length,
              itemBuilder: (context, index) {
                if (bestSellers.isEmpty) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    context.navigateTo(AppRouters.bookDetails, arguments: bestSellers[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(11.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.borderColor,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: bestSellers[index].id ?? '',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:bestSellers[index].image ?? AppAssets.backgroundImage,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  color: AppColors.errorColor,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        SizedBox(
                          height: 50,
                          child: Text(
                            bestSellers[index].name ?? 'No Title',
                            style: AppTextStyle.getBodyText(color: AppColors.darkColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${(double.tryParse(bestSellers[index].price ?? '')?.toStringAsFixed(2) ?? '0.00')}',
                              style: AppTextStyle.getSmallText(
                                color: AppColors.darkColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            MainButton(
                              title: 'Buy',
                              colorBorderSide: Colors.transparent,
                              onPressed: () {
                                // Handle add to cart action
                              },
                              width: 74,
                              height: 37,
                              bgColor: AppColors.darkColor,
                            ),
                          ],
                        ),
                      ],
                    ),
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
