import 'package:bookia/features/Cart/data/model/get_cart_response/get_cart_response.dart';
import 'package:bookia/features/Cart/data/model/update_cart_params.dart';
import 'package:bookia/features/Cart/data/repo/cart_repo.dart';
import 'package:bookia/features/Cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  GetCartResponse? cartResponse = GetCartResponse();

  Future<void> getCartData() async {
    emit(CartLoading());
    try {
      var response = await CartRepo().getCart();
      if (response != null) {
        cartResponse = response;
        emit(CartLoaded());
      } else {
        emit(CartError(message: '${response?.message}: Failed to load cart'));
      }
    } catch (_) {
      emit(CartError(message: 'An error occurred'));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    emit(RemoveFromCartLoading());
    try {
      var response = await CartRepo.removeFromCart(cartItemId);
      if (response != null) {
        cartResponse = response;
        emit(CartItemRemovedSuccessfully());
      } else {
        emit(CartError(message: '${response?.message}: Failed to remove item from cart'));
      }
    } catch (_) {
      emit(CartError(message: 'An error occurred'));
    }
  }

  Future<void> updateCart(UpdateCartParams params) async {
    emit(UpdateCartLoading());
    try {
      var response = await CartRepo.updateCart(params);
      if (response != null) {
        cartResponse = response;
        emit(CartUpdatedSuccessfully());
      } else {
        emit(CartError(message: '${response?.message}: Failed to update cart'));
      }
    } catch (_) {
      emit(CartError(message: 'An error occurred while updating the cart'));
    }
  }
}
