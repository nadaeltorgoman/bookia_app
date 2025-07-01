import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/home/data/model/response/best_seller/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishListBuilder extends StatelessWidget {
  const WishListBuilder({
    super.key,
    required this.books,
    required this.onRemove,
    required this.onAddToCart,
  });

  final List<Product> books;
  final Function(int) onRemove;
  final Function(int) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var book = books[index];
        return Row(
          children: [
            Hero(
              // tag: bestSellers[index].id ?? '',
              tag: book.id ?? index,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: book.image ?? AppAssets.backgroundImage,
                  width: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) => const Icon(
                        Icons.error,
                        color: AppColors.blackColor,
                        size: 30,
                      ),
                ),
              ),
            ),
            Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          book.name ?? 'No Title',
                          style: AppTextStyle.getTitleText(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: AppColors.blackColor,
                        ),
                        onPressed: () {
                          onRemove(book.id ?? 0);
                        },
                      ),
                    ],
                  ),
                  const Gap(5),
                  Text(
                    book.price ?? 'No Price',
                    style: AppTextStyle.getBodyText(),
                  ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: MainButton(
                          onPressed: () {
                            onAddToCart(book.id ?? 0);
                          },
                          title: 'Add to Cart',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Gap(10);
      },
      itemCount: books.length ,
    );
  }
}
