import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_text_style.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:bookia/components/app_bar/main_app_bar_widget.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/data/model/response/best_seller/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Product book;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddedToWishList) {
            context.pop();
            showSuccessSnackbar(context, '${book.name} ${state.message}');
          } else if (state is HomeError) {
            context.pop();
            showErrorSnackbar(context, 'Error fetching book details');
          } else if (state is HomeLoading) {
            showLoadingDialog(context);
          } else if (state is HomeLoaded) {
            //Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            //appBar: PreferredSize(preferredSize: Size.fromHeight(56), child: MainAppBarWidget()),
            appBar: MainAppBarWidget(
              action: IconButton(
                onPressed: () {
                  // Handle bookmark action
                  context.read<HomeCubit>().addToWishList(book.id ?? 0);
                },
                icon: SvgPicture.asset(AppAssets.bookmarkIcon),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      const Gap(30),
                      Hero(
                        tag: book.id ?? '',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: book.image ?? AppAssets.backgroundImage,
                            width: 200,
                            fit: BoxFit.cover,
                            errorWidget:
                                (context, url, error) => const Icon(
                                  Icons.error,
                                  color: AppColors.errorColor,
                                  size: 30,
                                ),
                          ),
                        ),
                      ),
                      const Gap(15),
                      Text(
                        book.name ?? 'No Title',
                        style: AppTextStyle.getHeadline1(
                          color: AppColors.darkColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(10),
                      Text(
                        book.category ?? 'Unknown Category',
                        style: AppTextStyle.getBodyText(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Gap(15),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        style: AppTextStyle.getSmallText(
                          color: AppColors.darkColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${(double.tryParse(book.price ?? '')?.toStringAsFixed(2) ?? '0.00')}',
                    style: AppTextStyle.getHeadline2(
                      color: AppColors.darkColor,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: MainButton(
                      title: 'Add to Cart',
                      bgColor: AppColors.darkColor,
                      colorBorderSide: Colors.transparent,
                      onPressed: () {
                        // Handle add to cart action
                        context.read<HomeCubit>().addToCart(book.id ?? 0);
                        
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
