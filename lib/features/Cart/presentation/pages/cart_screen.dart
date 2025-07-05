import 'dart:developer';

import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/features/Cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/Cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/Cart/presentation/widgets/cart_builder.dart';
import 'package:bookia/components/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: BlocConsumer<CartCubit, CartState>(listener: cubitListener, builder: cubitBuilder),
      ),
    );
  }

  void cubitListener(BuildContext context, CartState state) {
    log('Cart state: $state');
    if (state is CartError) {
      // Navigator.pop(context);
      context.pop();
      log('cartError: ${state.message}');
      showErrorSnackbar(context, state.message);
    } else if (state is CartItemRemovedSuccessfully) {
      context.pop();
      log('Item removed from Cart');
      showSuccessSnackbar(context, 'Item removed from Cart');
    } else if (state is RemoveFromCartLoading) {
      log('Removing item from Cart...');

      showLoadingDialog(context);
    } else if (state is CartUpdatedSuccessfully) {
      context.pop();
      log('Cart updated successfully');
      showSuccessSnackbar(context, 'Cart updated successfully');
    } else if (state is UpdateCartLoading) {
      log('Updating cart...');
      showLoadingDialog(context);
    }
  }

  Widget cubitBuilder(BuildContext context, CartState state) {
    var cubit = context.read<CartCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:
          cubit.cartResponse?.data?.cartItems?.isEmpty == true
              ? EmptyWidget(message: 'Cart', icon: Icons.remove_shopping_cart_outlined)
              : CartBuilder(
                books: cubit.cartResponse?.data?.cartItems ?? [],
                onRemove: (productId) {
                  log('Removing item with ID: $productId');
                  cubit.removeFromCart(productId);
                },
                onUpdateQuantity: (updateParams) {
                  log(
                    'Updating item with ID: ${updateParams.cartItemId} to quantity: ${updateParams.quantity}',
                  );
                  cubit.updateCart(updateParams);
                },
              ),
    );
  }
}
