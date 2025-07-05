import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/Cart/data/model/get_cart_response/cart_item.dart';
import 'package:bookia/features/Cart/data/model/update_cart_params.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartBuilder extends StatelessWidget {
  const CartBuilder({
    super.key,
    required this.books,
    required this.onRemove,
    required this.onUpdateQuantity,
  });

  final List<CartItem> books;
  final Function(int) onRemove;
  final Function(UpdateCartParams) onUpdateQuantity;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var book = books[index];
        return Row(
          children: [
            Hero(
              // tag: bestSellers[index].id ?? '',
              tag: book.itemProductId ?? index,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: book.itemProductImage ?? AppAssets.backgroundImage,
                  width: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, color: AppColors.blackColor, size: 30),
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
                          book.itemProductName ?? 'No Title',
                          style: AppTextStyle.getTitleText(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel_outlined, color: AppColors.blackColor),
                        onPressed: () {
                          onRemove(book.itemId ?? 0);
                        },
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Text(
                        '\$${book.itemProductPriceAfterDiscount}',
                        style: AppTextStyle.getBodyText(color: AppColors.blackColor),
                      ),
                      // we can use a ternary operator to check if the discount is applied
                      // if (book.itemProductDiscount != null && book.itemProductDiscount != 0)...[]
                      // or use visibility widget to show/hide the discount price
                      if (book.itemProductDiscount != null && book.itemProductDiscount != 0)
                        const Gap(10),
                      Text(
                        '\$${book.itemProductPrice}',
                        style: AppTextStyle.getBodyText(
                          color: AppColors.greyColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.remove, color: AppColors.blackColor, size: 15),
                          onPressed: () {
                            if ((book.itemQuantity ?? 0) > 1) {
                              onUpdateQuantity(
                                UpdateCartParams(
                                  cartItemId: book.itemId ?? 0,
                                  quantity: (book.itemQuantity ?? 0) - 1,
                                ),
                              );
                            } else {
                              showErrorSnackbar(context, 'Quantity cannot be less than 1');
                            }
                          },
                        ),
                      ),
                      const Gap(10),
                      Text(
                        '${book.itemQuantity}',
                        style: AppTextStyle.getBodyText(color: AppColors.blackColor),
                      ),
                      const Gap(10),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: AppColors.blackColor, size: 15),
                          onPressed: () {
                            if ((book.itemQuantity ?? 0) < (book.itemProductStock ?? 0)) {
                              onUpdateQuantity(
                                UpdateCartParams(
                                  cartItemId: book.itemId ?? 0,
                                  quantity: (book.itemQuantity ?? 0) + 1,
                                ),
                              );
                            } else {
                              showErrorSnackbar(
                                context,
                                'Quantity cannot exceed stock "${book.itemProductStock}"',
                              );
                            }
                          },
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$${book.itemTotal?.toStringAsFixed(2)}',
                        style: AppTextStyle.getBodyText(color: AppColors.primaryColor),
                      ),
                      const Gap(10),
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
      itemCount: books.length,
    );
  }
}
