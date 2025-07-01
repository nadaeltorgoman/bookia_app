import 'dart:developer';

import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/features/wishList/presentation/cubit/wish_list_cubit.dart';
import 'package:bookia/features/wishList/presentation/cubit/wish_list_state.dart';
import 'package:bookia/features/wishList/presentation/widgets/empty_widget.dart';
import 'package:bookia/features/wishList/presentation/widgets/wish_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishListCubit()..getWishListData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Wishlist')),
        body: BlocConsumer<WishListCubit, WishListState>(
          listener: cubitListener,
          builder: cubitBuilder,
        ),
      ),
    );
  }

  void cubitListener(BuildContext context, WishListState state) {
          log('Wishlist state: $state');
          if (state is WishListError) {
            // Navigator.pop(context);
            context.pop();
            log('Error fetching wishlist data');
            showErrorSnackbar(context, 'Error fetching wishlist data');
          } else if (state is WishListItemRemovedSuccessfully) {
            context.pop();
            log('Item removed from wishlist');
            showSuccessSnackbar(context, 'Item removed from wishlist');
          } else if (state is RemoveFromWishListLoading) {
            log('Removing item from wishlist...');
  
            showLoadingDialog(context);
          }
        }

  Widget cubitBuilder(BuildContext context, WishListState state) {
    var cubit = context.read<WishListCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: cubit.wishListResponse?.data?.data?.isEmpty == true
                    ? EmptyWidget()
                    : WishListBuilder(
                      books: cubit.wishListResponse?.data?.data ?? [],
                      onRemove: (productId) {
                        log('Removing item with ID: $productId');
                        cubit.removeFromWishList(productId);
                      },
                      onAddToCart: (productId) {
                        log('Adding item to cart with ID: $productId');
                        // Implement add to cart functionality here
                      },
                    ),
          );
        }
}
